// ignore_for_file: avoid_print, invalid_annotation_target

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;
import 'wallet.dart';

part 'liquid_wallet.freezed.dart';
part 'liquid_wallet.g.dart';

// TODO: Update LiquitWallet to manage USDT, based on requirement
@freezed
class LiquidWallet extends Wallet with _$LiquidWallet {
  factory LiquidWallet({
    required String id,
    required String name,
    required int balance,
    required int txCount,
    required WalletType type,
    required NetworkType network,
    required String seedFingerprint,
    @Default(BitcoinScriptType.bip84) BitcoinScriptType scriptType,
    @Default(false) bool backupTested,
    DateTime? lastBackupTested,
    DateTime? lastSync,
    @Default(ImportTypes.words12) ImportTypes importType,
    @JsonKey(includeFromJson: false, includeToJson: false)
    lwk.Wallet? lwkWallet,
  }) = _LiquidWallet;
  LiquidWallet._();

  factory LiquidWallet.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$LiquidWalletFromJson, 'LiquidWallet');

  @override
  Future<List<Tx>> getTxs(Wallet wallet, List<Tx> storedTxs) async {
    if (lwkWallet == null) {
      throw 'lwkWallet is null';
    }
    final lwkTxs = await lwkWallet?.txs();
    final txsFutures = lwkTxs?.map((t) => Tx.loadFromNative(t, this)) ?? [];

    final txs = await Future.wait(txsFutures);

    return txs;
  }

  @override
  Future<Address> getAddress(int index, AddressKind kind) async {
    final lwkAddress = await lwkWallet?.address(index: index);
    return Address.loadFromNative(lwkAddress, this, kind);
  }

  @override
  Future<void> buildTx(Address address, int amount, Seed seed) async {}
}

extension NetworkTypeExtension on NetworkType {
  lwk.Network get getLwkType {
    switch (this) {
      case NetworkType.Mainnet:
        return lwk.Network.mainnet;
      case NetworkType.Testnet:
        return lwk.Network.testnet;
      case NetworkType.Signet:
        return lwk.Network.testnet;
    }
  }
}
