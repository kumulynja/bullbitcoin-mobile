import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'walletlist_state.freezed.dart';

@freezed
class WalletListState with _$WalletListState {
  const factory WalletListState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default([]) List<WalletBloc> walletBlocs,
    @Default(null) Wallet? selectedWallet,
  }) = _WalletListState;

  factory WalletListState.initial() => const WalletListState();
}
