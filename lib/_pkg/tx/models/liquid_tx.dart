// ignore_for_file: avoid_print, invalid_annotation_target

import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/bitcoin_tx.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hex/hex.dart';
import 'package:isar/isar.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;
import 'tx.dart';

part 'liquid_tx.freezed.dart';
part 'liquid_tx.g.dart';

const hexDecoder = HexDecoder();

// TODO: Update LiquitTx to manage USDT, based on requirement
@freezed
class LiquidTx extends Tx with _$LiquidTx {
  factory LiquidTx({
    required String id,
    required TxType type,
    required int timestamp,
    required int amount,
    required int fee,
    required int height,
    required int version,
    required int vsize,
    required int weight,
    required int locktime,
    required List<LiquidTxIn> linputs,
    required List<LiquidTxOut> loutputs,
    required String toAddress,
    @Default([]) List<String> labels,
    required String? walletId,
    @Default([]) List<BitcoinTxIn> inputs,
    @Default([]) List<BitcoinTxOut> outputs,
  }) = _LiquidTx;
  LiquidTx._();

  factory LiquidTx.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$LiquidTxFromJson, 'LiquidTx');

  static Future<Tx> loadFromNative(dynamic tx, LiquidWallet wallet) async {
    if (tx is! lwk.Tx) {
      throw TypeError();
    }

    String assetIdToPick = wallet.network == NetworkType.Mainnet
        ? lwk.lBtcAssetId
        : lwk.lTestAssetId;

    lwk.Tx t = tx;
    //t.inputs[0].
    //t.outputs[0].
    final balances = t.balances;
    int finalBalance = balances
        .where((b) => b.assetId == assetIdToPick)
        .map((e) => e.value)
        .first;

    List<LiquidTxIn> inputs = [];
    for (int i = 0; i < t.inputs.length; i++) {
      final txIn = await LiquidTxIn.fromNative(t.inputs[i]);
      inputs.add(txIn);
    }

    List<LiquidTxOut> outputs = [];
    for (int i = 0; i < t.outputs.length; i++) {
      final txOut = await LiquidTxOut.fromNative(t.outputs[i], wallet.network);
      outputs.add(txOut);
    }

    return LiquidTx(
      id: t.txid,
      type: TxType.Liquid,
      timestamp: t.timestamp,
      amount: finalBalance,
      fee: t.fee,
      height: 0,
      version: 1,
      vsize: 0,
      weight: 0,
      locktime: 0,
      linputs: inputs,
      loutputs: outputs,
      labels: [],
      toAddress: '',
      walletId: wallet.id, //
    );
  }
}

@freezed
@Embedded(ignore: {'copyWith'})
class LiquidOutPoint with _$LiquidOutPoint {
  const factory LiquidOutPoint(
      {@Default('') String txid, @Default(0) int vout}) = _LiquidOutPoint;
  // LiquidOutPoint._();
  factory LiquidOutPoint.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$LiquidOutPointFromJson, 'LiquidOutPoint');
}

// TODO: Incomplete: Need update in lwk-dart
@freezed
@Embedded(ignore: {'copyWith'})
class LiquidTxIn with _$LiquidTxIn {
  static Future<LiquidTxIn> fromNative(lwk.TxOut txIn) async {
    try {
      return LiquidTxIn(
        previousOutput:
            LiquidOutPoint(txid: txIn.outpoint.txid, vout: txIn.outpoint.vout),
        scriptSig: txIn.scriptPubkey,
      );
    } catch (e) {
      print('Error: $e');
      return LiquidTxIn(
          previousOutput: const LiquidOutPoint(txid: '', vout: 0),
          scriptSig: '');
    }
  }

  factory LiquidTxIn({
    @Default(LiquidOutPoint()) LiquidOutPoint previousOutput,
    @Default('') String scriptSig,
  }) = _LiquidTxIn;
  LiquidTxIn._();

  factory LiquidTxIn.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$LiquidTxInFromJson, 'LiquidTxIn');
}

// TODO: Incomplete: Need update in lwk-dart
@freezed
@Embedded(ignore: {'copyWith'})
class LiquidTxOut with _$LiquidTxOut {
  static Future<LiquidTxOut> fromNative(
      lwk.TxOut txOut, NetworkType network) async {
    try {
      return LiquidTxOut(
          value: txOut.unblinded.value,
          scriptPubKey: txOut.scriptPubkey,
          address: txOut.scriptPubkey);
    } catch (e) {
      print('Error: $e');
      return LiquidTxOut(value: 0, scriptPubKey: '', address: '');
    }
  }

  factory LiquidTxOut(
      {@Default(0) int value,
      @Default('') String scriptPubKey,
      @Default('') String address}) = _LiquidTxOut;
  LiquidTxOut._();

  factory LiquidTxOut.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$LiquidTxOutFromJson, 'LiquidTxOut');
}
