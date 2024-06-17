import 'dart:convert';

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
import 'package:bb_arch/_pkg/tx/models/bitcoin_tx.dart';
import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:isar/isar.dart';

class TxRepository {
  TxRepository({required this.storage, required this.isar});

  Isar isar;
  HiveStorage storage;

  Future<List<Tx>> fetchLatestTxsAcrossWallets(int limit) async {
    try {
      final txs =
          await isar.txs.where().sortByTimestampDesc().limit(limit).findAll();
      return Tx.mapBaseToChild(txs);

      // TODO: Find better way
      // final ts = txs.map((t) {
      //   if (t.type == TxType.Bitcoin) {
      //     return BitcoinTx.fromJson(t.toJson());
      //   } else if (t.type == TxType.Liquid) {
      //     return LiquidTx.fromJson(t.toJson());
      //   }
      //   return t;
      // }).toList();
      // return ts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tx>> listTxs(Wallet wallet) async {
    try {
      final txs = await isar.txs
          .where()
          .walletIdEqualTo(wallet.id)
          .sortByTimestampDesc()
          .findAll();

      return Tx.mapBaseToChild(txs);

      // TODO: Find better way
      // final ts = txs.map((t) {
      //   if (t.type == TxType.Bitcoin) {
      //     return BitcoinTx.fromJson(t.toJson());
      //   } else if (t.type == TxType.Liquid) {
      //     return LiquidTx.fromJson(t.toJson());
      //   }
      //   return t;
      // }).toList();

      // final (txStr, _) = await storage.getValue('tx.${wallet.id}');
      // List<dynamic> txsJson = jsonDecode(txStr!);
      // final txs = txsJson.map((txJson) => Tx.fromJson(txJson)).toList();
      // return (ts, null);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: Pass List<Tx> as another parameter, which has list of Txs to be merged with
  Future<List<Tx>> syncTxs(Wallet wallet) async {
    try {
      // TODO: Ideally wallet.getTxs should be split as fetchTxs and processTxs
      // So first time a tx is fetched from bdk (Not existing in local storage), or unconfirmed txs, it is processed.
      // which means, first time tx is fetched or for unconfirmed txs, it's inputs, outputs and other fields are processed.
      // Then, next time, when the same tx is fetched, it's ignored and local Tx version is used.

      final storedTxs = await listTxs(wallet);
      final updatedTxs = await wallet.getTxs(wallet);
      final sortedTxs = updatedTxs.toList();
      sortedTxs.sort(
        (a, b) => b.timestamp - a.timestamp,
      );

      return sortedTxs;
    } catch (e) {
      rethrow;
    }
  }

  Future<Tx> loadTx(String walletid, String txid) async {
    final txs = await isar.txs
        .where()
        .idEqualTo(txid)
        .filter()
        .walletIdEqualTo(walletid)
        .findAll();
    final tx = txs.first;
    if (tx.type == TxType.Bitcoin) {
      return BitcoinTx.fromJson(tx.toJson());
    } else if (tx.type == TxType.Liquid) {
      return LiquidTx.fromJson(tx.toJson());
    }
    return tx;
  }

  Future<void> persistTxs(Wallet wallet, List<Tx> txs) async {
    await isar.writeTxn(() async {
      await isar.txs.putAllByIndex("id", txs);
    });
    // List<Map<String, dynamic>> txsJson = txs.map((tx) => tx.toJson()).toList();
    // String encoded = jsonEncode(txsJson);
    // await storage.saveValue(key: 'tx.${wallet.id}', value: encoded);
  }

  Future<void> deleteAllTxsInWallet(String walletId) async {
    await isar.writeTxn(() async {
      final count =
          await isar.txs.filter().walletIdEqualTo(walletId).deleteAll();
      print('Objects deleted: $count');
    });
  }
}
