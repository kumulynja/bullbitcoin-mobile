import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:isar/isar.dart';

class SeedRepository {
  SeedRepository({required this.storage, required this.isar});

  Isar isar;
  HiveStorage storage;

  late Seed? seed;

  Future<Seed> loadSeed(String fingerprint) async {
    try {
      final seed =
          await isar.seeds.where().fingerprintEqualTo(fingerprint).findFirst();
      if (seed == null) {
        throw 'Seed not found with fingerprint: $fingerprint';
      }
      return seed;
    } catch (e, stackTrace) {
      throw Error.throwWithStackTrace(SeedException(e), stackTrace);
    }
  }

  Future<Seed> newSeed(WalletType walletType, NetworkType network) async {
    try {
      final mn = await bdk.Mnemonic.create(bdk.WordCount.Words12);
      return Seed(
        mnemonic: mn.asString(),
        passphrase: '',
        fingerprint: '',
      );
    } catch (e, stackTrace) {
      throw Error.throwWithStackTrace(SeedException(e), stackTrace);
    }
  }

  Future<dynamic> deleteSeed(Seed seed) async {
    try {
      final err = await storage.deleteValue('seed.${seed.fingerprint}');
      if (err != null) {
        return err;
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> persistSeedforWalletId(Seed seed, String walletId) async {
    try {
      Seed existingSeed = (await isar.seeds
              .where()
              .fingerprintEqualTo(seed.fingerprint)
              .findFirst()) ??
          seed;

      if (!existingSeed.walletIDs.contains(walletId)) {
        existingSeed = existingSeed
            .copyWith(walletIDs: [...existingSeed.walletIDs, walletId]);
      }

      await isar.writeTxn(() async {
        await isar.seeds.putByIndex("id", existingSeed);
      });
      //final err = await storage.saveValue(key: 'seed.${seed.fingerprint}', value: jsonEncode(seed.toJson()));
      // return err;
    } catch (e) {
      return e;
    }
  }

  // TODO: This function should return bool (true if all is okay).
  // BdkException is to be thrown if there is a bdk related error (expected).
  // Exception is to be thrown otherwise (unexpected).
  Future<String?> validateSeedPhrase(String seedphrase) async {
    try {
      // TODO: Added delay for testing
      await Future.delayed(const Duration(seconds: 1));
      final _ = await bdk.Mnemonic.fromString(seedphrase);
      return null;
    } catch (e) {
      if (e is bdk.GenericException) {
        return e.message;
      } else {
        return e.toString();
      }
    }
  }
}
