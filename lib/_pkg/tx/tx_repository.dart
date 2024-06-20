import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
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

  Future<List<Tx>> listTxs(Wallet wallet) async {
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

  // TODO: Pass List<Tx> as another parameter, which has list of Txs to be merged with
  Future<List<Tx>> syncTxs(Wallet wallet) async {
    try {
      // TODO: Ideally wallet.getTxs should be split as fetchTxs and processTxs
      // So first time a tx is fetched from bdk (Not existing in local storage), or unconfirmed txs, it is processed.
      // which means, first time tx is fetched or for unconfirmed txs, it's inputs, outputs and other fields are processed.
      // Then, next time, when the same tx is fetched, it's ignored and local Tx version is used.

      final storedTxs = await listTxs(wallet);
      final newTxs = await wallet.getTxs(wallet, storedTxs);

      List<Tx> mergedTxs = [...newTxs.toList(), ...storedTxs];

      final pendingTxs = mergedTxs.where((tx) => tx.isPending()).toList();

      if (wallet.type == WalletType.Bitcoin) {
        mergedTxs = lookForReceiveRBFs(newTxs, mergedTxs, pendingTxs);
      }

      mergedTxs.sort(
        (a, b) => b.timestamp - a.timestamp,
      );

      return mergedTxs;
    } catch (e) {
      rethrow;
    }
  }

  List<Tx> lookForReceiveRBFs(
      List<Tx> newTxs, List<Tx> mergedTxs, List<Tx> pendingTxs) {
    Tx? newNewTx;
    Tx? newParent;
    for (Tx newTx in newTxs) {
      print('NewTx: ${newTx.id}: ${newTx.isReceive()}');
      if (newTx.isReceive()) {
        final rbfParent = isInRbfChain(newTx, pendingTxs);

        if (rbfParent != null) {
          if (rbfParent.rbfChain.isEmpty) {
            newParent = (rbfParent as BitcoinTx).copyWith(
              rbfChain: [...rbfParent.rbfChain, rbfParent.id, newTx.id],
              rbfIndex: 0,
            );
            mergedTxs.removeWhere((tx) => tx.id == newParent!.id);
            mergedTxs.add(newParent);

            newNewTx = (newTx as BitcoinTx).copyWith(
              rbfChain: [...rbfParent.rbfChain, rbfParent.id, newTx.id],
              rbfIndex: 1,
            );
            mergedTxs.removeWhere((tx) => tx.id == newNewTx!.id);
            mergedTxs.add(newNewTx);
          } else {
            for (int i = 0; i < rbfParent.rbfChain.length; i++) {
              final rbfAncestorTxId = rbfParent.rbfChain[i];
              final rbfAncentorTx =
                  pendingTxs.firstWhere((pTx) => pTx.id == rbfAncestorTxId);
              final updatedRbfAncestorTx =
                  (rbfAncentorTx as BitcoinTx).copyWith(
                rbfChain: [...rbfAncentorTx.rbfChain, newTx.id],
              );
              mergedTxs.removeWhere((tx) => tx.id == updatedRbfAncestorTx!.id);
              mergedTxs.add(updatedRbfAncestorTx);

              newNewTx = (newTx as BitcoinTx).copyWith(
                rbfChain: [...rbfAncentorTx.rbfChain, newTx.id],
                rbfIndex: rbfAncentorTx.rbfChain.length,
              );
              mergedTxs.removeWhere((tx) => tx.id == newNewTx!.id);
              mergedTxs.add(newNewTx);
            }
          }
        }

        /*
        if (rbfParent != null) {
          if (rbfParent.type == TxType.Bitcoin) {
            if (rbfParent.rbfChain.isEmpty) {
              newParent = (rbfParent as BitcoinTx).copyWith(
                rbfChain: [...rbfParent.rbfChain, rbfParent.id, newTx.id],
                rbfIndex: 0,
              );
            } else {
              newParent = (rbfParent as BitcoinTx).copyWith(
                rbfChain: [...rbfParent.rbfChain, newTx.id],
              );
            }

            if (newTx.rbfChain.isEmpty) {
              newNewTx = (newTx as BitcoinTx).copyWith(
                rbfChain: [...rbfParent.rbfChain, rbfParent.id, newTx.id],
                rbfIndex: 1,
              );
            } else {
              newNewTx = (newTx as BitcoinTx).copyWith(
                rbfChain: [...rbfParent.rbfChain, newTx.id],
                rbfIndex: rbfParent.rbfChain.length,
              );
            }
          }
        }
        */
      }
    }
    if (newParent != null) {}
    if (newNewTx != null) {
      mergedTxs.removeWhere((tx) => tx.id == newNewTx!.id);
      mergedTxs.add(newNewTx);
    }

    return mergedTxs;
  }

  Tx? isInRbfChain(Tx tx, List<Tx> pendingTxs) {
    if (pendingTxs.isEmpty) {
      return null;
    }

    for (final pending in pendingTxs) {
      if (tx.id == pending.id) continue;
      final pendingMatchIndex = tx.inputs!.indexWhere((txIp) {
        final outpoint = txIp.previousOutput.toString();
        final outpointStr = txIp.previousOutput.toStr();

        final matchingIndex = pending.inputs!.indexWhere((pTxIp) {
          final pendingOutpoint = pTxIp.previousOutput.toString();
          final pendingOutpointStr = pTxIp.previousOutput.toStr();
          if (pendingOutpointStr == outpointStr) {
            return true;
          }
          return false;
        });

        if (matchingIndex != -1) {
          return true;
        }
        return false;
      });

      if (pendingMatchIndex != -1) {
        return pending;
      }
    }

    return null;
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
