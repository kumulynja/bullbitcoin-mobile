// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'walletlist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletListState {
  LoadStatus get status => throw _privateConstructorUsedError;
  List<WalletBloc> get walletBlocs => throw _privateConstructorUsedError;
  Wallet? get selectedWallet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletListStateCopyWith<WalletListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletListStateCopyWith<$Res> {
  factory $WalletListStateCopyWith(
          WalletListState value, $Res Function(WalletListState) then) =
      _$WalletListStateCopyWithImpl<$Res, WalletListState>;
  @useResult
  $Res call(
      {LoadStatus status,
      List<WalletBloc> walletBlocs,
      Wallet? selectedWallet});
}

/// @nodoc
class _$WalletListStateCopyWithImpl<$Res, $Val extends WalletListState>
    implements $WalletListStateCopyWith<$Res> {
  _$WalletListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? walletBlocs = null,
    Object? selectedWallet = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      walletBlocs: null == walletBlocs
          ? _value.walletBlocs
          : walletBlocs // ignore: cast_nullable_to_non_nullable
              as List<WalletBloc>,
      selectedWallet: freezed == selectedWallet
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletListStateImplCopyWith<$Res>
    implements $WalletListStateCopyWith<$Res> {
  factory _$$WalletListStateImplCopyWith(_$WalletListStateImpl value,
          $Res Function(_$WalletListStateImpl) then) =
      __$$WalletListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadStatus status,
      List<WalletBloc> walletBlocs,
      Wallet? selectedWallet});
}

/// @nodoc
class __$$WalletListStateImplCopyWithImpl<$Res>
    extends _$WalletListStateCopyWithImpl<$Res, _$WalletListStateImpl>
    implements _$$WalletListStateImplCopyWith<$Res> {
  __$$WalletListStateImplCopyWithImpl(
      _$WalletListStateImpl _value, $Res Function(_$WalletListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? walletBlocs = null,
    Object? selectedWallet = freezed,
  }) {
    return _then(_$WalletListStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      walletBlocs: null == walletBlocs
          ? _value._walletBlocs
          : walletBlocs // ignore: cast_nullable_to_non_nullable
              as List<WalletBloc>,
      selectedWallet: freezed == selectedWallet
          ? _value.selectedWallet
          : selectedWallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
    ));
  }
}

/// @nodoc

class _$WalletListStateImpl implements _WalletListState {
  const _$WalletListStateImpl(
      {this.status = LoadStatus.initial,
      final List<WalletBloc> walletBlocs = const [],
      this.selectedWallet = null})
      : _walletBlocs = walletBlocs;

  @override
  @JsonKey()
  final LoadStatus status;
  final List<WalletBloc> _walletBlocs;
  @override
  @JsonKey()
  List<WalletBloc> get walletBlocs {
    if (_walletBlocs is EqualUnmodifiableListView) return _walletBlocs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walletBlocs);
  }

  @override
  @JsonKey()
  final Wallet? selectedWallet;

  @override
  String toString() {
    return 'WalletListState(status: $status, walletBlocs: $walletBlocs, selectedWallet: $selectedWallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletListStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._walletBlocs, _walletBlocs) &&
            (identical(other.selectedWallet, selectedWallet) ||
                other.selectedWallet == selectedWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_walletBlocs), selectedWallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletListStateImplCopyWith<_$WalletListStateImpl> get copyWith =>
      __$$WalletListStateImplCopyWithImpl<_$WalletListStateImpl>(
          this, _$identity);
}

abstract class _WalletListState implements WalletListState {
  const factory _WalletListState(
      {final LoadStatus status,
      final List<WalletBloc> walletBlocs,
      final Wallet? selectedWallet}) = _$WalletListStateImpl;

  @override
  LoadStatus get status;
  @override
  List<WalletBloc> get walletBlocs;
  @override
  Wallet? get selectedWallet;
  @override
  @JsonKey(ignore: true)
  _$$WalletListStateImplCopyWith<_$WalletListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
