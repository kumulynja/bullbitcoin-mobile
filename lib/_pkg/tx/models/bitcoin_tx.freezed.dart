// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bitcoin_tx.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BitcoinTx _$BitcoinTxFromJson(Map<String, dynamic> json) {
  return _BitcoinTx.fromJson(json);
}

/// @nodoc
mixin _$BitcoinTx {
  String get id => throw _privateConstructorUsedError;
  TxType get type => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  int get sent => throw _privateConstructorUsedError;
  int get received => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get fee => throw _privateConstructorUsedError;
  double get feeRate => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  String? get psbt => throw _privateConstructorUsedError;
  int? get broadcastTime => throw _privateConstructorUsedError;
  bool get rbfEnabled => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  int get vsize => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get locktime => throw _privateConstructorUsedError;
  List<BitcoinTxIn> get inputs => throw _privateConstructorUsedError;
  List<BitcoinTxOut> get outputs => throw _privateConstructorUsedError;
  String get toAddress => throw _privateConstructorUsedError;
  List<String> get labels => throw _privateConstructorUsedError;
  String? get walletId => throw _privateConstructorUsedError;
  List<LiquidTxIn> get linputs => throw _privateConstructorUsedError;
  List<LiquidTxOut> get loutputs => throw _privateConstructorUsedError;
  List<String> get rbfChain => throw _privateConstructorUsedError;
  int get rbfIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BitcoinTxCopyWith<BitcoinTx> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BitcoinTxCopyWith<$Res> {
  factory $BitcoinTxCopyWith(BitcoinTx value, $Res Function(BitcoinTx) then) =
      _$BitcoinTxCopyWithImpl<$Res, BitcoinTx>;
  @useResult
  $Res call(
      {String id,
      TxType type,
      int timestamp,
      int sent,
      int received,
      int amount,
      int fee,
      double feeRate,
      int height,
      String? psbt,
      int? broadcastTime,
      bool rbfEnabled,
      int version,
      int vsize,
      int weight,
      int locktime,
      List<BitcoinTxIn> inputs,
      List<BitcoinTxOut> outputs,
      String toAddress,
      List<String> labels,
      String? walletId,
      List<LiquidTxIn> linputs,
      List<LiquidTxOut> loutputs,
      List<String> rbfChain,
      int rbfIndex});
}

/// @nodoc
class _$BitcoinTxCopyWithImpl<$Res, $Val extends BitcoinTx>
    implements $BitcoinTxCopyWith<$Res> {
  _$BitcoinTxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? sent = null,
    Object? received = null,
    Object? amount = null,
    Object? fee = null,
    Object? feeRate = null,
    Object? height = null,
    Object? psbt = freezed,
    Object? broadcastTime = freezed,
    Object? rbfEnabled = null,
    Object? version = null,
    Object? vsize = null,
    Object? weight = null,
    Object? locktime = null,
    Object? inputs = null,
    Object? outputs = null,
    Object? toAddress = null,
    Object? labels = null,
    Object? walletId = freezed,
    Object? linputs = null,
    Object? loutputs = null,
    Object? rbfChain = null,
    Object? rbfIndex = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TxType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      received: null == received
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      feeRate: null == feeRate
          ? _value.feeRate
          : feeRate // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      psbt: freezed == psbt
          ? _value.psbt
          : psbt // ignore: cast_nullable_to_non_nullable
              as String?,
      broadcastTime: freezed == broadcastTime
          ? _value.broadcastTime
          : broadcastTime // ignore: cast_nullable_to_non_nullable
              as int?,
      rbfEnabled: null == rbfEnabled
          ? _value.rbfEnabled
          : rbfEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      vsize: null == vsize
          ? _value.vsize
          : vsize // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      locktime: null == locktime
          ? _value.locktime
          : locktime // ignore: cast_nullable_to_non_nullable
              as int,
      inputs: null == inputs
          ? _value.inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxIn>,
      outputs: null == outputs
          ? _value.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxOut>,
      toAddress: null == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String,
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      walletId: freezed == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as String?,
      linputs: null == linputs
          ? _value.linputs
          : linputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxIn>,
      loutputs: null == loutputs
          ? _value.loutputs
          : loutputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxOut>,
      rbfChain: null == rbfChain
          ? _value.rbfChain
          : rbfChain // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rbfIndex: null == rbfIndex
          ? _value.rbfIndex
          : rbfIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BitcoinTxImplCopyWith<$Res>
    implements $BitcoinTxCopyWith<$Res> {
  factory _$$BitcoinTxImplCopyWith(
          _$BitcoinTxImpl value, $Res Function(_$BitcoinTxImpl) then) =
      __$$BitcoinTxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      TxType type,
      int timestamp,
      int sent,
      int received,
      int amount,
      int fee,
      double feeRate,
      int height,
      String? psbt,
      int? broadcastTime,
      bool rbfEnabled,
      int version,
      int vsize,
      int weight,
      int locktime,
      List<BitcoinTxIn> inputs,
      List<BitcoinTxOut> outputs,
      String toAddress,
      List<String> labels,
      String? walletId,
      List<LiquidTxIn> linputs,
      List<LiquidTxOut> loutputs,
      List<String> rbfChain,
      int rbfIndex});
}

/// @nodoc
class __$$BitcoinTxImplCopyWithImpl<$Res>
    extends _$BitcoinTxCopyWithImpl<$Res, _$BitcoinTxImpl>
    implements _$$BitcoinTxImplCopyWith<$Res> {
  __$$BitcoinTxImplCopyWithImpl(
      _$BitcoinTxImpl _value, $Res Function(_$BitcoinTxImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? sent = null,
    Object? received = null,
    Object? amount = null,
    Object? fee = null,
    Object? feeRate = null,
    Object? height = null,
    Object? psbt = freezed,
    Object? broadcastTime = freezed,
    Object? rbfEnabled = null,
    Object? version = null,
    Object? vsize = null,
    Object? weight = null,
    Object? locktime = null,
    Object? inputs = null,
    Object? outputs = null,
    Object? toAddress = null,
    Object? labels = null,
    Object? walletId = freezed,
    Object? linputs = null,
    Object? loutputs = null,
    Object? rbfChain = null,
    Object? rbfIndex = null,
  }) {
    return _then(_$BitcoinTxImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TxType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      received: null == received
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      feeRate: null == feeRate
          ? _value.feeRate
          : feeRate // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      psbt: freezed == psbt
          ? _value.psbt
          : psbt // ignore: cast_nullable_to_non_nullable
              as String?,
      broadcastTime: freezed == broadcastTime
          ? _value.broadcastTime
          : broadcastTime // ignore: cast_nullable_to_non_nullable
              as int?,
      rbfEnabled: null == rbfEnabled
          ? _value.rbfEnabled
          : rbfEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      vsize: null == vsize
          ? _value.vsize
          : vsize // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      locktime: null == locktime
          ? _value.locktime
          : locktime // ignore: cast_nullable_to_non_nullable
              as int,
      inputs: null == inputs
          ? _value._inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxIn>,
      outputs: null == outputs
          ? _value._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxOut>,
      toAddress: null == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String,
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      walletId: freezed == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as String?,
      linputs: null == linputs
          ? _value._linputs
          : linputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxIn>,
      loutputs: null == loutputs
          ? _value._loutputs
          : loutputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxOut>,
      rbfChain: null == rbfChain
          ? _value._rbfChain
          : rbfChain // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rbfIndex: null == rbfIndex
          ? _value.rbfIndex
          : rbfIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BitcoinTxImpl extends _BitcoinTx {
  _$BitcoinTxImpl(
      {required this.id,
      required this.type,
      required this.timestamp,
      this.sent = 0,
      this.received = 0,
      required this.amount,
      required this.fee,
      required this.feeRate,
      required this.height,
      this.psbt,
      this.broadcastTime,
      required this.rbfEnabled,
      required this.version,
      required this.vsize,
      required this.weight,
      required this.locktime,
      required final List<BitcoinTxIn> inputs,
      required final List<BitcoinTxOut> outputs,
      required this.toAddress,
      final List<String> labels = const [],
      required this.walletId,
      final List<LiquidTxIn> linputs = const [],
      final List<LiquidTxOut> loutputs = const [],
      final List<String> rbfChain = const [],
      this.rbfIndex = -1})
      : _inputs = inputs,
        _outputs = outputs,
        _labels = labels,
        _linputs = linputs,
        _loutputs = loutputs,
        _rbfChain = rbfChain,
        super._();

  factory _$BitcoinTxImpl.fromJson(Map<String, dynamic> json) =>
      _$$BitcoinTxImplFromJson(json);

  @override
  final String id;
  @override
  final TxType type;
  @override
  final int timestamp;
  @override
  @JsonKey()
  final int sent;
  @override
  @JsonKey()
  final int received;
  @override
  final int amount;
  @override
  final int fee;
  @override
  final double feeRate;
  @override
  final int height;
  @override
  final String? psbt;
  @override
  final int? broadcastTime;
  @override
  final bool rbfEnabled;
  @override
  final int version;
  @override
  final int vsize;
  @override
  final int weight;
  @override
  final int locktime;
  final List<BitcoinTxIn> _inputs;
  @override
  List<BitcoinTxIn> get inputs {
    if (_inputs is EqualUnmodifiableListView) return _inputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputs);
  }

  final List<BitcoinTxOut> _outputs;
  @override
  List<BitcoinTxOut> get outputs {
    if (_outputs is EqualUnmodifiableListView) return _outputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputs);
  }

  @override
  final String toAddress;
  final List<String> _labels;
  @override
  @JsonKey()
  List<String> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  @override
  final String? walletId;
  final List<LiquidTxIn> _linputs;
  @override
  @JsonKey()
  List<LiquidTxIn> get linputs {
    if (_linputs is EqualUnmodifiableListView) return _linputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linputs);
  }

  final List<LiquidTxOut> _loutputs;
  @override
  @JsonKey()
  List<LiquidTxOut> get loutputs {
    if (_loutputs is EqualUnmodifiableListView) return _loutputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loutputs);
  }

  final List<String> _rbfChain;
  @override
  @JsonKey()
  List<String> get rbfChain {
    if (_rbfChain is EqualUnmodifiableListView) return _rbfChain;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rbfChain);
  }

  @override
  @JsonKey()
  final int rbfIndex;

  @override
  String toString() {
    return 'BitcoinTx(id: $id, type: $type, timestamp: $timestamp, sent: $sent, received: $received, amount: $amount, fee: $fee, feeRate: $feeRate, height: $height, psbt: $psbt, broadcastTime: $broadcastTime, rbfEnabled: $rbfEnabled, version: $version, vsize: $vsize, weight: $weight, locktime: $locktime, inputs: $inputs, outputs: $outputs, toAddress: $toAddress, labels: $labels, walletId: $walletId, linputs: $linputs, loutputs: $loutputs, rbfChain: $rbfChain, rbfIndex: $rbfIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BitcoinTxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.received, received) ||
                other.received == received) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.feeRate, feeRate) || other.feeRate == feeRate) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.psbt, psbt) || other.psbt == psbt) &&
            (identical(other.broadcastTime, broadcastTime) ||
                other.broadcastTime == broadcastTime) &&
            (identical(other.rbfEnabled, rbfEnabled) ||
                other.rbfEnabled == rbfEnabled) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.vsize, vsize) || other.vsize == vsize) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.locktime, locktime) ||
                other.locktime == locktime) &&
            const DeepCollectionEquality().equals(other._inputs, _inputs) &&
            const DeepCollectionEquality().equals(other._outputs, _outputs) &&
            (identical(other.toAddress, toAddress) ||
                other.toAddress == toAddress) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            const DeepCollectionEquality().equals(other._linputs, _linputs) &&
            const DeepCollectionEquality().equals(other._loutputs, _loutputs) &&
            const DeepCollectionEquality().equals(other._rbfChain, _rbfChain) &&
            (identical(other.rbfIndex, rbfIndex) ||
                other.rbfIndex == rbfIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        type,
        timestamp,
        sent,
        received,
        amount,
        fee,
        feeRate,
        height,
        psbt,
        broadcastTime,
        rbfEnabled,
        version,
        vsize,
        weight,
        locktime,
        const DeepCollectionEquality().hash(_inputs),
        const DeepCollectionEquality().hash(_outputs),
        toAddress,
        const DeepCollectionEquality().hash(_labels),
        walletId,
        const DeepCollectionEquality().hash(_linputs),
        const DeepCollectionEquality().hash(_loutputs),
        const DeepCollectionEquality().hash(_rbfChain),
        rbfIndex
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BitcoinTxImplCopyWith<_$BitcoinTxImpl> get copyWith =>
      __$$BitcoinTxImplCopyWithImpl<_$BitcoinTxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BitcoinTxImplToJson(
      this,
    );
  }
}

abstract class _BitcoinTx extends BitcoinTx {
  factory _BitcoinTx(
      {required final String id,
      required final TxType type,
      required final int timestamp,
      final int sent,
      final int received,
      required final int amount,
      required final int fee,
      required final double feeRate,
      required final int height,
      final String? psbt,
      final int? broadcastTime,
      required final bool rbfEnabled,
      required final int version,
      required final int vsize,
      required final int weight,
      required final int locktime,
      required final List<BitcoinTxIn> inputs,
      required final List<BitcoinTxOut> outputs,
      required final String toAddress,
      final List<String> labels,
      required final String? walletId,
      final List<LiquidTxIn> linputs,
      final List<LiquidTxOut> loutputs,
      final List<String> rbfChain,
      final int rbfIndex}) = _$BitcoinTxImpl;
  _BitcoinTx._() : super._();

  factory _BitcoinTx.fromJson(Map<String, dynamic> json) =
      _$BitcoinTxImpl.fromJson;

  @override
  String get id;
  @override
  TxType get type;
  @override
  int get timestamp;
  @override
  int get sent;
  @override
  int get received;
  @override
  int get amount;
  @override
  int get fee;
  @override
  double get feeRate;
  @override
  int get height;
  @override
  String? get psbt;
  @override
  int? get broadcastTime;
  @override
  bool get rbfEnabled;
  @override
  int get version;
  @override
  int get vsize;
  @override
  int get weight;
  @override
  int get locktime;
  @override
  List<BitcoinTxIn> get inputs;
  @override
  List<BitcoinTxOut> get outputs;
  @override
  String get toAddress;
  @override
  List<String> get labels;
  @override
  String? get walletId;
  @override
  List<LiquidTxIn> get linputs;
  @override
  List<LiquidTxOut> get loutputs;
  @override
  List<String> get rbfChain;
  @override
  int get rbfIndex;
  @override
  @JsonKey(ignore: true)
  _$$BitcoinTxImplCopyWith<_$BitcoinTxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BitcoinOutPoint _$BitcoinOutPointFromJson(Map<String, dynamic> json) {
  return _BitcoinOutPoint.fromJson(json);
}

/// @nodoc
mixin _$BitcoinOutPoint {
  String get txid => throw _privateConstructorUsedError;
  int get vout => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BitcoinOutPointCopyWith<BitcoinOutPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BitcoinOutPointCopyWith<$Res> {
  factory $BitcoinOutPointCopyWith(
          BitcoinOutPoint value, $Res Function(BitcoinOutPoint) then) =
      _$BitcoinOutPointCopyWithImpl<$Res, BitcoinOutPoint>;
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class _$BitcoinOutPointCopyWithImpl<$Res, $Val extends BitcoinOutPoint>
    implements $BitcoinOutPointCopyWith<$Res> {
  _$BitcoinOutPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_value.copyWith(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      vout: null == vout
          ? _value.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BitcoinOutPointImplCopyWith<$Res>
    implements $BitcoinOutPointCopyWith<$Res> {
  factory _$$BitcoinOutPointImplCopyWith(_$BitcoinOutPointImpl value,
          $Res Function(_$BitcoinOutPointImpl) then) =
      __$$BitcoinOutPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class __$$BitcoinOutPointImplCopyWithImpl<$Res>
    extends _$BitcoinOutPointCopyWithImpl<$Res, _$BitcoinOutPointImpl>
    implements _$$BitcoinOutPointImplCopyWith<$Res> {
  __$$BitcoinOutPointImplCopyWithImpl(
      _$BitcoinOutPointImpl _value, $Res Function(_$BitcoinOutPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_$BitcoinOutPointImpl(
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
      vout: null == vout
          ? _value.vout
          : vout // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BitcoinOutPointImpl implements _BitcoinOutPoint {
  const _$BitcoinOutPointImpl({this.txid = '', this.vout = 0});

  factory _$BitcoinOutPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$BitcoinOutPointImplFromJson(json);

  @override
  @JsonKey()
  final String txid;
  @override
  @JsonKey()
  final int vout;

  @override
  String toString() {
    return 'BitcoinOutPoint(txid: $txid, vout: $vout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BitcoinOutPointImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.vout, vout) || other.vout == vout));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, txid, vout);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BitcoinOutPointImplCopyWith<_$BitcoinOutPointImpl> get copyWith =>
      __$$BitcoinOutPointImplCopyWithImpl<_$BitcoinOutPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BitcoinOutPointImplToJson(
      this,
    );
  }
}

abstract class _BitcoinOutPoint implements BitcoinOutPoint {
  const factory _BitcoinOutPoint({final String txid, final int vout}) =
      _$BitcoinOutPointImpl;

  factory _BitcoinOutPoint.fromJson(Map<String, dynamic> json) =
      _$BitcoinOutPointImpl.fromJson;

  @override
  String get txid;
  @override
  int get vout;
  @override
  @JsonKey(ignore: true)
  _$$BitcoinOutPointImplCopyWith<_$BitcoinOutPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BitcoinTxIn _$BitcoinTxInFromJson(Map<String, dynamic> json) {
  return _BitcoinTxIn.fromJson(json);
}

/// @nodoc
mixin _$BitcoinTxIn {
  BitcoinOutPoint get previousOutput => throw _privateConstructorUsedError;
  List<int> get scriptSig => throw _privateConstructorUsedError;
  int get sequence => throw _privateConstructorUsedError;
  List<String> get witness => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BitcoinTxInCopyWith<BitcoinTxIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BitcoinTxInCopyWith<$Res> {
  factory $BitcoinTxInCopyWith(
          BitcoinTxIn value, $Res Function(BitcoinTxIn) then) =
      _$BitcoinTxInCopyWithImpl<$Res, BitcoinTxIn>;
  @useResult
  $Res call(
      {BitcoinOutPoint previousOutput,
      List<int> scriptSig,
      int sequence,
      List<String> witness});

  $BitcoinOutPointCopyWith<$Res> get previousOutput;
}

/// @nodoc
class _$BitcoinTxInCopyWithImpl<$Res, $Val extends BitcoinTxIn>
    implements $BitcoinTxInCopyWith<$Res> {
  _$BitcoinTxInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousOutput = null,
    Object? scriptSig = null,
    Object? sequence = null,
    Object? witness = null,
  }) {
    return _then(_value.copyWith(
      previousOutput: null == previousOutput
          ? _value.previousOutput
          : previousOutput // ignore: cast_nullable_to_non_nullable
              as BitcoinOutPoint,
      scriptSig: null == scriptSig
          ? _value.scriptSig
          : scriptSig // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sequence: null == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      witness: null == witness
          ? _value.witness
          : witness // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BitcoinOutPointCopyWith<$Res> get previousOutput {
    return $BitcoinOutPointCopyWith<$Res>(_value.previousOutput, (value) {
      return _then(_value.copyWith(previousOutput: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BitcoinTxInImplCopyWith<$Res>
    implements $BitcoinTxInCopyWith<$Res> {
  factory _$$BitcoinTxInImplCopyWith(
          _$BitcoinTxInImpl value, $Res Function(_$BitcoinTxInImpl) then) =
      __$$BitcoinTxInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BitcoinOutPoint previousOutput,
      List<int> scriptSig,
      int sequence,
      List<String> witness});

  @override
  $BitcoinOutPointCopyWith<$Res> get previousOutput;
}

/// @nodoc
class __$$BitcoinTxInImplCopyWithImpl<$Res>
    extends _$BitcoinTxInCopyWithImpl<$Res, _$BitcoinTxInImpl>
    implements _$$BitcoinTxInImplCopyWith<$Res> {
  __$$BitcoinTxInImplCopyWithImpl(
      _$BitcoinTxInImpl _value, $Res Function(_$BitcoinTxInImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousOutput = null,
    Object? scriptSig = null,
    Object? sequence = null,
    Object? witness = null,
  }) {
    return _then(_$BitcoinTxInImpl(
      previousOutput: null == previousOutput
          ? _value.previousOutput
          : previousOutput // ignore: cast_nullable_to_non_nullable
              as BitcoinOutPoint,
      scriptSig: null == scriptSig
          ? _value._scriptSig
          : scriptSig // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sequence: null == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      witness: null == witness
          ? _value._witness
          : witness // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BitcoinTxInImpl extends _BitcoinTxIn {
  _$BitcoinTxInImpl(
      {this.previousOutput = const BitcoinOutPoint(),
      final List<int> scriptSig = const [],
      this.sequence = 0,
      final List<String> witness = const []})
      : _scriptSig = scriptSig,
        _witness = witness,
        super._();

  factory _$BitcoinTxInImpl.fromJson(Map<String, dynamic> json) =>
      _$$BitcoinTxInImplFromJson(json);

  @override
  @JsonKey()
  final BitcoinOutPoint previousOutput;
  final List<int> _scriptSig;
  @override
  @JsonKey()
  List<int> get scriptSig {
    if (_scriptSig is EqualUnmodifiableListView) return _scriptSig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scriptSig);
  }

  @override
  @JsonKey()
  final int sequence;
  final List<String> _witness;
  @override
  @JsonKey()
  List<String> get witness {
    if (_witness is EqualUnmodifiableListView) return _witness;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_witness);
  }

  @override
  String toString() {
    return 'BitcoinTxIn(previousOutput: $previousOutput, scriptSig: $scriptSig, sequence: $sequence, witness: $witness)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BitcoinTxInImpl &&
            (identical(other.previousOutput, previousOutput) ||
                other.previousOutput == previousOutput) &&
            const DeepCollectionEquality()
                .equals(other._scriptSig, _scriptSig) &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            const DeepCollectionEquality().equals(other._witness, _witness));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      previousOutput,
      const DeepCollectionEquality().hash(_scriptSig),
      sequence,
      const DeepCollectionEquality().hash(_witness));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BitcoinTxInImplCopyWith<_$BitcoinTxInImpl> get copyWith =>
      __$$BitcoinTxInImplCopyWithImpl<_$BitcoinTxInImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BitcoinTxInImplToJson(
      this,
    );
  }
}

abstract class _BitcoinTxIn extends BitcoinTxIn {
  factory _BitcoinTxIn(
      {final BitcoinOutPoint previousOutput,
      final List<int> scriptSig,
      final int sequence,
      final List<String> witness}) = _$BitcoinTxInImpl;
  _BitcoinTxIn._() : super._();

  factory _BitcoinTxIn.fromJson(Map<String, dynamic> json) =
      _$BitcoinTxInImpl.fromJson;

  @override
  BitcoinOutPoint get previousOutput;
  @override
  List<int> get scriptSig;
  @override
  int get sequence;
  @override
  List<String> get witness;
  @override
  @JsonKey(ignore: true)
  _$$BitcoinTxInImplCopyWith<_$BitcoinTxInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BitcoinTxOut _$BitcoinTxOutFromJson(Map<String, dynamic> json) {
  return _BitcoinTxOut.fromJson(json);
}

/// @nodoc
mixin _$BitcoinTxOut {
  int get value => throw _privateConstructorUsedError;
  List<int> get scriptPubKey => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BitcoinTxOutCopyWith<BitcoinTxOut> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BitcoinTxOutCopyWith<$Res> {
  factory $BitcoinTxOutCopyWith(
          BitcoinTxOut value, $Res Function(BitcoinTxOut) then) =
      _$BitcoinTxOutCopyWithImpl<$Res, BitcoinTxOut>;
  @useResult
  $Res call({int value, List<int> scriptPubKey, String address});
}

/// @nodoc
class _$BitcoinTxOutCopyWithImpl<$Res, $Val extends BitcoinTxOut>
    implements $BitcoinTxOutCopyWith<$Res> {
  _$BitcoinTxOutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? scriptPubKey = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      scriptPubKey: null == scriptPubKey
          ? _value.scriptPubKey
          : scriptPubKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BitcoinTxOutImplCopyWith<$Res>
    implements $BitcoinTxOutCopyWith<$Res> {
  factory _$$BitcoinTxOutImplCopyWith(
          _$BitcoinTxOutImpl value, $Res Function(_$BitcoinTxOutImpl) then) =
      __$$BitcoinTxOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, List<int> scriptPubKey, String address});
}

/// @nodoc
class __$$BitcoinTxOutImplCopyWithImpl<$Res>
    extends _$BitcoinTxOutCopyWithImpl<$Res, _$BitcoinTxOutImpl>
    implements _$$BitcoinTxOutImplCopyWith<$Res> {
  __$$BitcoinTxOutImplCopyWithImpl(
      _$BitcoinTxOutImpl _value, $Res Function(_$BitcoinTxOutImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? scriptPubKey = null,
    Object? address = null,
  }) {
    return _then(_$BitcoinTxOutImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      scriptPubKey: null == scriptPubKey
          ? _value._scriptPubKey
          : scriptPubKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BitcoinTxOutImpl extends _BitcoinTxOut {
  _$BitcoinTxOutImpl(
      {this.value = 0,
      final List<int> scriptPubKey = const [],
      this.address = ''})
      : _scriptPubKey = scriptPubKey,
        super._();

  factory _$BitcoinTxOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$BitcoinTxOutImplFromJson(json);

  @override
  @JsonKey()
  final int value;
  final List<int> _scriptPubKey;
  @override
  @JsonKey()
  List<int> get scriptPubKey {
    if (_scriptPubKey is EqualUnmodifiableListView) return _scriptPubKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scriptPubKey);
  }

  @override
  @JsonKey()
  final String address;

  @override
  String toString() {
    return 'BitcoinTxOut(value: $value, scriptPubKey: $scriptPubKey, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BitcoinTxOutImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other._scriptPubKey, _scriptPubKey) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value,
      const DeepCollectionEquality().hash(_scriptPubKey), address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BitcoinTxOutImplCopyWith<_$BitcoinTxOutImpl> get copyWith =>
      __$$BitcoinTxOutImplCopyWithImpl<_$BitcoinTxOutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BitcoinTxOutImplToJson(
      this,
    );
  }
}

abstract class _BitcoinTxOut extends BitcoinTxOut {
  factory _BitcoinTxOut(
      {final int value,
      final List<int> scriptPubKey,
      final String address}) = _$BitcoinTxOutImpl;
  _BitcoinTxOut._() : super._();

  factory _BitcoinTxOut.fromJson(Map<String, dynamic> json) =
      _$BitcoinTxOutImpl.fromJson;

  @override
  int get value;
  @override
  List<int> get scriptPubKey;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$BitcoinTxOutImplCopyWith<_$BitcoinTxOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
