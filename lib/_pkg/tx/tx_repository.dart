import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
import 'package:bb_arch/_pkg/tx/bitcoin_tx_helper.dart';
import 'package:bb_arch/_pkg/tx/models/bitcoin_tx.dart';
import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
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
    } on IsarError catch (e, stackTrace) {
      throw Error.throwWithStackTrace(DatabaseException(e), stackTrace);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tx>> listTxsForUI(Wallet wallet) async {
    try {
      final confirmed = await isar.txs
          .where()
          .walletIdEqualTo(wallet.id)
          .filter()
          .timestampGreaterThan(0)
          .sortByTimestampDesc()
          .findAll();
      final pendingTxs = await isar.txs
          .where()
          .walletIdEqualTo(wallet.id)
          .filter()
          .timestampEqualTo(0)
          .findAll();

      // Among pending RBFs, show only the last RBF tx in the chain
      final pTxs = pendingTxs.where((pTx) {
        if (pTx.rbfChain.isEmpty) return true;
        return pTx.id == pTx.rbfChain.last;
      });

      final txs = [...pTxs, ...confirmed];
      return Tx.mapBaseToChild(txs);
    } on IsarError catch (e, stackTrace) {
      throw Error.throwWithStackTrace(DatabaseException(e), stackTrace);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tx>> listAllTxs(Wallet wallet) async {
    try {
      final txs = await isar.txs
          .where()
          .walletIdEqualTo(wallet.id)
          .sortByTimestampDesc()
          .findAll();
      return Tx.mapBaseToChild(txs);
    } on IsarError catch (e, stackTrace) {
      throw Error.throwWithStackTrace(DatabaseException(e), stackTrace);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tx>> syncTxs(Wallet wallet, List<Tx> storedTxs) async {
    try {
      final newTxs = await wallet.getTxs(wallet, storedTxs);
      newTxs.sort((a, b) => a.fee - b.fee);

      List<Tx> mergedTxs = [...newTxs.toList(), ...storedTxs];

      if (wallet.type == WalletType.Bitcoin) {
        final pendingReceives =
            mergedTxs.where((tx) => tx.isPending() && tx.isReceive()).toList();

        mergedTxs = BitcoinTxHelper.findAndMergeReceiveRBFs(
            mergedTxs, newTxs, pendingReceives);
      }

      mergedTxs.sort(
        (a, b) => b.timestamp - a.timestamp,
      );

      return mergedTxs;
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
