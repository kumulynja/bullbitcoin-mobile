// ignore_for_file: avoid_print, invalid_annotation_target

import 'dart:convert';
import 'dart:typed_data';

import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:hex/hex.dart';
import 'package:isar/isar.dart';
import 'tx.dart';

part 'bitcoin_tx.freezed.dart';
part 'bitcoin_tx.g.dart';

const hexDecoder = HexDecoder();

@freezed
class BitcoinTx extends Tx with _$BitcoinTx {
  factory BitcoinTx({
    required String id,
    required TxType type,
    required int timestamp,
    required int amount,
    required int fee,
    required int height,
    String? psbt,
    int? broadcastTime,
    required bool rbfEnabled,
    required int version,
    required int vsize,
    required int weight,
    required int locktime,
    required List<BitcoinTxIn> inputs,
    required List<BitcoinTxOut> outputs,
    required String toAddress,
    @Default([]) List<String> labels,
    required String? walletId,
    @Default([]) List<LiquidTxIn> linputs,
    @Default([]) List<LiquidTxOut> loutputs,
  }) = _BitcoinTx;
  BitcoinTx._();

  factory BitcoinTx.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinTxFromJson, 'BitcoinTx');

  static Future<Tx> loadFromNative(dynamic tx, BitcoinWallet wallet) async {
    if (tx is! bdk.TransactionDetails) {
      throw TypeError();
    }

    try {
      bdk.TransactionDetails t = tx;
      final sTx = jsonDecode(t.serializedTx!);

      final isRbf = await t.transaction?.isExplicitlyRbf() ?? false;
      final version = await t.transaction?.version() ?? 0;
      final vsize = await t.transaction?.vsize() ?? 0;
      final weight = await t.transaction?.weight() ?? 0;
      final locktime = await t.transaction?.lockTime() ?? 0;

      final ins = sTx['input'] as List;
      List<BitcoinTxIn> inputs = [];
      for (int i = 0; i < ins.length; i++) {
        final txIn = await BitcoinTxIn.fromNative(ins[i]);
        inputs.add(txIn);
      }

      final outs = sTx['output'] as List;
      List<BitcoinTxOut> outputs = [];
      for (int i = 0; i < outs.length; i++) {
        final txOut = await BitcoinTxOut.fromNative(outs[i], wallet.network);
        outputs.add(txOut);
      }

      return BitcoinTx(
        id: t.txid,
        type: TxType.Bitcoin,
        timestamp: t.confirmationTime?.timestamp ?? 0,
        amount: t.sent - t.received,
        fee: t.fee ?? 0,
        height: t.confirmationTime?.height ?? 0,
        labels: [],
        rbfEnabled: isRbf,
        version: version,
        vsize: vsize,
        weight: weight,
        locktime: locktime,
        inputs: inputs,
        outputs: outputs,
        toAddress: outputs[0].address ?? '',
        walletId: wallet.id,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

// Making all constructors params 'not-required' to comply with Isar
// TODO: Find any other better possibility to handle this
@freezed
@Embedded(ignore: {'copyWith'})
class BitcoinOutPoint with _$BitcoinOutPoint {
  const factory BitcoinOutPoint(
      {@Default('') String txid, @Default(0) int vout}) = _BitcoinOutPoint;
  // BitcoinOutPoint._();
  factory BitcoinOutPoint.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinOutPointFromJson, 'BitcoinOutPoint');
}

@freezed
@Embedded(ignore: {'copyWith'})
class BitcoinTxIn with _$BitcoinTxIn {
  static Future<BitcoinTxIn> fromNative(dynamic txIn) async {
    try {
      final scriptSigStr = await bdk.Script.create(
        hexDecoder.convert(txIn['script_sig']!) as Uint8List,
      );

      List<String> previousOut = (txIn['previous_output'] as String).split(':');

      return BitcoinTxIn(
        previousOutput: BitcoinOutPoint(
            txid: previousOut[0], vout: int.parse(previousOut[1])),
        scriptSig: txIn['script_sig'],
        scriptSigStr: scriptSigStr.toString(),
        sequence: txIn['sequence'],
        witness: (txIn['witness'] as Iterable<dynamic>)
            .map((e) => e.toString())
            .toList(), //
      );
    } catch (e) {
      print('Error: $e');
      return BitcoinTxIn(
          previousOutput: const BitcoinOutPoint(txid: '', vout: 0),
          scriptSig: '',
          scriptSigStr: '',
          sequence: 0,
          witness: []);
    }
  }

  factory BitcoinTxIn(
      {@Default(BitcoinOutPoint()) BitcoinOutPoint previousOutput,
      @Default('') String scriptSig,
      @Default('') String scriptSigStr,
      @Default(0) int sequence,
      @Default([]) List<String> witness}) = _BitcoinTxIn;
  BitcoinTxIn._();

  factory BitcoinTxIn.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinTxInFromJson, 'BitcoinTxIn');
}

@freezed
@Embedded(ignore: {'copyWith'})
class BitcoinTxOut with _$BitcoinTxOut {
  static Future<BitcoinTxOut> fromNative(
      dynamic txOut, NetworkType network) async {
    try {
      final scriptPubKey = await bdk.Script.create(
        hexDecoder.convert(txOut['script_pubkey']!) as Uint8List,
      );

      final addressStruct = await bdk.Address.fromScript(
        scriptPubKey,
        network.getBdkType,
      );

      return BitcoinTxOut(
          value: txOut['value'] ?? 0,
          scriptPubKey: txOut['script_pubkey'],
          address: addressStruct.toString());
    } catch (e) {
      print('Error: $e');
      return BitcoinTxOut(value: 0, scriptPubKey: '', address: '');
    }
  }

  factory BitcoinTxOut(
      {@Default(0) int value,
      @Default('') String scriptPubKey,
      @Default('') String address}) = _BitcoinTxOut;
  BitcoinTxOut._();

  factory BitcoinTxOut.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinTxOutFromJson, 'BitcoinTxOut');
}
