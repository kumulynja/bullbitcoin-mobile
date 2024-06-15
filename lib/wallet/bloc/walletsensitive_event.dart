part of 'walletsensitive_bloc.dart';

class WalletSensitiveEvent {}

class DeriveWalletFromStoredSeed extends WalletSensitiveEvent {
  final Seed seed;
  final String walletName;
  final WalletType walletType;
  final NetworkType networkType;

  DeriveWalletFromStoredSeed(
      {required this.seed,
      required this.walletName,
      required this.walletType,
      required this.networkType});
}

class CreateNewSeed extends WalletSensitiveEvent {
  final WalletType? walletType;
  final NetworkType? networkType;

  CreateNewSeed({this.walletType, this.networkType});
}

class PersistSeedForWalletId extends WalletSensitiveEvent {
  final Seed seed;
  final String walletId;
  PersistSeedForWalletId({required this.seed, required this.walletId});
}
