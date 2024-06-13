part of 'walletlist_bloc.dart';

class WalletListEvent {}

class LoadAllWallets extends WalletListEvent {
  LoadAllWallets();
}

class SyncAllWallets extends WalletListEvent {
  SyncAllWallets();
}

class SelectWallet extends WalletListEvent {
  final Wallet wallet;
  SelectWallet({required this.wallet});
}
