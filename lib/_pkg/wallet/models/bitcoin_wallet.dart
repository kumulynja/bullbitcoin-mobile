// ignore_for_file: avoid_print, invalid_annotation_target

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'wallet.dart';

part 'bitcoin_wallet.freezed.dart';
part 'bitcoin_wallet.g.dart';

@freezed
class BitcoinWallet extends Wallet with _$BitcoinWallet {
  factory BitcoinWallet({
    required String id,
    required String name,
    required int balance,
    required int txCount,
    required WalletType type,
    required NetworkType network,
    required String seedFingerprint,
    // required bool breaker, // TODO: Added for Parse testing
    @Default(BitcoinScriptType.bip84) BitcoinScriptType scriptType,
    @Default(false) bool backupTested,
    DateTime? lastBackupTested,
    DateTime? lastSync,
    @Default(ImportTypes.words12) ImportTypes importType,
    @JsonKey(includeFromJson: false, includeToJson: false)
    bdk.Blockchain? bdkBlockchain,
    @JsonKey(includeFromJson: false, includeToJson: false)
    bdk.Wallet? bdkWallet,
    @JsonKey(includeFromJson: false, includeToJson: false)
    bdk.Wallet? bdkSigningWallet,
  }) = _BitcoinWallet;
  BitcoinWallet._();

  factory BitcoinWallet.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinWalletFromJson, 'BitcoinWallet');

  @override
  Future<List<Tx>> getTxs(Wallet wallet, List<Tx> storedTxs) async {
    if (bdkWallet == null) {
      throw 'bdkWallet is null';
    }

    Stopwatch stopwatch = Stopwatch()..start();
    final bdkTxs = await bdkWallet?.listTransactions(includeRaw: true) ?? [];
    // print('Time taken to fetch txs: ${stopwatch.elapsedMilliseconds} ms');
    stopwatch.reset();

    final testTxs = [...storedTxs];

    final filteredList = bdkTxs.where((bdkTx) {
      final matchIndex =
          testTxs.indexWhere((storedTx) => storedTx.id == bdkTx.txid);
      if (matchIndex == -1) {
        return true;
      } else {
        testTxs.removeAt(matchIndex);
        return false;
      }
    }).toList();

    final txsFutures =
        filteredList.map((t) => Tx.loadFromNative(t, this)).toList();
    final txs = await Future.wait(txsFutures);
    // print('Time taken to process txs: ${stopwatch.elapsedMilliseconds} ms');

    return txs;
  }

  @override
  Future<Address> getAddress(int index, AddressKind kind) async {
    bdk.AddressInfo? bdkAddress;

    if (kind == AddressKind.deposit) {
      bdkAddress = await bdkWallet?.getAddress(
          addressIndex: bdk.AddressIndex.peek(index: index));
    } else {
      bdkAddress = await bdkWallet?.getInternalAddress(
          addressIndex: bdk.AddressIndex.peek(index: index));
    }
    return Address.loadFromNative(bdkAddress, this, kind);
  }

  @override
  Future<void> buildTx(Address address, int amount, Seed seed) async {
    try {
      bdk.TxBuilder builder = bdk.TxBuilder();
      final bdkAddress = await bdk.Address.fromString(
          s: address.address, network: network.getBdkType);
      final script = await bdkAddress.scriptPubkey();
      // TODO: App crashes with negative value as fee
      // So this needs to be handled on our side.
      final txBuilderResult = await builder
          .feeRate(20)
          .addRecipient(script, 1234)
          .finish(bdkWallet!);
      final psbt = txBuilderResult.$1;

      final signingWallet =
          (await initializePrivateWallet(seed)) as BitcoinWallet;

      final successfulSigning =
          await signingWallet.bdkSigningWallet?.sign(psbt: psbt);

      if (successfulSigning == false) {
        throw Exception('Failed to sign transaction');
      }

      final broadcastTx = await psbt.extractTx();

      await bdkBlockchain?.broadcast(transaction: broadcastTx);
    } on bdk.FeeRateUnavailableException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e, message: e.message), stackTrace);
    } on bdk.ElectrumException catch (e, stackTrace) {
      Error.throwWithStackTrace(BdkElectrumException(e), stackTrace);
    } on bdk.FeeTooLowException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e, message: e.message), stackTrace);
    } on bdk.FeeRateTooLowException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e, message: e.message), stackTrace);
    } on bdk.RpcException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e, message: e.message), stackTrace);
    } on bdk.GenericException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e, message: e.message), stackTrace);
    } on bdk.AddressException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e,
              title: 'Invalid address',
              message: 'Please check if you entered valid address',
              description: e.message),
          stackTrace);
    } on bdk.OutputBelowDustLimitException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e,
              title: 'Invalid amount',
              message: 'Cannot send below dust',
              description: e.message),
          stackTrace);
    } on bdk.InsufficientFundsException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e,
              title: 'Insufficient Funds',
              message: 'Check if you got enough balance',
              description: e.message),
          stackTrace);
      // TODO: This is being thrown here when min fee.
      // But guess this is not expored from bdk_flutter
      // Hence cannot use it here, to handle this.
      // } on bdk.BdkError_Electrum or bdk.RpcException catch (e, stackTrace) {
      //   print(e);
    } on Exception catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkException(e, title: 'Send error', message: e.toString()),
          stackTrace);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Wallet> initializePrivateWallet(Seed seed) async {
    final mn = await bdk.Mnemonic.fromString(seed.mnemonic);

    final descriptorSecretKey = await bdk.DescriptorSecretKey.create(
      network: network.getBdkType,
      mnemonic: mn,
      password: seed.passphrase,
    );

    bdk.Descriptor? internal;
    bdk.Descriptor? external;

    switch (scriptType) {
      case BitcoinScriptType.bip84:
        external = await bdk.Descriptor.newBip84(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.externalChain,
        );
        internal = await bdk.Descriptor.newBip84(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.internalChain,
        );

      case BitcoinScriptType.bip44:
        external = await bdk.Descriptor.newBip44(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.externalChain,
        );
        internal = await bdk.Descriptor.newBip44(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.internalChain,
        );

      case BitcoinScriptType.bip49:
        external = await bdk.Descriptor.newBip49(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.externalChain,
        );
        internal = await bdk.Descriptor.newBip49(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.internalChain,
        );

      case BitcoinScriptType.bip86:
        external = await bdk.Descriptor.newBip86(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.externalChain,
        );
        internal = await bdk.Descriptor.newBip86(
          secretKey: descriptorSecretKey,
          network: network.getBdkType,
          keychain: bdk.KeychainKind.internalChain,
        );
    }

    const dbConfig = bdk.DatabaseConfig.memory();

    final signingWallet = await bdk.Wallet.create(
      descriptor: external,
      changeDescriptor: internal,
      network: network.getBdkType,
      databaseConfig: dbConfig,
    );

    return copyWith(bdkSigningWallet: signingWallet);
  }
}

enum ImportTypes { xpub, coldcard, descriptors, words12, words24, notSelected }

extension NetworkTypeExtension on NetworkType {
  bdk.Network get getBdkType {
    switch (this) {
      case NetworkType.Mainnet:
        return bdk.Network.bitcoin;
      case NetworkType.Testnet:
        return bdk.Network.testnet;
      case NetworkType.Signet:
        return bdk.Network.signet;
    }
  }
}
