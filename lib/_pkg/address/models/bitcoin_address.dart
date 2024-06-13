import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/bitcoin_tx.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;

part 'bitcoin_address.freezed.dart';
part 'bitcoin_address.g.dart';

@freezed
class BitcoinAddress extends Address with _$BitcoinAddress {
  factory BitcoinAddress({
    required String address,
    required int index,
    required AddressKind kind,
    required AddressStatus status,
    required AddressType type,
    @Default(0) int balance,
    @Default(true) bool spendable,
    @Default([]) List<String>? labels,
    @Default(0) int txCount,
    @Default([]) List<String> txIds,
    @Default([]) List<String> receiveTxIds,
    @Default([]) List<String> sendTxIds,
    @Default(false) bool frozen,
    required String walletId,
  }) = _BitcoinAddress;
  BitcoinAddress._();

  factory BitcoinAddress.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinAddressFromJson, 'BitcoinAddress');

  static Future<BitcoinAddress> getLastUnused(
      BitcoinWallet wallet, AddressKind kind) async {
    bdk.AddressInfo lastUnused;

    if (kind == AddressKind.deposit) {
      lastUnused = await wallet.bdkWallet!.getAddress(
        addressIndex: const bdk.AddressIndex.lastUnused(),
      );
    } else {
      lastUnused = await wallet.bdkWallet!.getInternalAddress(
        addressIndex: const bdk.AddressIndex.lastUnused(),
      );
    }

    return BitcoinAddress(
        address: lastUnused.address,
        index: lastUnused.index,
        kind: kind,
        status: AddressStatus.unused,
        type: AddressType.Bitcoin,
        walletId: wallet.id);
  }

  static Future<Address> loadFromNative(
      dynamic addr, BitcoinWallet wallet, AddressKind kind) async {
    if (addr is! bdk.AddressInfo) {
      throw TypeError();
    }

    return BitcoinAddress(
        address: addr.address,
        index: addr.index,
        kind: kind,
        status: AddressStatus.unused,
        type: AddressType.Bitcoin,
        walletId: wallet.id);
  }

  // TODO: Think of optimizing this function. Got 4 nested loops: 3 inside the function, 1 outside
  static Address processAddress(
      List<Tx> txs,
      Address lastUnused,
      List<Address> oldAddresses,
      Wallet wallet,
      AddressKind kind,
      BitcoinAddress finalBitcoinAddr) {
    final Set<BitcoinTx> txsPaidToThisAddress = {};

    // Loop to check receive txs to this address
    for (int i = 0; i < txs.length; i++) {
      final Tx tx = txs[i];
      final BitcoinTx btx = tx as BitcoinTx;

      for (int j = 0; j < btx.outputs.length; j++) {
        final out = btx.outputs[j];
        if (out.address == finalBitcoinAddr.address) {
          finalBitcoinAddr = finalBitcoinAddr.copyWith(
              status: AddressStatus.used,
              txCount: finalBitcoinAddr.txCount + 1,
              balance: finalBitcoinAddr.balance + out.value,
              receiveTxIds: [...finalBitcoinAddr.receiveTxIds, btx.id]);
          txsPaidToThisAddress.add(btx);
          break;
        }
      }
    }

    // Loop to check spent txs from this address
    for (int i = 0; i < txs.length; i++) {
      bool txnCounted = false;
      final Tx tx = txs[i];
      final BitcoinTx btx = tx as BitcoinTx;

      for (int j = 0; j < btx.inputs.length; j++) {
        final txin = btx.inputs[j];

        for (int k = 0; k < txsPaidToThisAddress.length; k++) {
          final paidTx = txsPaidToThisAddress.elementAt(k);

          if (paidTx.id == txin.previousOutput.txid &&
              paidTx.outputs[txin.previousOutput.vout].address ==
                  finalBitcoinAddr.address) {
            // Single txn spending from multiple UTXOs should be counted only once.
            if (txnCounted) {
              finalBitcoinAddr = finalBitcoinAddr.copyWith(
                status: AddressStatus.used,
                balance: finalBitcoinAddr.balance -
                    paidTx.outputs[txin.previousOutput.vout].value,
              );
            } else {
              finalBitcoinAddr = finalBitcoinAddr.copyWith(
                status: AddressStatus.used,
                txCount: finalBitcoinAddr.txCount + 1,
                balance: finalBitcoinAddr.balance -
                    paidTx.outputs[txin.previousOutput.vout].value,
                sendTxIds: [...finalBitcoinAddr.sendTxIds, btx.id],
              );
              txnCounted = true;
            }
          }
        }
      }
    }

    return finalBitcoinAddr;
  }
}
