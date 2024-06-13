import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_state.freezed.dart';

@freezed
class WalletState extends ExceptionState with _$WalletState {
  const factory WalletState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(null) Wallet? wallet,
    @Default(null) BBException? error,
  }) = _WalletState;

  factory WalletState.initial() => const WalletState();
}
