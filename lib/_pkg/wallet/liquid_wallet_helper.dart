import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/constants.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;
import 'package:path_provider/path_provider.dart';

class LiquidWalletHelper {
  static Future<List<LiquidWallet>> initializeAllWallets(Seed seed,
      {List<BitcoinScriptType> scriptType = const [
        BitcoinScriptType.bip44,
        BitcoinScriptType.bip49,
        BitcoinScriptType.bip84,
        BitcoinScriptType.bip86,
      ]}) async {
    LiquidWallet wallet = LiquidWallet(
        id: seed.fingerprint,
        name: '',
        balance: 0,
        txCount: 0,
        type: WalletType.Liquid,
        network: seed.network,
        importType: ImportTypes.words12,
        seedFingerprint: seed.fingerprint,
        scriptType: scriptType.first);

    final loadedWallet = await loadNativeSdk(wallet, seed);

    return [loadedWallet];
  }

  static Future<LiquidWallet> loadNativeSdk(LiquidWallet w, Seed seed) async {
    BBLogger().log('Loading native sdk for liquid wallet');

    final appDocDir = await getApplicationDocumentsDirectory();
    final String dbDir = '${appDocDir.path}/db';

    final lwk.Descriptor descriptor = await lwk.Descriptor.create(
        network: seed.network.getLwkType, mnemonic: seed.mnemonic);

    final wallet = await lwk.Wallet.create(
      network: seed.network.getLwkType,
      dbPath: dbDir,
      descriptor: descriptor.descriptor,
    );

    return w.copyWith(lwkWallet: wallet);
  }

  static Future<Wallet> syncWallet(LiquidWallet w) async {
    BBLogger().log('Syncing via lwk');

    try {
      if (w.lwkWallet == null) {
        throw ('lwk not initialized');
      }

      await w.lwkWallet?.sync(liquidElectrumUrl);

      String assetIdToPick =
          w.network == NetworkType.Mainnet ? lwk.lBtcAssetId : lwk.lTestAssetId;

      final balances = await w.lwkWallet?.balance();
      int finalBalance = balances
              ?.where((b) => b.assetId == assetIdToPick)
              .map((e) => e.value)
              .first ??
          0;

      final txs = await w.lwkWallet?.txs();

      return w.copyWith(
          balance: finalBalance,
          txCount: txs?.length ?? 0,
          lastSync: DateTime.now());
    } catch (e) {
      print('Error syncing wallet: $e');
      return w;
    }
  }
}
