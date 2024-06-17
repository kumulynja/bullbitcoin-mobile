import 'dart:core';

import 'package:bb_arch/_pkg/address/models/bitcoin_address.dart';
import 'package:bb_arch/_pkg/address/models/liquid_address.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:isar/isar.dart';

part 'address.g.dart';

@Collection(ignore: {'copyWith'})
class Address {
  Id isarId = Isar.autoIncrement;

  @Index()
  String address = '';

  String? regularAddress = '';

  @Index()
  int index = 0;

  @Index()
  @Enumerated(EnumType.ordinal)
  AddressKind kind = AddressKind.deposit;

  @Index()
  @Enumerated(EnumType.ordinal)
  AddressStatus status = AddressStatus.unused;

  @Enumerated(EnumType.ordinal)
  AddressType type = AddressType.Bitcoin;

  int balance = 0;

  bool spendable = true;

  List<String>? labels;

  int txCount = 0;

  List<String> txIds = [];
  List<String> receiveTxIds = [];
  List<String> sendTxIds = [];

  @Index()
  bool frozen = false;

  @Index()
  String walletId = '';

  Map<String, dynamic> toJson() {
    if (this is BitcoinAddress) {
      return (this as BitcoinAddress).toJson();
    } else if (this is LiquidAddress) {
      return (this as LiquidAddress).toJson();
    }

    return {
      'isarId': isarId,
      'address': address,
      'regularAddress': regularAddress ?? '',
      'index': index,
      'kind': kind.toString().split('.').last,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'balance': balance,
      'spendable': spendable,
      'labels': labels,
      'txCount': txCount,
      'txIds': txIds,
      'receiveTxIds': receiveTxIds,
      'sendTxIds': sendTxIds,
      'frozen': frozen,
      'walletId': walletId,
    };
  }

  static Address fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'] == AddressType.Bitcoin.name) {
      return BitcoinAddress.fromJson(json);
      // } else if (json.containsKey('type') && json['type'] == TxType.Liquid.name) {
      //   return LiquidAddress.fromJson(json);
    }
    throw UnimplementedError('Unsupported Address subclass');
  }

  static Future<Address> getLastUnused(Wallet w, AddressKind kind) {
    if (w.type == WalletType.Bitcoin) {
      return BitcoinAddress.getLastUnused(w as BitcoinWallet, kind);
    } else if (w.type == WalletType.Liquid) {
      return LiquidAddress.getLastUnused(w as LiquidWallet);
    }
    throw UnimplementedError('Unsupported Address subclass');
  }

  static Future<Address> loadFromNative(
      dynamic addr, Wallet w, AddressKind kind) async {
    if (w.type == WalletType.Bitcoin) {
      return BitcoinAddress.loadFromNative(addr, w as BitcoinWallet, kind);
    } else if (w.type == WalletType.Liquid) {
      return LiquidAddress.loadFromNative(addr, w as LiquidWallet);
    }
    throw UnimplementedError('Unsupported Tx subclass');
  }

  static Future<List<Address>> syncAddresses(List<Tx> txs, Address lastUnused,
      List<Address> oldAddresses, Wallet wallet, AddressKind kind) async {
    List<Address> addresses = [];

    for (var i = 0; i <= lastUnused.index; i++) {
      final addr = await wallet.getAddress(i, kind);
      // TODO: How to make contains work with manually implementing == operator? in Address
      // bool exists = oldAddresses.contains(addr);
      // Address finalAddr = exists ? oldAddresses.firstWhere((element) => element.address == addr.address) : addr;
      // Address finalAddr = addr;

      // Pick from Txs
      if (wallet.type == WalletType.Bitcoin) {
        Address finalBitcoinAddr = BitcoinAddress.processAddress(txs,
            lastUnused, oldAddresses, wallet, kind, addr as BitcoinAddress);
        addresses.add(finalBitcoinAddr);
      } else if (wallet.type == WalletType.Liquid) {
        Address finalBitcoinAddr = LiquidAddress.processAddress(
            txs, lastUnused, oldAddresses, wallet, kind, addr as LiquidAddress);
        addresses.add(finalBitcoinAddr);
      }
    }

    addresses.sort((a, b) {
      return b.index.compareTo(a.index);
    });
    return addresses;
  }

  // TODO: Is this the right place to do this?
  /// Converts
  ///   List<Address, Address, Address, Address>
  /// to
  ///   List<BitcoinAddress, LiquidAddress, BitcoinAddress, LiquidAddress>
  static List<Address> mapBaseToChild(List<Address> addresses) {
    return addresses.map((addr) {
      if (addr.type == AddressType.Bitcoin) {
        return BitcoinAddress.fromJson(addr.toJson());
      } else if (addr.type == AddressType.Liquid) {
        return LiquidAddress.fromJson(addr.toJson());
      }
      return addr;
    }).toList();
  }
}

enum AddressKind {
  deposit,
  change,
  external,
  confidential,
}

enum AddressStatus {
  unused,
  active,
  used,
  copied,
}

enum AddressType { Bitcoin, Liquid, Lightning, Usdt }

extension AddressTypeExtension on AddressType {
  String get name {
    switch (this) {
      case AddressType.Bitcoin:
        return 'Bitcoin';
      case AddressType.Liquid:
        return 'Liquid';
      case AddressType.Lightning:
        return 'Lightning';
      case AddressType.Usdt:
        return 'Usdt';
    }
  }
}
