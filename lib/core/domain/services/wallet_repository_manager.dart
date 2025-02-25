import 'package:bb_mobile/core/data/repositories/bdk_wallet_repository_impl.dart';
import 'package:bb_mobile/core/data/repositories/lwk_wallet_repository_impl.dart';
import 'package:bb_mobile/core/domain/entities/settings.dart';
import 'package:bb_mobile/core/domain/entities/wallet_metadata.dart';
import 'package:bb_mobile/core/domain/repositories/wallet_repository.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:lwk/lwk.dart' as lwk;
import 'package:path_provider/path_provider.dart';

abstract class WalletRepositoryManager {
  Future<void> registerWallet(WalletMetadata metadata);
  WalletRepository? getRepository(String walletId);
  List<WalletRepository> getRepositories({Environment? environment});
}

class WalletRepositoryManagerImpl implements WalletRepositoryManager {
  final Map<String, WalletRepository> _repositories = {};

  @override
  Future<void> registerWallet(WalletMetadata metadata) async {
    final id = metadata.id;

    if (_repositories.containsKey(id)) {
      return;
    }

    final repository = await _createRepository(walletMetadata: metadata);
    _repositories[id] = repository;
  }

  @override
  WalletRepository? getRepository(String id) {
    return _repositories[id];
  }

  @override
  List<WalletRepository> getRepositories({Environment? environment}) {
    if (environment == null) {
      // Return all wallets
      return _repositories.values.toList();
    } else if (environment == Environment.mainnet) {
      return _repositories.values
          .where((wallet) => wallet.network.isMainnet)
          .toList();
    } else {
      return _repositories.values
          .where((wallet) => wallet.network.isTestnet)
          .toList();
    }
  }

  Future<WalletRepository> _createRepository({
    required WalletMetadata walletMetadata,
  }) async {
    if (walletMetadata.network.isBitcoin) {
      final wallet = await _createPublicBdkWalletInstance(
        walletId: walletMetadata.id,
        network: walletMetadata.network,
        externalPublicDescriptor: walletMetadata.externalPublicDescriptor,
        internalPublicDescriptor: walletMetadata.internalPublicDescriptor,
      );

      return BdkWalletRepositoryImpl(
        id: walletMetadata.id,
        publicWallet: wallet,
      );
    } else {
      final wallet = await _createPublicLwkWalletInstance(
        walletId: walletMetadata.id,
        network: walletMetadata.network,
        externalPublicDescriptor: walletMetadata.externalPublicDescriptor,
      );
      return LwkWalletRepositoryImpl(
        id: walletMetadata.id,
        network: walletMetadata.network,
        publicWallet: wallet,
      );
    }
  }

  Future<bdk.Wallet> _createPublicBdkWalletInstance({
    required String walletId,
    required Network network,
    required String externalPublicDescriptor,
    required String internalPublicDescriptor,
  }) async {
    final bdkNetwork = network.bdkNetwork;

    final external = await bdk.Descriptor.create(
      descriptor: externalPublicDescriptor,
      network: bdkNetwork,
    );
    final internal = await bdk.Descriptor.create(
      descriptor: internalPublicDescriptor,
      network: bdkNetwork,
    );

    final appDocDir = await getApplicationDocumentsDirectory();
    final String dbDir = '${appDocDir.path}/$walletId';

    final dbConfig = bdk.DatabaseConfig.sqlite(
      config: bdk.SqliteDbConfiguration(path: dbDir),
    );

    final wallet = await bdk.Wallet.create(
      descriptor: external,
      changeDescriptor: internal,
      network: bdkNetwork,
      databaseConfig: dbConfig,
    );

    return wallet;
  }

  Future<lwk.Wallet> _createPublicLwkWalletInstance({
    required String walletId,
    required Network network,
    required String externalPublicDescriptor,
  }) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final String dbDir = '${appDocDir.path}/$walletId';

    final descriptor = lwk.Descriptor(
      ctDescriptor: externalPublicDescriptor,
    );

    final wallet = await lwk.Wallet.init(
      network: network.lwkNetwork,
      dbpath: dbDir,
      descriptor: descriptor,
    );

    return wallet;
  }
}

extension NetworkX on Network {
  bdk.Network get bdkNetwork {
    switch (this) {
      case Network.bitcoinMainnet:
        return bdk.Network.bitcoin;
      case Network.bitcoinTestnet:
        return bdk.Network.testnet;
      case Network.liquidMainnet:
      case Network.liquidTestnet:
        throw WrongNetworkException('Liquid network is not supported by BDK');
    }
  }

  lwk.Network get lwkNetwork {
    switch (this) {
      case Network.liquidMainnet:
        return lwk.Network.mainnet;
      case Network.liquidTestnet:
        return lwk.Network.testnet;
      case Network.bitcoinMainnet:
      case Network.bitcoinTestnet:
        throw WrongNetworkException('Bitcoin network is not supported by LWK');
    }
  }
}

class WrongNetworkException implements Exception {
  final String message;

  WrongNetworkException(this.message);
}
