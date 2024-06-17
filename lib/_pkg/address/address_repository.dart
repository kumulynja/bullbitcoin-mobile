import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/address/models/bitcoin_address.dart';
import 'package:bb_arch/_pkg/address/models/liquid_address.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:isar/isar.dart';

class AddressRepository {
  AddressRepository({required this.storage, required this.isar});

  Isar isar;
  HiveStorage storage;

  Future<List<Address>> listAddresses(String walletId) async {
    try {
      final addrs = await isar.address
          .where()
          .walletIdEqualTo(walletId)
          .sortByIndex()
          .findAll();

      return Address.mapBaseToChild(addrs);
      // final ads = addrs.map((t) {
      //   if (t.type == AddressType.Bitcoin) {
      //     return BitcoinAddress.fromJson(t.toJson());
      //   } else if (t.type == AddressType.Liquid) {
      //     return LiquidAddress.fromJson(t.toJson());
      //   }
      //   return t;
      // }).toList();
      // final (addrsStr, _) = await storage.getValue('address.${wallet.id}');
      // List<dynamic> addrsJson = jsonDecode(addrsStr!);
      // final addrs = addrsJson.map((adJson) => Address.fromJson(adJson)).toList();
      // return (ads, null);
    } catch (e) {
      rethrow;
    }
  }

  // TODO: Potential optimization: Do this sync/merge only if txlist.length, lastUnused, wallet balance differ from what's there in storage.
  // Otherwise, skip this operation and go with previous calculation that is stored in storage.
  Future<List<Address>> syncAddresses(List<Tx> txs, List<Address> oldAddresses,
      AddressKind kind, Wallet wallet) async {
    try {
      final lastUnused = await Address.getLastUnused(wallet, kind);

      List<Address> addresses = await Address.syncAddresses(
          txs, lastUnused, oldAddresses, wallet, kind);

      return addresses;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> persistAddresses(Wallet wallet, List<Address> addresses) async {
    await isar.writeTxn(() async {
      await isar.address.putAllByIndex("address", addresses);
    });
    //List<Map<String, dynamic>> addressesJson = addresses.map((addr) => addr.toJson()).toList();
    //String encoded = jsonEncode(addressesJson);
    //await storage.saveValue(key: 'addr.${wallet.id}', value: encoded);
  }

  Future<Address> loadAddress(String walletid, String address) async {
    final addresses = await isar.address
        .where()
        .addressEqualTo(address)
        .filter()
        .walletIdEqualTo(walletid)
        .findAll();
    final addr = addresses.first;
    if (addr.type == TxType.Bitcoin) {
      return BitcoinAddress.fromJson(addr.toJson());
    } else if (addr.type == TxType.Liquid) {
      return LiquidAddress.fromJson(addr.toJson());
    }
    return addr;
  }

  Future<void> deleteAllAddressInWallet(String walletId) async {
    await isar.writeTxn(() async {
      final count =
          await isar.address.filter().walletIdEqualTo(walletId).deleteAll();
      print('Objects deleted: $count');
    });
  }
}
