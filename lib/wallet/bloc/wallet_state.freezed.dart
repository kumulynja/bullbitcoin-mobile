// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletState {
  LoadStatus get status => throw _privateConstructorUsedError;
  List<LoadStatus> get syncWalletStatus => throw _privateConstructorUsedError;
  List<Wallet> get wallets =>
      throw _privateConstructorUsedError; // TODO: Will be a problem, if at all a future requirement needs user to work with multiple wallets at a time.
  Wallet? get selectedWallet => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call(
      {LoadStatus status,
      List<LoadStatus> syncWalletStatus,
      List<Wallet> wallets,
      Wallet? selectedWallet,
      Error? error});
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? syncWalletStatus = null,
    Object? wallets = null,
    Object? selectedWallet = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      syncWalletStatus: null == syncWalletStatus
          ? _value.syncWalletStatus
          : syncWalletStatus // ignore: cast_nullable_to_non_nullable
              as List<LoadStatus>,
      wallets: null == wallets
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
      selectedWallet: freezed == selectedWallet
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletStateImplCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$WalletStateImplCopyWith(
          _$WalletStateImpl value, $Res Function(_$WalletStateImpl) then) =
      __$$WalletStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadStatus status,
      List<LoadStatus> syncWalletStatus,
      List<Wallet> wallets,
      Wallet? selectedWallet,
      Error? error});
}

/// @nodoc
class __$$WalletStateImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletStateImpl>
    implements _$$WalletStateImplCopyWith<$Res> {
  __$$WalletStateImplCopyWithImpl(
      _$WalletStateImpl _value, $Res Function(_$WalletStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? syncWalletStatus = null,
    Object? wallets = null,
    Object? selectedWallet = freezed,
    Object? error = freezed,
  }) {
    return _then(_$WalletStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      syncWalletStatus: null == syncWalletStatus
          ? _value._syncWalletStatus
          : syncWalletStatus // ignore: cast_nullable_to_non_nullable
              as List<LoadStatus>,
      wallets: null == wallets
          ? _value._wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
      selectedWallet: freezed == selectedWallet
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ));
  }
}

/// @nodoc

class _$WalletStateImpl implements _WalletState {
  const _$WalletStateImpl(
      {this.status = LoadStatus.initial,
      final List<LoadStatus> syncWalletStatus = const [],
      final List<Wallet> wallets = const [],
      this.selectedWallet = null,
      this.error = null})
      : _syncWalletStatus = syncWalletStatus,
        _wallets = wallets;

  @override
  @JsonKey()
  final LoadStatus status;
  final List<LoadStatus> _syncWalletStatus;
  @override
  @JsonKey()
  List<LoadStatus> get syncWalletStatus {
    if (_syncWalletStatus is EqualUnmodifiableListView)
      return _syncWalletStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syncWalletStatus);
  }

  final List<Wallet> _wallets;
  @override
  @JsonKey()
  List<Wallet> get wallets {
    if (_wallets is EqualUnmodifiableListView) return _wallets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wallets);
  }

// TODO: Will be a problem, if at all a future requirement needs user to work with multiple wallets at a time.
  @override
  @JsonKey()
  final Wallet? selectedWallet;
  @override
  @JsonKey()
  final Error? error;

  @override
  String toString() {
    return 'WalletState(status: $status, syncWalletStatus: $syncWalletStatus, wallets: $wallets, selectedWallet: $selectedWallet, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._syncWalletStatus, _syncWalletStatus) &&
            const DeepCollectionEquality().equals(other._wallets, _wallets) &&
            (identical(other.selectedWallet, selectedWallet) ||
                other.selectedWallet == selectedWallet) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_syncWalletStatus),
      const DeepCollectionEquality().hash(_wallets),
      selectedWallet,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      __$$WalletStateImplCopyWithImpl<_$WalletStateImpl>(this, _$identity);
}

abstract class _WalletState implements WalletState {
  const factory _WalletState(
      {final LoadStatus status,
      final List<LoadStatus> syncWalletStatus,
      final List<Wallet> wallets,
      final Wallet? selectedWallet,
      final Error? error}) = _$WalletStateImpl;

  @override
  LoadStatus get status;
  @override
  List<LoadStatus> get syncWalletStatus;
  @override
  List<Wallet> get wallets;
  @override // TODO: Will be a problem, if at all a future requirement needs user to work with multiple wallets at a time.
  Wallet? get selectedWallet;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
