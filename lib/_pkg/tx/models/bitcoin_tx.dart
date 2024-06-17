// ignore_for_file: avoid_print, invalid_annotation_target

import 'dart:typed_data';

import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      // final sTx = jsonDecode(t.serializedTx!);

      final isRbf = await t.transaction?.isExplicitlyRbf() ?? false;
      final version = await t.transaction?.version() ?? 0;
      final vsize = await t.transaction?.vsize() ?? 0;
      final weight = await t.transaction?.weight() ?? 0;
      final locktime = await t.transaction?.lockTime();

      // final serializedTx = SerializedTx.fromJson(
      //   jsonDecode(t.transaction!.inner) as Map<String, dynamic>,
      // );

      final ins = await t.transaction?.input() ?? [];
      List<BitcoinTxIn> inputs = [];
      for (int i = 0; i < ins.length; i++) {
        final txIn = await BitcoinTxIn.fromNative(ins[i]);
        inputs.add(txIn);
      }

      final outs = await t.transaction?.output() ?? [];
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
        locktime: locktime?.field0 ?? 0, // TODO: Verify this
        inputs: inputs,
        outputs: outputs,
        toAddress: '', // TODO:
        walletId: wallet.id,
      );
    } catch (e) {
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
  static Future<BitcoinTxIn> fromNative(bdk.TxIn txIn) async {
    try {
      // TODO: Validate each fields
      return BitcoinTxIn(
        previousOutput: BitcoinOutPoint(
            txid: txIn.previousOutput.txid, vout: txIn.previousOutput.vout),
        scriptSig: txIn.scriptSig.bytes,
        sequence: txIn.sequence,
        witness: (txIn.witness as Iterable<dynamic>)
            .map((e) => e.toString())
            .toList(), //
      );
    } catch (e) {
      print('Error: $e');
      return BitcoinTxIn(
          previousOutput: const BitcoinOutPoint(txid: '', vout: 0),
          scriptSig: Uint8List.fromList([]),
          sequence: 0,
          witness: []);
    }
  }

  factory BitcoinTxIn(
      {@Default(BitcoinOutPoint()) BitcoinOutPoint previousOutput,
      @Default([]) List<int> scriptSig,
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
      bdk.TxOut txOut, NetworkType network) async {
    try {
      // final scriptPubKey = await bdk.ScriptBuf.fromHex(
      //   txOut['script_pubkey'],
      // );

      final addressStruct = await bdk.Address.fromScript(
        script: bdk.ScriptBuf(bytes: txOut.scriptPubkey.bytes),
        network: network.getBdkType,
      );

      // TODO: Validate each fields
      return BitcoinTxOut(
          value: txOut.value,
          scriptPubKey: txOut.scriptPubkey.bytes,
          address: await addressStruct.asString());
    } catch (e) {
      print('Error: $e');
      return BitcoinTxOut(
          value: 0, scriptPubKey: Uint8List.fromList([]), address: '');
    }
  }

  factory BitcoinTxOut(
      {@Default(0) int value,
      @Default([]) List<int> scriptPubKey,
      @Default('') String address}) = _BitcoinTxOut;
  BitcoinTxOut._();

  factory BitcoinTxOut.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$BitcoinTxOutFromJson, 'BitcoinTxOut');
}

/*
class SerializedTx {
  SerializedTx({this.version, this.lockTime, this.input, this.output});

  factory SerializedTx.fromJson(Map<String, dynamic> json) {
    return SerializedTx(
      version: json['version'] as int?,
      lockTime: json['lock_time'] as int?,
      input: (json['input'] as List?)
          ?.map((e) => BitcoinTxIn.fromJson(e as Map<String, dynamic>))
          .toList(),
      output: (json['output'] as List?)
          ?.map((e) => BitcoinTxOut.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  int? version;
  int? lockTime;
  List<BitcoinTxIn>? input;
  List<BitcoinTxOut>? output;
}

class BitcoinTxIn {
  BitcoinTxIn(
      {this.previousOutput, this.scriptSig, this.sequence, this.witness});

  factory BitcoinTxIn.fromJson(Map<String, dynamic> json) {
    return BitcoinTxIn(
      previousOutput: json['previous_output'] as String?,
      scriptSig: json['script_sig'] as String?,
      sequence: json['sequence'] as int?,
      witness: (json['witness'] as List?)?.map((e) => e as String).toList(),
    );
  }
  String? previousOutput;
  String? scriptSig;
  int? sequence;
  List<String>? witness;
}

class BitcoinTxOut {
  BitcoinTxOut({this.value, this.scriptPubkey});

  factory BitcoinTxOut.fromJson(Map<String, dynamic> json) {
    return BitcoinTxOut(
      value: json['value'] as int?,
      scriptPubkey: json['script_pubkey'] as String?,
    );
  }
  int? value;
  String? scriptPubkey;
}
*/
