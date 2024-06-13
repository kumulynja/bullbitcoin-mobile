import 'dart:convert';

import 'package:bb_arch/_pkg/constants.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

class BitcoinWalletHelper {
  static bdk.Blockchain? blockchain;

  static Future<bdk.Blockchain> getBdkBlockchain(
      {int stopGap = btcElectrumStopGap,
      int timeout = btcElectrumTimeout,
      int retry = btcElectrumRetry,
      String electrumUrl = btcElectrumUrl,
      bool validateDomain = btcElectrumValidateDomain}) async {
    blockchain ??= await bdk.Blockchain.create(
        config: bdk.BlockchainConfig.electrum(
            config: bdk.ElectrumConfig(
                stopGap: stopGap,
                timeout: timeout,
                retry: retry,
                url: electrumUrl,
                validateDomain: validateDomain)));
    return blockchain!;
  }

  static bdk.DatabaseConfig walletDbConfig(String path) {
    return bdk.DatabaseConfig.sqlite(
      config: bdk.SqliteDbConfiguration(path: path),
    );
  }

  static String createDescriptorHashId(String descriptor) {
    final descHashId = sha1
        .convert(
          utf8.encode(
            descriptor
                .replaceFirst('/0/*', '/<0;1>/*')
                .replaceFirst('/1/*', '/<0;1>/*'),
          ),
        )
        .toString()
        .substring(0, 12);
    return descHashId;
  }

  static Future<bdk.Descriptor> deriveDescriptor(
      String path,
      BitcoinScriptType scriptType,
      bdk.DescriptorSecretKey rootXprv,
      bdk.Network network,
      bdk.KeychainKind keychainKind,
      String sourceFingerprint) async {
    print('deriving descriptor: $path');
    final xpriv =
        await rootXprv.derive(await bdk.DerivationPath.create(path: path));
    final xpub = await xpriv.asPublic();

    bdk.Descriptor descriptor;

    if (scriptType == BitcoinScriptType.bip44) {
      descriptor = await bdk.Descriptor.newBip44Public(
          fingerPrint: sourceFingerprint,
          publicKey: xpub,
          network: network,
          keychain: keychainKind);
    } else if (scriptType == BitcoinScriptType.bip49) {
      descriptor = await bdk.Descriptor.newBip49Public(
          fingerPrint: sourceFingerprint,
          publicKey: xpub,
          network: network,
          keychain: keychainKind);
    } else if (scriptType == BitcoinScriptType.bip84) {
      descriptor = await bdk.Descriptor.newBip84Public(
          fingerPrint: sourceFingerprint,
          publicKey: xpub,
          network: network,
          keychain: keychainKind);
    } else if (scriptType == BitcoinScriptType.bip86) {
      descriptor = await bdk.Descriptor.newBip86Public(
          fingerPrint: sourceFingerprint,
          publicKey: xpub,
          network: network,
          keychain: keychainKind);
    } else {
      // Do segwit
      descriptor = await bdk.Descriptor.newBip84Public(
          fingerPrint: sourceFingerprint,
          publicKey: xpub,
          network: network,
          keychain: keychainKind);
    }
    return await bdk.Descriptor.create(
        descriptor: await descriptor.asString(), network: network);
  }

  static Future<List<BitcoinWallet>> initializeAllWallets(Seed seed,
      {List<BitcoinScriptType> scriptType = const [
        BitcoinScriptType.bip44,
        BitcoinScriptType.bip49,
        BitcoinScriptType.bip84,
        BitcoinScriptType.bip86,
      ]}) async {
    const electrumUrl = btcElectrumUrl;
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final bdkBlockchain =
          await BitcoinWalletHelper.getBdkBlockchain(electrumUrl: electrumUrl);

      final walletFutures = scriptType.map((path) => initializeWallet(
          seed: seed,
          blockchain: bdkBlockchain,
          scriptType: path,
          appDocDirPath: appDocDir.path));

      final wallets = await Future.wait(walletFutures);

      return wallets;
    } on bdk.ElectrumException catch (e, stackTrace) {
      Error.throwWithStackTrace(
          BdkElectrumException(e, serverUrl: electrumUrl), stackTrace);
    } catch (e) {
      rethrow;
    }
  }

  static Future<BitcoinWallet> initializeWallet(
      {Seed? seed,
      bdk.Blockchain? blockchain,
      BitcoinScriptType scriptType = BitcoinScriptType.bip84,
      String appDocDirPath = ''}) async {
    if (seed == null || blockchain == null) {
      throw ("Seed is null");
    }

    print(
        'initializing wallet with bip path: $scriptType / ${scriptType.path} / ${scriptType.name}');

    final network = seed.network;
    final (sourceFingerprint, _) = await seed.getBdkFingerprint();
    final bdkMnemonic = await bdk.Mnemonic.fromString(seed.mnemonic);
    final rootXprv = await bdk.DescriptorSecretKey.create(
      network: seed.network.getBdkType,
      mnemonic: bdkMnemonic,
      password: seed.passphrase,
    );

    final networkPath = network.getBdkType == bdk.Network.Bitcoin ? '0h' : '1h';
    const accountPath = '0h';
    final fullPath = 'm/${scriptType.path}/$networkPath/$accountPath';
    final externalDescriptor = await BitcoinWalletHelper.deriveDescriptor(
        fullPath,
        scriptType,
        rootXprv,
        network.getBdkType,
        bdk.KeychainKind.External,
        sourceFingerprint!);
    final internalDescriptor = await BitcoinWalletHelper.deriveDescriptor(
        fullPath,
        scriptType,
        rootXprv,
        network.getBdkType,
        bdk.KeychainKind.Internal,
        sourceFingerprint);
    final walletHashId = BitcoinWalletHelper.createDescriptorHashId(
            await externalDescriptor.asString())
        .substring(0, 12);
    final dbDir = '$appDocDirPath/$walletHashId';
    final dbConfig = BitcoinWalletHelper.walletDbConfig(dbDir);
    final bdkPublicWallet = await bdk.Wallet.create(
        descriptor: externalDescriptor,
        changeDescriptor: internalDescriptor,
        network: network.getBdkType,
        databaseConfig: dbConfig);

    BitcoinWallet wallet = BitcoinWallet(
      id: walletHashId,
      name: '',
      balance: 0,
      txCount: 0,
      type: WalletType.Bitcoin,
      network: network,
      importType: ImportTypes.words12,
      seedFingerprint: sourceFingerprint,
      // breaker: true,
      scriptType: scriptType,
    );
    return wallet.copyWith(
        bdkWallet: bdkPublicWallet, bdkBlockchain: blockchain);
  }

  static Future<BitcoinWallet> loadNativeSdk(BitcoinWallet w, Seed seed) async {
    try {
      print('Loading native sdk for bitcoin wallet');

      if (w.importType == ImportTypes.words12) {
        BitcoinWallet loadedWallet =
            (await BitcoinWalletHelper.initializeAllWallets(seed,
                    scriptType: [w.scriptType]))
                .first;
        return w.copyWith(
            bdkBlockchain: loadedWallet.bdkBlockchain,
            bdkWallet: loadedWallet.bdkWallet);
      }

      return BitcoinWallet(
        id: 'id',
        name: 'name',
        balance: 0,
        txCount: 0,
        type: WalletType.Bitcoin,
        network: NetworkType.Testnet,
        // breaker: true,
        seedFingerprint: '',
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Wallet> syncWallet(BitcoinWallet w) async {
    print('Syncing via bdk');

    if (w.bdkWallet == null) {
      throw ('bdk not initialized');
    }

    await w.bdkWallet?.sync(w.bdkBlockchain!);

    final bal = await w.bdkWallet?.getBalance();
    final balance = bal?.confirmed ?? 0;
    print('balance is $balance');

    final txs = await w.bdkWallet?.listTransactions(false);

    return w.copyWith(
        balance: balance, txCount: txs?.length ?? 0, lastSync: DateTime.now());
  }
}
