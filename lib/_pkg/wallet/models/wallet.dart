// ignore_for_file: constant_identifier_names

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/bitcoin_wallet_helper.dart';
import 'package:bb_arch/_pkg/wallet/liquid_wallet_helper.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:isar/isar.dart';

part 'wallet.g.dart';

@Collection(ignore: {'copyWith'})
class Wallet {
  Id isarId = Isar.autoIncrement;

  @Index()
  String id = '';

  String name = '';
  int balance = 0;
  int txCount = 0;

  @Enumerated(EnumType.ordinal)
  WalletType type = WalletType.Bitcoin;

  @Index()
  @Enumerated(EnumType.ordinal)
  NetworkType network = NetworkType.Mainnet;

  String seedFingerprint = '';

  @Enumerated(EnumType.ordinal32)
  BitcoinScriptType? scriptType = BitcoinScriptType.bip84;

  bool backupTested = false;
  DateTime? lastBackupTested;
  DateTime? lastSync;

  @Enumerated(EnumType.ordinal32)
  ImportTypes? importType;

  static Wallet fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'] == WalletType.Bitcoin.name) {
      return BitcoinWallet.fromJson(json);
    } else if (json.containsKey('type') &&
        json['type'] == WalletType.Liquid.name) {
      return LiquidWallet.fromJson(json);
    }
    throw UnimplementedError('Unsupported Wallet subclass');
  }

  Map<String, dynamic> toJson() {
    if (this is BitcoinWallet) {
      return (this as BitcoinWallet).toJson();
    } else if (this is LiquidWallet) {
      return (this as LiquidWallet).toJson();
    }

    return {
      'isarId': isarId,
      'id': id,
      'name': name,
      'balance': balance,
      'txCount': txCount,
      'type': type.name,
      'network': network.name,
      'seedFingerprint': seedFingerprint,
      'scriptType': scriptType?.toString().split('.').last,
      'backupTested': backupTested,
      'lastBackupTested': lastBackupTested?.toIso8601String(),
      'lastSync': lastSync?.toIso8601String(),
      'importType': importType?.name,
    };
  }

  static Future<Wallet> loadNativeSdk(Wallet w, Seed seed) async {
    if (w.type == WalletType.Bitcoin) {
      return BitcoinWalletHelper.loadNativeSdk(w as BitcoinWallet, seed);
    } else if (w.type == WalletType.Liquid) {
      return LiquidWalletHelper.loadNativeSdk(w as LiquidWallet, seed);
    }
    throw UnimplementedError('Unsupported Wallet subclass');
  }

  static Future<Wallet> syncWallet(Wallet wallet) {
    if (wallet.type == WalletType.Bitcoin) {
      return BitcoinWalletHelper.syncWallet(wallet as BitcoinWallet);
    } else if (wallet.type == WalletType.Liquid) {
      return LiquidWalletHelper.syncWallet(wallet as LiquidWallet);
    }
    throw UnimplementedError('Unsupported Wallet subclass');
  }

  Future<List<Tx>> getTxs(Wallet wallet, List<Tx> storedTxs) async {
    List<Tx> txs = [];
    return txs;
  }

  Future<Address> getAddress(int index, AddressKind kind) async {
    return Address();
  }

  Future<void> buildTx(Address address, int amount, Seed seed) async {
    // if (type == WalletType.Bitcoin) {
    //   return wallet.send(address, amount);
    // } else if (type == WalletType.Liquid) {
    //   return LiquidWallet.send(wallet as LiquidWallet, address, amount);
    // }
    // throw UnimplementedError('Unsupported Wallet subclass');
  }

  Future<Wallet> initializePrivateWallet(Seed seed) async {
    return this;
  }

  // TODO: Is this the right place to do this?
  /// Converts
  ///   List<Wallet, Wallet, Wallet, Wallet>
  /// to
  ///   List<BitcoinWallet, LiquidWallet, BitcoinWallet, FiatWallet>
  static List<Wallet> mapBaseToChild(List<Wallet> ws) {
    return ws.map((w) {
      if (w.type == WalletType.Bitcoin) {
        return BitcoinWallet.fromJson(w.toJson());
      } else if (w.type == WalletType.Liquid) {
        return LiquidWallet.fromJson(w.toJson());
      }
      return w;
    }).toList();
  }
}

enum WalletType { Bitcoin, Liquid, Lightning, Usdt }

extension WalletTypeExtension on WalletType {
  String get name {
    switch (this) {
      case WalletType.Bitcoin:
        return 'Bitcoin';
      case WalletType.Liquid:
        return 'Liquid';
      case WalletType.Lightning:
        return 'Lightning';
      case WalletType.Usdt:
        return 'Usdt';
    }
  }

  static WalletType fromString(String name) {
    switch (name) {
      case 'Bitcoin':
        return WalletType.Bitcoin;
      case 'Liquid':
        return WalletType.Liquid;
      case 'Lightning':
        return WalletType.Lightning;
      case 'Usdt':
        return WalletType.Usdt;
    }
    return WalletType.Bitcoin;
  }
}

enum NetworkType { Mainnet, Testnet, Signet }

extension NetworkTypeExtension on NetworkType {
  String get name {
    switch (this) {
      case NetworkType.Mainnet:
        return 'Mainnet';
      case NetworkType.Testnet:
        return 'Testnet';
      case NetworkType.Signet:
        return 'Signet';
    }
  }
}

enum BitcoinScriptType { bip86, bip84, bip49, bip44 }

extension BitcoinScriptTypeExtension on BitcoinScriptType {
  String get name {
    switch (this) {
      case BitcoinScriptType.bip44:
        return 'Legacy pubkey';
      case BitcoinScriptType.bip49:
        return 'Legacy script';
      case BitcoinScriptType.bip84:
        return 'Segwit';
      case BitcoinScriptType.bip86:
        return 'Taproot';
    }
  }

  String get path {
    switch (this) {
      case BitcoinScriptType.bip44:
        return '44h';
      case BitcoinScriptType.bip49:
        return '49h';
      case BitcoinScriptType.bip84:
        return '84h';
      case BitcoinScriptType.bip86:
        return '84h';
    }
  }
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}