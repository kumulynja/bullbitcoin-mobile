// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
import 'package:bb_arch/_pkg/wallet/bitcoin_wallet_helper.dart';
import 'package:bb_arch/_pkg/wallet/liquid_wallet_helper.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:isar/isar.dart';

class WalletRepository {
  WalletRepository({required this.storage, this.isar}) {
    initOnAppStart();
  }

  HiveStorage storage;
  Isar? isar;

  Future<void> initOnAppStart() async {
    BBLogger().log('Init on app start');
    try {
      final (_, err) = await storage.getValue('appInitDone');
      if (err?.message == 'No Key') {
        await storage.saveValue(key: 'appInitDone', value: 'yes');
      }
    } catch (e) {
      return;
    }
  }

  Future<List<Wallet>> loadWallets() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // isar = null;
      final wallets = await isar!.wallets.where().findAll();
      // TODO: Find better way
      // This is to convert `Wallet` type returned by Isar to `BitcoinWallet` or `LiquidWallet`
      // Should this be even done here?
      final ws = wallets!.map((w) {
        if (w.type == WalletType.Bitcoin) {
          return BitcoinWallet.fromJson(w.toJson());
        } else if (w.type == WalletType.Liquid) {
          return LiquidWallet.fromJson(w.toJson());
        }
        return w;
      }).toList();
      return ws;
    } on IsarError catch (e, stackTrace) {
      throw Error.throwWithStackTrace(DatabaseException(e), stackTrace);
    } on JsonParseException {
      rethrow;
    } catch (e, stackTrace) {
      throw Error.throwWithStackTrace(WalletLoadException(e), stackTrace);
    }
  }

  Future<void> persistWallet(Wallet wallet) async {
    await isar?.writeTxn(() async {
      await isar?.wallets.putByIndex("id", wallet);
    });
  }

  Future<(List<Wallet>?, dynamic)> deriveWalletsFromSeed(
      Seed seed, WalletType walletType, NetworkType networkType) async {
    if (walletType == WalletType.Bitcoin) {
      final ws =
          await BitcoinWalletHelper.initializeAllWallets(seed, networkType);
      return (ws, null);
    } else if (walletType == WalletType.Liquid) {
      final ws = await LiquidWalletHelper.initializeAllWallets(
          seed, networkType,
          scriptType: [BitcoinScriptType.bip84]);
      return (ws, null);
    }
    List<Wallet> ws = [];
    return (ws, null);
  }

  Future<Wallet> loadNativeSdk(Wallet w, Seed seed) async {
    try {
      Wallet newWallet = w;
      if (w is BitcoinWallet) {
        if (w.bdkWallet == null) {
          newWallet = await BitcoinWalletHelper.loadNativeSdk(w, seed);
        }
      } else if (w is LiquidWallet) {
        if (w.lwkWallet == null) {
          newWallet = await LiquidWalletHelper.loadNativeSdk(w, seed);
        }
      }
      return newWallet;
    } on BdkElectrumException {
      rethrow;
    } catch (e, stackTrace) {
      throw Error.throwWithStackTrace(Exception(e), stackTrace);
    }
  }

  Future<void> deleteWallet(String walletId) async {
    try {
      await isar?.writeTxn(() async {
        final success = await isar?.wallets.deleteByIndex("id", [walletId]);
        if (success == null || success == false) {
          throw 'Wallet not found with id: $walletId';
        }
      });
    } on IsarError catch (e, stackTrace) {
      throw Error.throwWithStackTrace(DatabaseException(e), stackTrace);
    } catch (e, stackTrace) {
      throw Error.throwWithStackTrace(WalletDeleteException(e), stackTrace);
    }
  }
}
