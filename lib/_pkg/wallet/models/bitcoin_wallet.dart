// ignore_for_file: avoid_print, invalid_annotation_target

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
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
  Future<(Iterable<Tx>?, dynamic)> getTxs(Wallet wallet) async {
    if (bdkWallet == null) {
      return (null, 'bdkWallet is null');
    }

    final bdkTxs = await bdkWallet?.listTransactions(true);
    final txsFutures = bdkTxs?.map((t) => Tx.loadFromNative(t, this)) ?? [];

    final txs = await Future.wait(txsFutures);

    return (txs, null);
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
}

enum ImportTypes { xpub, coldcard, descriptors, words12, words24, notSelected }

extension NetworkTypeExtension on NetworkType {
  bdk.Network get getBdkType {
    switch (this) {
      case NetworkType.Mainnet:
        return bdk.Network.Bitcoin;
      case NetworkType.Testnet:
        return bdk.Network.Testnet;
      case NetworkType.Signet:
        return bdk.Network.Signet;
    }
  }
}
