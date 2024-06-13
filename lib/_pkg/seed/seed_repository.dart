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

  Future<(Seed?, dynamic)> loadSeed(String fingerprint) async {
    try {
      final seed =
          await isar.seeds.where().fingerprintEqualTo(fingerprint).findAll();
      //final (seedsStr, _) = await storage.getValue('seed.$fingerprint');
      //Seed seed = Seed.fromJson(jsonDecode(seedsStr!));
      return (seed.first, null);
    } catch (e) {
      return (null, e);
    }
  }

  Future<(Seed?, dynamic)> newSeed(
      WalletType walletType, NetworkType network) async {
    try {
      final mn = await bdk.Mnemonic.create(bdk.WordCount.Words12);
      return (
        Seed(
            mnemonic: mn.asString(),
            passphrase: '',
            fingerprint: '',
            walletType: walletType,
            network: network),
        null
      );
    } catch (e) {
      return (null, e);
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

  Future<dynamic> persistSeed(Seed seed) async {
    try {
      await isar.writeTxn(() async {
        await isar.seeds.putByIndex("id", seed);
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
