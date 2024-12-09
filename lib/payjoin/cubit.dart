import 'dart:io';
import 'dart:typed_data';

import 'package:bb_mobile/_pkg/payjoin.dart';
import 'package:bb_mobile/_pkg/wallet/bdk/sensitive_create.dart';
import 'package:bb_mobile/_pkg/wallet/repository/network.dart';
import 'package:bb_mobile/_pkg/wallet/repository/sensitive_storage.dart';
import 'package:bb_mobile/_pkg/wallet/repository/wallets.dart';
import 'package:bb_mobile/payjoin/state.dart';
import 'package:bb_mobile/wallet/bloc/wallet_bloc.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payjoin_flutter/bitcoin_ffi.dart';
import 'package:payjoin_flutter/common.dart';
import 'package:payjoin_flutter/receive.dart';

class PayjoinCubit extends Cubit<PayjoinState> {
  PayjoinCubit({
    required this.walletBloc,
    required this.walletsRepository,
    required this.networkRepository,
    required this.bdkSensitiveCreate,
    required this.walletSensitiveStorageRepository,
  }) : super(const PayjoinState());

  final WalletBloc walletBloc;
  final WalletsRepository walletsRepository;
  final NetworkRepository networkRepository;

  final BDKSensitiveCreate bdkSensitiveCreate;
  final WalletSensitiveStorageRepository walletSensitiveStorageRepository;

  late bdk.Wallet bdkWallet;

  final address = TextEditingController();
  final satoshis = TextEditingController();
  final form = GlobalKey<FormState>();

  Future<void> init() async {
    final wallet = walletBloc.state.wallet!;

    final (seed, errRead) = await walletSensitiveStorageRepository.readSeed(
      fingerprintIndex: wallet.getRelatedSeedStorageString(),
    );

    final (bdkW, errLoad) =
        await bdkSensitiveCreate.loadPrivateBdkWallet(wallet, seed!);

    bdkWallet = bdkW!;

    final lastUnused = bdkWallet.getAddress(
      addressIndex: const bdk.AddressIndex.lastUnused(),
    );

    print(lastUnused.address);
    address.text = lastUnused.address.toString();
  }

  void clearToast() => state.copyWith(toast: '');
  void toggleReceiver(bool v) => emit(state.copyWith(isReceiver: v));

  String? validateSatoshis(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    try {
      BigInt.from(int.parse(value));
    } catch (_) {
      return 'Invalid number';
    }
    return null;
  }

  Future<void> clickCreateInvoice() async {
    if (form.currentState!.validate() == false || state.isAwaiting) return;

    try {
      final sats = BigInt.from(int.parse(satoshis.text));
      final receiver = address.text;

      emit(state.copyWith(isAwaiting: true));
      final (session, uri) = await PayJoin.initReceiver(sats, receiver);
      emit(state.copyWith(payjoinUri: uri));

      final httpClient = HttpClient();
      UncheckedProposal? proposal;
      while (proposal == null) {
        final (request, clientResponse) = await session.extractReq();
        final url = Uri.parse(request.url.asString());
        final httpRequest = await httpClient.postUrl(url);

        httpRequest.headers.set('Content-Type', request.contentType);
        httpRequest.add(request.body);

        final response = await httpRequest.close();
        final responseBody = await response.fold<List<int>>(
          [],
          (previous, element) => previous..addAll(element),
        );
        final uint8Response = Uint8List.fromList(responseBody);
        proposal =
            await session.processRes(body: uint8Response, ctx: clientResponse);
      }

      // TODO: emit proposal?
      print('proposal: $proposal');

      // Extract the original transaction from the proposal in case you want
      //  to broadcast it if the sender doesn't finalize the payjoin
      final originalTxBytes = await proposal.extractTxToScheduleBroadcast();
      final originalTx =
          await bdk.Transaction.fromBytes(transactionBytes: originalTxBytes);

      // Process the proposal through the various checks
      final maybeInputsOwned = await proposal.assumeInteractiveReceiver();

      // TODO: Implement actual ownership check
      final maybeInputsSeen = await maybeInputsOwned.checkInputsNotOwned(
        isOwned: (o) async => false,
      );

      // TODO: Implement actual seen check
      final outputsUnknown = await maybeInputsSeen.checkNoInputsSeenBefore(
        isKnown: (o) async => false,
      );

      final wantsOutputs = await outputsUnknown.identifyReceiverOutputs(
        isReceiverOutput: (script) async {
          return bdkWallet.isMine(script: bdk.ScriptBuf(bytes: script));
        },
      );

      var wantsInputs = await wantsOutputs.commitOutputs();

      // Select and contribute inputs
      final unspent = bdkWallet.listUnspent();
      final List<InputPair> candidateInputs = [];
      for (final input in unspent) {
        final txout = TxOut(
          value: input.txout.value,
          scriptPubkey: input.txout.scriptPubkey.bytes,
        );
        final psbtin = PsbtInput(
          witnessUtxo: txout,
        );
        final previousOutput = OutPoint(
          txid: input.outpoint.txid,
          vout: input.outpoint.vout,
        );
        final txin = TxIn(
          previousOutput: previousOutput,
          scriptSig: await Script.newInstance(rawOutputScript: []),
          witness: [],
          sequence: 0,
        );
        final ip = await InputPair.newInstance(txin, psbtin);
        candidateInputs.add(ip);
      }

      final inputPair = await wantsInputs.tryPreservingPrivacy(
        candidateInputs: candidateInputs,
      );

      wantsInputs =
          await wantsInputs.contributeInputs(replacementInputs: [inputPair]);
      final provisionalProposal = await wantsInputs.commitInputs();

      final finalProposal = await provisionalProposal.finalizeProposal(
        processPsbt: (i) => PayJoin.processPsbt(i, bdkWallet),
        maxFeeRateSatPerVb: BigInt.from(25),
      );

      // TODO: emit
      print('final proposal: $finalProposal');

      final proposalPsbt = await finalProposal.psbt();
      final proposalTxId = await PayJoin.getTxIdFromPsbt(proposalPsbt);
      print('Receiver proposal tx: $proposalTxId');

      // Send the proposal via POST request to directory
      final (proposalReq, proposalCtx) = await finalProposal.extractV2Req();
      final httpRequest =
          await httpClient.postUrl(Uri.parse(proposalReq.url.asString()));
      httpRequest.headers.set('content-type', 'message/ohttp-req');
      httpRequest.add(proposalReq.body);
      final response = await httpRequest.close();
      final responseBody = await response.fold<List<int>>(
        [],
        (previous, element) => previous..addAll(element),
      );
      await finalProposal.processRes(
        res: responseBody,
        ohttpContext: proposalCtx,
      );

      // Wait for the payjoin transaction to be broadcasted by the sender
      //  Still possible the payjoin wasn't finalized and the original tx was
      //  broadcasted instead by the sender, so also check for that
      // You could also put a timeout on waiting for the transaction and then
      //  broadcast the original tx yourself if no transaction is received

      final (blockchain, errNetwork) = networkRepository.bdkBlockchain;

      final originalTxId = await originalTx.txid();
      String receivedTxId = '';
      while (receivedTxId.isEmpty) {
        bdkWallet.sync(blockchain: blockchain!);
        final txs = bdkWallet.listTransactions(includeRaw: false);

        try {
          final tx = txs.firstWhere(
            (tx) => tx.txid == originalTxId || tx.txid == proposalTxId,
          );
          print('Tx found: ${tx.txid}');
          receivedTxId = tx.txid;
        } catch (e) {
          const timeout = Duration(seconds: 1);
          print(
            'Tx not found, retrying after ${timeout.inSeconds} second(s)...',
          );
          await Future.delayed(timeout);
        }
      }

      if (receivedTxId.isNotEmpty && receivedTxId == proposalTxId) {
        emit(state.copyWith(toast: receivedTxId));
      }

      emit(state.copyWith(isAwaiting: false));
    } catch (e) {
      emit(state.copyWith(toast: e.toString()));
      print(e);
    }
  }
}
