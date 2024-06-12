import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_state.freezed.dart';

@freezed
class WalletState extends ErrorState with _$WalletState {
  const factory WalletState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default([]) List<LoadStatus> syncWalletStatus,
    @Default([]) List<Wallet> wallets,
    // TODO: Will be a problem, if at all a future requirement needs user to work with multiple wallets at a time.
    @Default(null) Wallet? selectedWallet,
    @Default(null) Error? error,
  }) = _WalletState;

  factory WalletState.initial() => const WalletState(wallets: []);
}
