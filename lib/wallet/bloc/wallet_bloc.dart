// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/constants.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_pkg/wallet/bitcoin_wallet_helper.dart';
import 'package:bb_arch/_pkg/wallet/liquid_wallet_helper.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/wallet/bloc/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  final TxRepository txRepository;
  final AddressRepository addressRepository;
  final SeedRepository seedRepository;
  final BuildContext context;
  final BBLogger logger;
  Timer? _loadWalletsTimer;

  WalletBloc({
    required this.walletRepository,
    required this.seedRepository,
    required this.txRepository,
    required this.addressRepository,
    required this.context,
    required this.logger,
  }) : super(WalletState.initial()) {
    on<LoadAllWallets>(_onLoadAllWallets);
    on<SyncAllWallets>(_onSyncAllWallets);
    on<SyncWallet>(_onSyncWallet);
    on<SelectWallet>(_onSelectWallet);
    on<PersistWallet>(_onPersistWallet);

    _loadWalletsTimer = Timer.periodic(
        const Duration(minutes: WALLET_SYNC_INTERVAL_MINS), (timer) {
      add(SyncAllWallets());
    });

    logger.log('WalletBloc :: Init');
  }

  @override
  Future<void> close() {
    _loadWalletsTimer?.cancel();
    return super.close();
  }

  void _onLoadAllWallets(
      LoadAllWallets event, Emitter<WalletState> emit) async {
    try {
      logger.log('WalletBloc :: LoadAllWallets');
      emit(state.copyWith(status: LoadStatus.loading));

      final wallets = await walletRepository.loadWallets();
      emit(state.copyWith(
          wallets: wallets,
          syncWalletStatus: wallets.map((e) => LoadStatus.initial).toList(),
          status: LoadStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  // TODO: Or somehow dispatch SyncWallet for each wallet from here; Is it really needed?
  // TODO: [UI Optimize]
  // WalletList is built based on state.wallets. And each wallet update results in
  // updating the entire state.wallets list. So entire list gets rebuilt, for each wallet sync.
  // This could be avoided by storing wallet states more granularly, and having wallet specific sync events/updates.
  void _onSyncAllWallets(
      SyncAllWallets event, Emitter<WalletState> emit) async {
    try {
      logger.log('WalletBloc :: SyncAllWallets');
      emit(state.copyWith(status: LoadStatus.loading));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
          syncWalletStatus:
              state.wallets.map((e) => LoadStatus.loading).toList()));

      List<Wallet> loadedWallets = [];
      for (int i = 0; i < state.wallets.length; i++) {
        final w = state.wallets[i];
        Wallet newWallet = w;
        final (seed, _) = await seedRepository.loadSeed(w.seedFingerprint);
        newWallet = await walletRepository.loadNativeSdk(w, seed!);
        loadedWallets.add(newWallet);
      }

      emit(state.copyWith(wallets: loadedWallets));

      List<Future<Wallet>> syncedFutures = state.wallets.map((w) async {
        print('Sync :: init :: w.id');
        final syncedWallet = await Wallet.syncWallet(w);

        print('Sync :: processTxs :: w.id');
        final (txs, err) = await txRepository.syncTxs(syncedWallet);
        if (err != null) {
          addError(err);
          return syncedWallet;
        }
        await txRepository.persistTxs(syncedWallet, txs!);

        print('Sync :: processAddress :: w.id');
        // TODO: Pass old address
        final (depositAddresses, depositErr) = await addressRepository
            .syncAddresses(txs, [], AddressKind.deposit, syncedWallet);
        if (depositErr != null) {
          addError(depositErr);
          return syncedWallet;
        }
        await addressRepository.persistAddresses(
            syncedWallet, depositAddresses!);

        // TODO: Pass old address
        final (changeAddresses, changeErr) = await addressRepository
            .syncAddresses(txs, [], AddressKind.change, syncedWallet);
        if (changeErr != null) {
          addError(changeErr);
          return syncedWallet;
        }
        await addressRepository.persistAddresses(
            syncedWallet, changeAddresses!);

        return syncedWallet;
      }).toList();

      var completer = Completer();

      int syncedCount = 0;
      for (int i = 0; i < syncedFutures.length; i++) {
        syncedFutures[i].then((Wallet result) {
          if (++syncedCount == syncedFutures.length) {
            completer.complete();
          }
          emit(state.copyWith(wallets: [
            ...state.wallets.sublist(0, i),
            result,
            ...state.wallets.sublist(i + 1),
          ], syncWalletStatus: [
            ...state.syncWalletStatus.sublist(0, i),
            LoadStatus.success,
            ...state.syncWalletStatus.sublist(i + 1),
          ]));
          print('Future at index $i completed with result: $result');
        }).catchError((error) {
          if (++syncedCount == syncedFutures.length) {
            completer.complete();
          }
          print('Future at index $i completed with error: $error');
        });
      }

      await completer.future;

      for (Wallet w in state.wallets) {
        await walletRepository.persistWallet(w);
      }
      emit(state.copyWith(status: LoadStatus.success));
      print('OnSyncAllWallets: DONE');
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  void _onSyncWallet(SyncWallet event, Emitter<WalletState> emit) async {}

  void _onSelectWallet(SelectWallet event, Emitter<WalletState> emit) async {
    logger.log('WalletBloc :: SelectWallet');
    emit(state.copyWith(selectedWallet: event.wallet));
  }

  void _onPersistWallet(PersistWallet event, Emitter<WalletState> emit) async {
    logger.log('WalletBloc :: PersistWallet');
    emit(state.copyWith(
        wallets: [...state.wallets, event.wallet],
        syncWalletStatus: [...state.syncWalletStatus, LoadStatus.initial]));
    await walletRepository.persistWallet(event.wallet);
    // await Future.delayed(const Duration(milliseconds: 10000));
    // add(LoadAllWallets());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is WalletLoadException) {
      emit(state.copyWith(
          status: LoadStatus.failure, error: error.error as Error));
      logger.error(error.error.toString(), stackTrace);
      // _showErrorDialog(context, error.error as Error);
      super.onError(error.error, stackTrace);
    } else if (error is JsonParseException) {
      emit(state.copyWith(
          status: LoadStatus.failure, error: error.error as Error));
      logger.error('ParseException (${error.modal}): ${error.error.toString()}',
          stackTrace);
      // _showErrorDialog(context, error.error as Error);
      super.onError(error.error, stackTrace);
    } else if (error is BdkElectrumException) {
      emit(state.copyWith(
          status: LoadStatus
              .failure)); // TODO: How to set error, when I get Exception or change the state to hold Exception
      logger.error(
          'BdkElectrumException ${error.serverUrl ?? ''}: ${error.error.toString()}',
          stackTrace);
      // _showErrorDialog(context, error.error as Error);
      super.onError(error.error, stackTrace);
    } else {
      logger.error(error.toString(), stackTrace);
      super.onError(error, stackTrace);
    }
  }
}

void _showErrorDialog(BuildContext context, Error error) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Error"),
      content: Text(error.toString()),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
