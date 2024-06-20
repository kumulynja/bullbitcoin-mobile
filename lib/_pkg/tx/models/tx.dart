import 'dart:convert';

import 'package:bb_arch/_pkg/tx/models/bitcoin_tx.dart';
import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:isar/isar.dart';

part 'tx.g.dart';

@Collection(ignore: {'copyWith'})
class Tx {
  Id isarId = Isar.autoIncrement;

  @Index()
  String id = '';

  @Enumerated(EnumType.ordinal)
  TxType type = TxType.Bitcoin;

  @Index()
  int timestamp = 0;

  int sent = 0;
  int received = 0;
  int amount = 0;
  int fee = 0;

  int? height;

  String? psbt;
  int? broadcastTime;
  bool? rbfEnabled;

  int? version;
  int? vsize;
  int? weight;
  int? locktime;

  // TODO: Ideally shouldn't have both BitcoinTxIn and LiquidTxIn
  List<BitcoinTxIn>? inputs;
  List<BitcoinTxOut>? outputs;

  List<LiquidTxIn>? linputs;
  List<LiquidTxOut>? loutputs;

  String? toAddress;

  @Index(type: IndexType.value, caseSensitive: false)
  List<String>? labels;

  @Index()
  String? walletId;

  List<String> rbfChain = [];
  int rbfIndex = -1;

  Tx copWith(dynamic props) {
    if (type == TxType.Bitcoin) {
      (this as BitcoinTx).copWith(props);
    } else if (type == TxType.Liquid) {
      (this as LiquidTx).copWith(props);
    }

    return this;
  }

  bool isReceive() {
    return sent == 0 || received > sent;
  }

  bool isPending() {
    return timestamp == 0;
  }

  // TODO: Manually doing this sucks
  // This is done, because Tx is not @freezed at base class level.
  // To be experimented
  Map<String, dynamic> toJson() {
    if (this is BitcoinTx) {
      return (this as BitcoinTx).toJson();
    } else if (this is LiquidTx) {
      return (this as LiquidTx).toJson();
    }

    return {
      'isarId': isarId,
      'id': id,
      'type': type.name,
      'timestamp': timestamp,
      'sent': sent,
      'received': received,
      'amount': amount,
      'fee': fee,
      'height': height,
      'psbt': psbt,
      'broadcastTime': broadcastTime,
      'rbfEnabled': rbfEnabled,
      'version': version,
      'vsize': vsize,
      'weight': weight,
      'locktime': locktime,
      'inputs': inputs?.map((e) {
        // TODO: Better way to do this?
        // Without this decode / encode gimmick, e.toJson() returns Map<String, dynamic>,
        // where `previousOutput` is of type BitcoinOutPoint rather than Map<String, dynamic>
        return jsonDecode(jsonEncode(e.toJson()));
      }).toList(),
      'outputs': outputs?.map((e) => e.toJson()).toList(),
      'linputs': linputs?.map((e) {
        return jsonDecode(jsonEncode(e.toJson()));
      }).toList(),
      'loutputs': loutputs?.map((e) {
        return jsonDecode(jsonEncode(e.toJson()));
      }).toList(),
      'toAddress': toAddress,
      'labels': labels,
      'walletId': walletId,
      'rbfChain': rbfChain,
      'rbfIndex': rbfIndex,
    };
  }

  static Tx fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'] == TxType.Bitcoin.name) {
      return BitcoinTx.fromJson(json);
    } else if (json.containsKey('type') && json['type'] == TxType.Liquid.name) {
      return LiquidTx.fromJson(json);
    }
    throw UnimplementedError('Unsupported Tx subclass');
  }

  static Future<Tx> loadFromNative(dynamic tx, Wallet w) async {
    if (w.type == WalletType.Bitcoin) {
      return BitcoinTx.loadFromNative(tx, w as BitcoinWallet);
    } else if (w.type == WalletType.Liquid) {
      return LiquidTx.loadFromNative(tx, w as LiquidWallet);
    }
    throw UnimplementedError('Unsupported Tx subclass');
  }

  // TODO: Is this the right place to do this?
  /// Converts
  ///   List<Tx, Tx, Tx, Tx>
  /// to
  ///   List<BitcoinTx, LiquidTx, BitcoinTx, LiquidTx>
  static List<Tx> mapBaseToChild(List<Tx> txs) {
    return txs.map((t) {
      if (t.type == TxType.Bitcoin) {
        return BitcoinTx.fromJson(t.toJson());
      } else if (t.type == TxType.Liquid) {
        return LiquidTx.fromJson(t.toJson());
      }
      return t;
    }).toList();
  }
}

enum TxType { Bitcoin, Liquid, Lightning, Usdt }

extension TxTypeExtension on TxType {
  String get name {
    switch (this) {
      case TxType.Bitcoin:
        return 'Bitcoin';
      case TxType.Liquid:
        return 'Liquid';
      case TxType.Lightning:
        return 'Lightning';
      case TxType.Usdt:
        return 'Usdt';
    }
  }
}
