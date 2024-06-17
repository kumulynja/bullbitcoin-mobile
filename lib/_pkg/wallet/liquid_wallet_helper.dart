import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/constants.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;
import 'package:path_provider/path_provider.dart';

class LiquidWalletHelper {
  static Future<List<LiquidWallet>> initializeAllWallets(
      Seed seed, NetworkType network,
      {List<BitcoinScriptType> scriptType = const [
        BitcoinScriptType.bip44,
        BitcoinScriptType.bip49,
        BitcoinScriptType.bip84,
        BitcoinScriptType.bip86,
      ]}) async {
    final wallets = scriptType
        .map((path) => LiquidWallet(
            id: '${seed.fingerprint}_${path.name}_liquid_${network.name}',
            name: '',
            balance: 0,
            txCount: 0,
            type: WalletType.Liquid,
            network: network,
            importType: ImportTypes.words12,
            seedFingerprint: seed.fingerprint,
            scriptType: path))
        .toList();

    final List<LiquidWallet> loadedWallets = [];
    for (int i = 0; i < wallets.length; i++) {
      final loadedWallet = await loadNativeSdk(wallets[i], seed);
      loadedWallets.add(loadedWallet);
    }

    return loadedWallets;
  }

  static Future<LiquidWallet> loadNativeSdk(LiquidWallet w, Seed seed) async {
    BBLogger().log('Loading native sdk for liquid wallet');

    final appDocDir = await getApplicationDocumentsDirectory();
    final String dbDir = '${appDocDir.path}/db';

    final lwk.Descriptor descriptor = await lwk.Descriptor.newConfidential(
        network: w.network.getLwkType, mnemonic: seed.mnemonic);

    final wallet = await lwk.Wallet.init(
      network: w.network.getLwkType,
      dbpath: dbDir,
      descriptor: descriptor,
    );

    return w.copyWith(lwkWallet: wallet);
  }

  static Future<Wallet> syncWallet(LiquidWallet w) async {
    BBLogger().log('Syncing via lwk');

    try {
      if (w.lwkWallet == null) {
        throw ('lwk not initialized');
      }

      await w.lwkWallet?.sync(electrumUrl: liquidElectrumUrl);

      String assetIdToPick =
          w.network == NetworkType.Mainnet ? lwk.lBtcAssetId : lwk.lTestAssetId;

      final balances = await w.lwkWallet?.balances();
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
