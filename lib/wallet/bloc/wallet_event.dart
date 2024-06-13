part of 'wallet_bloc.dart';

class WalletEvent {}

class LoadWallet extends WalletEvent {
  final Wallet wallet;
  LoadWallet({required this.wallet});
}

class SyncWallet extends WalletEvent {}

class WalletSyncStatusUpdated extends WalletEvent {}

class PersistWallet extends WalletEvent {
  final Wallet wallet;
  PersistWallet({required this.wallet});
}
