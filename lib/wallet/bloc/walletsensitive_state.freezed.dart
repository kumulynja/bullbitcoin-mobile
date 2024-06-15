// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'walletsensitive_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletSensitiveState {
  Seed? get seed => throw _privateConstructorUsedError;
  LoadStatus get status => throw _privateConstructorUsedError;
  List<LoadStatus> get syncDerivedWalletStatus =>
      throw _privateConstructorUsedError;
  List<Wallet> get derivedWallets => throw _privateConstructorUsedError;
  String get walletName => throw _privateConstructorUsedError;
  BBException<dynamic>? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletSensitiveStateCopyWith<WalletSensitiveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletSensitiveStateCopyWith<$Res> {
  factory $WalletSensitiveStateCopyWith(WalletSensitiveState value,
          $Res Function(WalletSensitiveState) then) =
      _$WalletSensitiveStateCopyWithImpl<$Res, WalletSensitiveState>;
  @useResult
  $Res call(
      {Seed? seed,
      LoadStatus status,
      List<LoadStatus> syncDerivedWalletStatus,
      List<Wallet> derivedWallets,
      String walletName,
      BBException<dynamic>? error});

  $SeedCopyWith<$Res>? get seed;
}

/// @nodoc
class _$WalletSensitiveStateCopyWithImpl<$Res,
        $Val extends WalletSensitiveState>
    implements $WalletSensitiveStateCopyWith<$Res> {
  _$WalletSensitiveStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = freezed,
    Object? status = null,
    Object? syncDerivedWalletStatus = null,
    Object? derivedWallets = null,
    Object? walletName = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as Seed?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      syncDerivedWalletStatus: null == syncDerivedWalletStatus
          ? _value.syncDerivedWalletStatus
          : syncDerivedWalletStatus // ignore: cast_nullable_to_non_nullable
              as List<LoadStatus>,
      derivedWallets: null == derivedWallets
          ? _value.derivedWallets
          : derivedWallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as BBException<dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SeedCopyWith<$Res>? get seed {
    if (_value.seed == null) {
      return null;
    }

    return $SeedCopyWith<$Res>(_value.seed!, (value) {
      return _then(_value.copyWith(seed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletSensitiveStateImplCopyWith<$Res>
    implements $WalletSensitiveStateCopyWith<$Res> {
  factory _$$WalletSensitiveStateImplCopyWith(_$WalletSensitiveStateImpl value,
          $Res Function(_$WalletSensitiveStateImpl) then) =
      __$$WalletSensitiveStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Seed? seed,
      LoadStatus status,
      List<LoadStatus> syncDerivedWalletStatus,
      List<Wallet> derivedWallets,
      String walletName,
      BBException<dynamic>? error});

  @override
  $SeedCopyWith<$Res>? get seed;
}

/// @nodoc
class __$$WalletSensitiveStateImplCopyWithImpl<$Res>
    extends _$WalletSensitiveStateCopyWithImpl<$Res, _$WalletSensitiveStateImpl>
    implements _$$WalletSensitiveStateImplCopyWith<$Res> {
  __$$WalletSensitiveStateImplCopyWithImpl(_$WalletSensitiveStateImpl _value,
      $Res Function(_$WalletSensitiveStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = freezed,
    Object? status = null,
    Object? syncDerivedWalletStatus = null,
    Object? derivedWallets = null,
    Object? walletName = null,
    Object? error = freezed,
  }) {
    return _then(_$WalletSensitiveStateImpl(
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as Seed?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      syncDerivedWalletStatus: null == syncDerivedWalletStatus
          ? _value._syncDerivedWalletStatus
          : syncDerivedWalletStatus // ignore: cast_nullable_to_non_nullable
              as List<LoadStatus>,
      derivedWallets: null == derivedWallets
          ? _value._derivedWallets
          : derivedWallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as BBException<dynamic>?,
    ));
  }
}

/// @nodoc

class _$WalletSensitiveStateImpl implements _WalletSensitiveState {
  const _$WalletSensitiveStateImpl(
      {this.seed,
      this.status = LoadStatus.initial,
      final List<LoadStatus> syncDerivedWalletStatus = const [],
      final List<Wallet> derivedWallets = const [],
      this.walletName = '',
      this.error = null})
      : _syncDerivedWalletStatus = syncDerivedWalletStatus,
        _derivedWallets = derivedWallets;

  @override
  final Seed? seed;
  @override
  @JsonKey()
  final LoadStatus status;
  final List<LoadStatus> _syncDerivedWalletStatus;
  @override
  @JsonKey()
  List<LoadStatus> get syncDerivedWalletStatus {
    if (_syncDerivedWalletStatus is EqualUnmodifiableListView)
      return _syncDerivedWalletStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syncDerivedWalletStatus);
  }

  final List<Wallet> _derivedWallets;
  @override
  @JsonKey()
  List<Wallet> get derivedWallets {
    if (_derivedWallets is EqualUnmodifiableListView) return _derivedWallets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_derivedWallets);
  }

  @override
  @JsonKey()
  final String walletName;
  @override
  @JsonKey()
  final BBException<dynamic>? error;

  @override
  String toString() {
    return 'WalletSensitiveState(seed: $seed, status: $status, syncDerivedWalletStatus: $syncDerivedWalletStatus, derivedWallets: $derivedWallets, walletName: $walletName, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletSensitiveStateImpl &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
                other._syncDerivedWalletStatus, _syncDerivedWalletStatus) &&
            const DeepCollectionEquality()
                .equals(other._derivedWallets, _derivedWallets) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      seed,
      status,
      const DeepCollectionEquality().hash(_syncDerivedWalletStatus),
      const DeepCollectionEquality().hash(_derivedWallets),
      walletName,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletSensitiveStateImplCopyWith<_$WalletSensitiveStateImpl>
      get copyWith =>
          __$$WalletSensitiveStateImplCopyWithImpl<_$WalletSensitiveStateImpl>(
              this, _$identity);
}

abstract class _WalletSensitiveState implements WalletSensitiveState {
  const factory _WalletSensitiveState(
      {final Seed? seed,
      final LoadStatus status,
      final List<LoadStatus> syncDerivedWalletStatus,
      final List<Wallet> derivedWallets,
      final String walletName,
      final BBException<dynamic>? error}) = _$WalletSensitiveStateImpl;

  @override
  Seed? get seed;
  @override
  LoadStatus get status;
  @override
  List<LoadStatus> get syncDerivedWalletStatus;
  @override
  List<Wallet> get derivedWallets;
  @override
  String get walletName;
  @override
  BBException<dynamic>? get error;
  @override
  @JsonKey(ignore: true)
  _$$WalletSensitiveStateImplCopyWith<_$WalletSensitiveStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
