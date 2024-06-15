import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;

part 'liquid_address.freezed.dart';
part 'liquid_address.g.dart';

// TODO: Update LiquidAddress, based on requirement
@freezed
class LiquidAddress extends Address with _$LiquidAddress {
  factory LiquidAddress({
    required String address, // THIS IS CONFIDENTIAL ADDRESS
    required String regularAddress,
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
  }) = _LiquidAddress;
  LiquidAddress._();

  factory LiquidAddress.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$LiquidAddressFromJson, 'LiquidAddress');

  static Future<LiquidAddress> getLastUnused(LiquidWallet wallet) async {
    final lastUnused = await wallet.lwkWallet!.lastUnusedAddress();

    return LiquidAddress(
        address: lastUnused.confidential,
        regularAddress: lastUnused.standard,
        index: lastUnused.index,
        kind: AddressKind.deposit,
        status: AddressStatus.unused,
        type: AddressType.Liquid,
        walletId: wallet.id);
  }

  static Future<Address> loadFromNative(
      dynamic addr, LiquidWallet wallet) async {
    if (addr is! lwk.Address) {
      throw TypeError();
    }

    return LiquidAddress(
        address: addr.confidential,
        regularAddress: addr.standard,
        index: addr.index,
        kind: AddressKind.deposit,
        status: AddressStatus.unused,
        type: AddressType.Liquid,
        walletId: wallet.id);
  }

  // TODO: Update this, once lwk-dart is updated with required changes
  static Address processAddress(
      List<Tx> txs,
      Address lastUnused,
      List<Address> oldAddresses,
      Wallet wallet,
      AddressKind kind,
      LiquidAddress finalBitcoinAddr) {
    final Set<LiquidTx> txsPaidToThisAddress = {};

    /*
    // Loop to check receive txs to this address
    for (int i = 0; i < txs.length; i++) {
      final Tx tx = txs[i];
      final LiquidTx btx = tx as LiquidTx;

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
      final LiquidTx btx = tx as LiquidTx;

      for (int j = 0; j < btx.inputs.length; j++) {
        final txin = btx.inputs[j];

        for (int k = 0; k < txsPaidToThisAddress.length; k++) {
          final paidTx = txsPaidToThisAddress.elementAt(k);

          if (paidTx.id == txin.previousOutput.txid &&
              paidTx.outputs[txin.previousOutput.vout].address == finalBitcoinAddr.address) {
            // Single txn spending from multiple UTXOs should be counted only once.
            if (txnCounted) {
              finalBitcoinAddr = finalBitcoinAddr.copyWith(
                status: AddressStatus.used,
                balance: finalBitcoinAddr.balance - paidTx.outputs[txin.previousOutput.vout].value,
              );
            } else {
              finalBitcoinAddr = finalBitcoinAddr.copyWith(
                status: AddressStatus.used,
                txCount: finalBitcoinAddr.txCount + 1,
                balance: finalBitcoinAddr.balance - paidTx.outputs[txin.previousOutput.vout].value,
                sendTxIds: [...finalBitcoinAddr.sendTxIds, btx.id],
              );
              txnCounted = true;
            }
          }
        }
      }
    }
    */

    return finalBitcoinAddr;
  }
}
