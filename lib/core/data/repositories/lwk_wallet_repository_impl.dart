import 'package:bb_mobile/core/domain/entities/address.dart';
import 'package:bb_mobile/core/domain/entities/balance.dart';
import 'package:bb_mobile/core/domain/entities/wallet_metadata.dart';
import 'package:bb_mobile/core/domain/repositories/liquid_wallet_repository.dart';
import 'package:bb_mobile/core/domain/repositories/wallet_repository.dart';
import 'package:lwk/lwk.dart' as lwk;

class LwkWalletRepositoryImpl
    implements WalletRepository, LiquidWalletRepository {
  final String _id;
  final Network _network;
  final lwk.Wallet _publicWallet;

  const LwkWalletRepositoryImpl({
    required String id,
    required Network network,
    required lwk.Wallet publicWallet,
  })  : _id = id,
        _network = network,
        _publicWallet = publicWallet;

  @override
  String get id => _id;

  @override
  Network get network => _network;

  @override
  Future<Balance> getBalance() async {
    final balances = await _publicWallet.balances();

    final lBtcAssetBalance = balances
        .firstWhere(
          (balance) =>
              network == Network.liquidMainnet &&
                  balance.assetId ==
                      '6f0279e9ed041c3d710a9f57d0c02928416460c4b722ae3457a11eec381c526d' ||
              network == Network.liquidTestnet &&
                  balance.assetId ==
                      '144c654344aa716d6f3abcc1ca90e5641e4e2a7f633bc09fe3baf64585819a49',
        )
        .value;

    final balance = Balance(
      confirmedSat: BigInt.from(lBtcAssetBalance),
      immatureSat: BigInt.zero,
      trustedPendingSat: BigInt.zero,
      untrustedPendingSat: BigInt.zero,
      spendableSat: BigInt.from(lBtcAssetBalance),
      totalSat: BigInt.from(lBtcAssetBalance),
    );

    return balance;
  }

  @override
  Future<Address> getNewAddress() async {
    final lastUnusedAddressInfo = await _publicWallet.addressLastUnused();
    final newIndex = lastUnusedAddressInfo.index + 1;
    final addressInfo = await _publicWallet.address(index: newIndex);

    final address = Address.liquid(
      index: addressInfo.index,
      address: addressInfo.confidential,
      kind: AddressKind.external,
      state: AddressStatus.unused,
    );

    return address;
  }

  @override
  Future<Address> getAddressByIndex(int index) async {
    final addressInfo = await _publicWallet.address(index: index);

    final address = Address.liquid(
      index: addressInfo.index,
      address: addressInfo.confidential,
      kind: AddressKind.external,
      state: AddressStatus.used,
      // TODO: add more fields
    );

    return address;
  }

  @override
  Future<Address> getLastUnusedAddress() async {
    final addressInfo = await _publicWallet.addressLastUnused();

    final address = Address.liquid(
      index: addressInfo.index,
      address: addressInfo.confidential,
      kind: AddressKind.external,
      state: AddressStatus.unused,
      // TODO: add more fields
    );

    return address;
  }

  @override
  Future<void> sync({
    required String blockchainUrl,
    required bool validateDomain,
  }) async {
    await _publicWallet.sync(
      electrumUrl: blockchainUrl,
      validateDomain: validateDomain,
    );
  }
}
