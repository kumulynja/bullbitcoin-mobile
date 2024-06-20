// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/address/models/bitcoin_address.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'wallet.dart';

part 'lightning_wallet.freezed.dart';
part 'lightning_wallet.g.dart';

@freezed
class LightningWallet extends Wallet with _$LightningWallet {
  factory LightningWallet({
    required String id,
    required int balance,
    @Default(false) bool backupTested,
    DateTime? lastBackupTested,
    required WalletType type,
    required NetworkType network,
    required String seedFingerprint,
    @Default(BitcoinScriptType.bip84) BitcoinScriptType scriptType,
    DateTime? lastSync,
    @Default(ImportTypes.words12) ImportTypes importType,
  }) = _LightningWallet;
  LightningWallet._();

  factory LightningWallet.fromJson(Map<String, dynamic> json) =>
      _$LightningWalletFromJson(json);

  static Future<LightningWallet> loadNativeSdk(LightningWallet w) async {
    print('Loading native sdk for lightning wallet');
    return LightningWallet(
        id: 'LN',
        balance: 0,
        type: WalletType.Lightning,
        network: NetworkType.Testnet,
        seedFingerprint: '');
  }

  @override
  Future<List<Tx>> getTxs(Wallet wallet, List<Tx> storedTxs) async {
    // final txs = await lwkWallet?.txs();

    List<Tx> txs = [];
    return txs;
  }

  @override
  Future<Address> getAddress(int index, AddressKind kind) async {
    return BitcoinAddress(
        address: 'address',
        index: 0,
        kind: kind,
        status: AddressStatus.unused,
        type: AddressType.Lightning,
        balance: 0,
        spendable: true,
        labels: [],
        walletId: '');
  }

  @override
  Future<void> buildTx(Address address, int amount, Seed seed) async {}
}
