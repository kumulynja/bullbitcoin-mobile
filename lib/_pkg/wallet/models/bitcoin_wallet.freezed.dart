// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bitcoin_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BitcoinWallet _$BitcoinWalletFromJson(Map<String, dynamic> json) {
  return _BitcoinWallet.fromJson(json);
}

/// @nodoc
mixin _$BitcoinWallet {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get balance => throw _privateConstructorUsedError;
  int get txCount => throw _privateConstructorUsedError;
  WalletType get type => throw _privateConstructorUsedError;
  NetworkType get network => throw _privateConstructorUsedError;
  String get seedFingerprint =>
      throw _privateConstructorUsedError; // required bool breaker,
  BitcoinScriptType get scriptType => throw _privateConstructorUsedError;
  bool get backupTested => throw _privateConstructorUsedError;
  DateTime? get lastBackupTested => throw _privateConstructorUsedError;
  DateTime? get lastSync => throw _privateConstructorUsedError;
  ImportTypes get importType => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bdk.Blockchain? get bdkBlockchain => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bdk.Wallet? get bdkWallet => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bdk.Wallet? get bdkSigningWallet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BitcoinWalletCopyWith<BitcoinWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BitcoinWalletCopyWith<$Res> {
  factory $BitcoinWalletCopyWith(
          BitcoinWallet value, $Res Function(BitcoinWallet) then) =
      _$BitcoinWalletCopyWithImpl<$Res, BitcoinWallet>;
  @useResult
  $Res call(
      {String id,
      String name,
      int balance,
      int txCount,
      WalletType type,
      NetworkType network,
      String seedFingerprint,
      BitcoinScriptType scriptType,
      bool backupTested,
      DateTime? lastBackupTested,
      DateTime? lastSync,
      ImportTypes importType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bdk.Blockchain? bdkBlockchain,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bdk.Wallet? bdkWallet,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bdk.Wallet? bdkSigningWallet});
}

/// @nodoc
class _$BitcoinWalletCopyWithImpl<$Res, $Val extends BitcoinWallet>
    implements $BitcoinWalletCopyWith<$Res> {
  _$BitcoinWalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? balance = null,
    Object? txCount = null,
    Object? type = null,
    Object? network = null,
    Object? seedFingerprint = null,
    Object? scriptType = null,
    Object? backupTested = null,
    Object? lastBackupTested = freezed,
    Object? lastSync = freezed,
    Object? importType = null,
    Object? bdkBlockchain = freezed,
    Object? bdkWallet = freezed,
    Object? bdkSigningWallet = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      txCount: null == txCount
          ? _value.txCount
          : txCount // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WalletType,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      seedFingerprint: null == seedFingerprint
          ? _value.seedFingerprint
          : seedFingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      scriptType: null == scriptType
          ? _value.scriptType
          : scriptType // ignore: cast_nullable_to_non_nullable
              as BitcoinScriptType,
      backupTested: null == backupTested
          ? _value.backupTested
          : backupTested // ignore: cast_nullable_to_non_nullable
              as bool,
      lastBackupTested: freezed == lastBackupTested
          ? _value.lastBackupTested
          : lastBackupTested // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSync: freezed == lastSync
          ? _value.lastSync
          : lastSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      importType: null == importType
          ? _value.importType
          : importType // ignore: cast_nullable_to_non_nullable
              as ImportTypes,
      bdkBlockchain: freezed == bdkBlockchain
          ? _value.bdkBlockchain
          : bdkBlockchain // ignore: cast_nullable_to_non_nullable
              as bdk.Blockchain?,
      bdkWallet: freezed == bdkWallet
          ? _value.bdkWallet
          : bdkWallet // ignore: cast_nullable_to_non_nullable
              as bdk.Wallet?,
      bdkSigningWallet: freezed == bdkSigningWallet
          ? _value.bdkSigningWallet
          : bdkSigningWallet // ignore: cast_nullable_to_non_nullable
              as bdk.Wallet?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BitcoinWalletImplCopyWith<$Res>
    implements $BitcoinWalletCopyWith<$Res> {
  factory _$$BitcoinWalletImplCopyWith(
          _$BitcoinWalletImpl value, $Res Function(_$BitcoinWalletImpl) then) =
      __$$BitcoinWalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int balance,
      int txCount,
      WalletType type,
      NetworkType network,
      String seedFingerprint,
      BitcoinScriptType scriptType,
      bool backupTested,
      DateTime? lastBackupTested,
      DateTime? lastSync,
      ImportTypes importType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bdk.Blockchain? bdkBlockchain,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bdk.Wallet? bdkWallet,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bdk.Wallet? bdkSigningWallet});
}

/// @nodoc
class __$$BitcoinWalletImplCopyWithImpl<$Res>
    extends _$BitcoinWalletCopyWithImpl<$Res, _$BitcoinWalletImpl>
    implements _$$BitcoinWalletImplCopyWith<$Res> {
  __$$BitcoinWalletImplCopyWithImpl(
      _$BitcoinWalletImpl _value, $Res Function(_$BitcoinWalletImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? balance = null,
    Object? txCount = null,
    Object? type = null,
    Object? network = null,
    Object? seedFingerprint = null,
    Object? scriptType = null,
    Object? backupTested = null,
    Object? lastBackupTested = freezed,
    Object? lastSync = freezed,
    Object? importType = null,
    Object? bdkBlockchain = freezed,
    Object? bdkWallet = freezed,
    Object? bdkSigningWallet = freezed,
  }) {
    return _then(_$BitcoinWalletImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      txCount: null == txCount
          ? _value.txCount
          : txCount // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WalletType,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      seedFingerprint: null == seedFingerprint
          ? _value.seedFingerprint
          : seedFingerprint // ignore: cast_nullable_to_non_nullable
              as String,
      scriptType: null == scriptType
          ? _value.scriptType
          : scriptType // ignore: cast_nullable_to_non_nullable
              as BitcoinScriptType,
      backupTested: null == backupTested
          ? _value.backupTested
          : backupTested // ignore: cast_nullable_to_non_nullable
              as bool,
      lastBackupTested: freezed == lastBackupTested
          ? _value.lastBackupTested
          : lastBackupTested // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSync: freezed == lastSync
          ? _value.lastSync
          : lastSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      importType: null == importType
          ? _value.importType
          : importType // ignore: cast_nullable_to_non_nullable
              as ImportTypes,
      bdkBlockchain: freezed == bdkBlockchain
          ? _value.bdkBlockchain
          : bdkBlockchain // ignore: cast_nullable_to_non_nullable
              as bdk.Blockchain?,
      bdkWallet: freezed == bdkWallet
          ? _value.bdkWallet
          : bdkWallet // ignore: cast_nullable_to_non_nullable
              as bdk.Wallet?,
      bdkSigningWallet: freezed == bdkSigningWallet
          ? _value.bdkSigningWallet
          : bdkSigningWallet // ignore: cast_nullable_to_non_nullable
              as bdk.Wallet?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BitcoinWalletImpl extends _BitcoinWallet {
  _$BitcoinWalletImpl(
      {required this.id,
      required this.name,
      required this.balance,
      required this.txCount,
      required this.type,
      required this.network,
      required this.seedFingerprint,
      this.scriptType = BitcoinScriptType.bip84,
      this.backupTested = false,
      this.lastBackupTested,
      this.lastSync,
      this.importType = ImportTypes.words12,
      @JsonKey(includeFromJson: false, includeToJson: false) this.bdkBlockchain,
      @JsonKey(includeFromJson: false, includeToJson: false) this.bdkWallet,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.bdkSigningWallet})
      : super._();

  factory _$BitcoinWalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$BitcoinWalletImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int balance;
  @override
  final int txCount;
  @override
  final WalletType type;
  @override
  final NetworkType network;
  @override
  final String seedFingerprint;
// required bool breaker,
  @override
  @JsonKey()
  final BitcoinScriptType scriptType;
  @override
  @JsonKey()
  final bool backupTested;
  @override
  final DateTime? lastBackupTested;
  @override
  final DateTime? lastSync;
  @override
  @JsonKey()
  final ImportTypes importType;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bdk.Blockchain? bdkBlockchain;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bdk.Wallet? bdkWallet;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bdk.Wallet? bdkSigningWallet;

  @override
  String toString() {
    return 'BitcoinWallet(id: $id, name: $name, balance: $balance, txCount: $txCount, type: $type, network: $network, seedFingerprint: $seedFingerprint, scriptType: $scriptType, backupTested: $backupTested, lastBackupTested: $lastBackupTested, lastSync: $lastSync, importType: $importType, bdkBlockchain: $bdkBlockchain, bdkWallet: $bdkWallet, bdkSigningWallet: $bdkSigningWallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BitcoinWalletImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.txCount, txCount) || other.txCount == txCount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.seedFingerprint, seedFingerprint) ||
                other.seedFingerprint == seedFingerprint) &&
            (identical(other.scriptType, scriptType) ||
                other.scriptType == scriptType) &&
            (identical(other.backupTested, backupTested) ||
                other.backupTested == backupTested) &&
            (identical(other.lastBackupTested, lastBackupTested) ||
                other.lastBackupTested == lastBackupTested) &&
            (identical(other.lastSync, lastSync) ||
                other.lastSync == lastSync) &&
            (identical(other.importType, importType) ||
                other.importType == importType) &&
            (identical(other.bdkBlockchain, bdkBlockchain) ||
                other.bdkBlockchain == bdkBlockchain) &&
            (identical(other.bdkWallet, bdkWallet) ||
                other.bdkWallet == bdkWallet) &&
            (identical(other.bdkSigningWallet, bdkSigningWallet) ||
                other.bdkSigningWallet == bdkSigningWallet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      balance,
      txCount,
      type,
      network,
      seedFingerprint,
      scriptType,
      backupTested,
      lastBackupTested,
      lastSync,
      importType,
      bdkBlockchain,
      bdkWallet,
      bdkSigningWallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BitcoinWalletImplCopyWith<_$BitcoinWalletImpl> get copyWith =>
      __$$BitcoinWalletImplCopyWithImpl<_$BitcoinWalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BitcoinWalletImplToJson(
      this,
    );
  }
}

abstract class _BitcoinWallet extends BitcoinWallet {
  factory _BitcoinWallet(
      {required final String id,
      required final String name,
      required final int balance,
      required final int txCount,
      required final WalletType type,
      required final NetworkType network,
      required final String seedFingerprint,
      final BitcoinScriptType scriptType,
      final bool backupTested,
      final DateTime? lastBackupTested,
      final DateTime? lastSync,
      final ImportTypes importType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bdk.Blockchain? bdkBlockchain,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bdk.Wallet? bdkWallet,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bdk.Wallet? bdkSigningWallet}) = _$BitcoinWalletImpl;
  _BitcoinWallet._() : super._();

  factory _BitcoinWallet.fromJson(Map<String, dynamic> json) =
      _$BitcoinWalletImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get balance;
  @override
  int get txCount;
  @override
  WalletType get type;
  @override
  NetworkType get network;
  @override
  String get seedFingerprint;
  @override // required bool breaker,
  BitcoinScriptType get scriptType;
  @override
  bool get backupTested;
  @override
  DateTime? get lastBackupTested;
  @override
  DateTime? get lastSync;
  @override
  ImportTypes get importType;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bdk.Blockchain? get bdkBlockchain;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bdk.Wallet? get bdkWallet;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bdk.Wallet? get bdkSigningWallet;
  @override
  @JsonKey(ignore: true)
  _$$BitcoinWalletImplCopyWith<_$BitcoinWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
