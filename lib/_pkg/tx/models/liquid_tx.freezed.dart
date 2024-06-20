// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'liquid_tx.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LiquidTx _$LiquidTxFromJson(Map<String, dynamic> json) {
  return _LiquidTx.fromJson(json);
}

/// @nodoc
mixin _$LiquidTx {
  String get id => throw _privateConstructorUsedError;
  TxType get type => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  int get sent => throw _privateConstructorUsedError;
  int get received => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get fee => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  int get vsize => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get locktime => throw _privateConstructorUsedError;
  List<LiquidTxIn> get linputs => throw _privateConstructorUsedError;
  List<LiquidTxOut> get loutputs => throw _privateConstructorUsedError;
  String get toAddress => throw _privateConstructorUsedError;
  List<String> get labels => throw _privateConstructorUsedError;
  String? get walletId => throw _privateConstructorUsedError;
  List<BitcoinTxIn> get inputs => throw _privateConstructorUsedError;
  List<BitcoinTxOut> get outputs => throw _privateConstructorUsedError;
  List<String> get rbfChain => throw _privateConstructorUsedError;
  int get rbfIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiquidTxCopyWith<LiquidTx> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidTxCopyWith<$Res> {
  factory $LiquidTxCopyWith(LiquidTx value, $Res Function(LiquidTx) then) =
      _$LiquidTxCopyWithImpl<$Res, LiquidTx>;
  @useResult
  $Res call(
      {String id,
      TxType type,
      int timestamp,
      int sent,
      int received,
      int amount,
      int fee,
      int height,
      int version,
      int vsize,
      int weight,
      int locktime,
      List<LiquidTxIn> linputs,
      List<LiquidTxOut> loutputs,
      String toAddress,
      List<String> labels,
      String? walletId,
      List<BitcoinTxIn> inputs,
      List<BitcoinTxOut> outputs,
      List<String> rbfChain,
      int rbfIndex});
}

/// @nodoc
class _$LiquidTxCopyWithImpl<$Res, $Val extends LiquidTx>
    implements $LiquidTxCopyWith<$Res> {
  _$LiquidTxCopyWithImpl(this._value, this._then);

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
    Object? height = null,
    Object? version = null,
    Object? vsize = null,
    Object? weight = null,
    Object? locktime = null,
    Object? linputs = null,
    Object? loutputs = null,
    Object? toAddress = null,
    Object? labels = null,
    Object? walletId = freezed,
    Object? inputs = null,
    Object? outputs = null,
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
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
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
      linputs: null == linputs
          ? _value.linputs
          : linputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxIn>,
      loutputs: null == loutputs
          ? _value.loutputs
          : loutputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxOut>,
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
      inputs: null == inputs
          ? _value.inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxIn>,
      outputs: null == outputs
          ? _value.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxOut>,
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
abstract class _$$LiquidTxImplCopyWith<$Res>
    implements $LiquidTxCopyWith<$Res> {
  factory _$$LiquidTxImplCopyWith(
          _$LiquidTxImpl value, $Res Function(_$LiquidTxImpl) then) =
      __$$LiquidTxImplCopyWithImpl<$Res>;
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
      int height,
      int version,
      int vsize,
      int weight,
      int locktime,
      List<LiquidTxIn> linputs,
      List<LiquidTxOut> loutputs,
      String toAddress,
      List<String> labels,
      String? walletId,
      List<BitcoinTxIn> inputs,
      List<BitcoinTxOut> outputs,
      List<String> rbfChain,
      int rbfIndex});
}

/// @nodoc
class __$$LiquidTxImplCopyWithImpl<$Res>
    extends _$LiquidTxCopyWithImpl<$Res, _$LiquidTxImpl>
    implements _$$LiquidTxImplCopyWith<$Res> {
  __$$LiquidTxImplCopyWithImpl(
      _$LiquidTxImpl _value, $Res Function(_$LiquidTxImpl) _then)
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
    Object? height = null,
    Object? version = null,
    Object? vsize = null,
    Object? weight = null,
    Object? locktime = null,
    Object? linputs = null,
    Object? loutputs = null,
    Object? toAddress = null,
    Object? labels = null,
    Object? walletId = freezed,
    Object? inputs = null,
    Object? outputs = null,
    Object? rbfChain = null,
    Object? rbfIndex = null,
  }) {
    return _then(_$LiquidTxImpl(
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
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
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
      linputs: null == linputs
          ? _value._linputs
          : linputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxIn>,
      loutputs: null == loutputs
          ? _value._loutputs
          : loutputs // ignore: cast_nullable_to_non_nullable
              as List<LiquidTxOut>,
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
      inputs: null == inputs
          ? _value._inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxIn>,
      outputs: null == outputs
          ? _value._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as List<BitcoinTxOut>,
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
class _$LiquidTxImpl extends _LiquidTx {
  _$LiquidTxImpl(
      {required this.id,
      required this.type,
      required this.timestamp,
      this.sent = 0,
      this.received = 0,
      required this.amount,
      required this.fee,
      required this.height,
      required this.version,
      required this.vsize,
      required this.weight,
      required this.locktime,
      required final List<LiquidTxIn> linputs,
      required final List<LiquidTxOut> loutputs,
      required this.toAddress,
      final List<String> labels = const [],
      required this.walletId,
      final List<BitcoinTxIn> inputs = const [],
      final List<BitcoinTxOut> outputs = const [],
      final List<String> rbfChain = const [],
      this.rbfIndex = 0})
      : _linputs = linputs,
        _loutputs = loutputs,
        _labels = labels,
        _inputs = inputs,
        _outputs = outputs,
        _rbfChain = rbfChain,
        super._();

  factory _$LiquidTxImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiquidTxImplFromJson(json);

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
  final int height;
  @override
  final int version;
  @override
  final int vsize;
  @override
  final int weight;
  @override
  final int locktime;
  final List<LiquidTxIn> _linputs;
  @override
  List<LiquidTxIn> get linputs {
    if (_linputs is EqualUnmodifiableListView) return _linputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linputs);
  }

  final List<LiquidTxOut> _loutputs;
  @override
  List<LiquidTxOut> get loutputs {
    if (_loutputs is EqualUnmodifiableListView) return _loutputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loutputs);
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
  final List<BitcoinTxIn> _inputs;
  @override
  @JsonKey()
  List<BitcoinTxIn> get inputs {
    if (_inputs is EqualUnmodifiableListView) return _inputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputs);
  }

  final List<BitcoinTxOut> _outputs;
  @override
  @JsonKey()
  List<BitcoinTxOut> get outputs {
    if (_outputs is EqualUnmodifiableListView) return _outputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputs);
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
    return 'LiquidTx(id: $id, type: $type, timestamp: $timestamp, sent: $sent, received: $received, amount: $amount, fee: $fee, height: $height, version: $version, vsize: $vsize, weight: $weight, locktime: $locktime, linputs: $linputs, loutputs: $loutputs, toAddress: $toAddress, labels: $labels, walletId: $walletId, inputs: $inputs, outputs: $outputs, rbfChain: $rbfChain, rbfIndex: $rbfIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidTxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.received, received) ||
                other.received == received) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.vsize, vsize) || other.vsize == vsize) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.locktime, locktime) ||
                other.locktime == locktime) &&
            const DeepCollectionEquality().equals(other._linputs, _linputs) &&
            const DeepCollectionEquality().equals(other._loutputs, _loutputs) &&
            (identical(other.toAddress, toAddress) ||
                other.toAddress == toAddress) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            const DeepCollectionEquality().equals(other._inputs, _inputs) &&
            const DeepCollectionEquality().equals(other._outputs, _outputs) &&
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
        height,
        version,
        vsize,
        weight,
        locktime,
        const DeepCollectionEquality().hash(_linputs),
        const DeepCollectionEquality().hash(_loutputs),
        toAddress,
        const DeepCollectionEquality().hash(_labels),
        walletId,
        const DeepCollectionEquality().hash(_inputs),
        const DeepCollectionEquality().hash(_outputs),
        const DeepCollectionEquality().hash(_rbfChain),
        rbfIndex
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidTxImplCopyWith<_$LiquidTxImpl> get copyWith =>
      __$$LiquidTxImplCopyWithImpl<_$LiquidTxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiquidTxImplToJson(
      this,
    );
  }
}

abstract class _LiquidTx extends LiquidTx {
  factory _LiquidTx(
      {required final String id,
      required final TxType type,
      required final int timestamp,
      final int sent,
      final int received,
      required final int amount,
      required final int fee,
      required final int height,
      required final int version,
      required final int vsize,
      required final int weight,
      required final int locktime,
      required final List<LiquidTxIn> linputs,
      required final List<LiquidTxOut> loutputs,
      required final String toAddress,
      final List<String> labels,
      required final String? walletId,
      final List<BitcoinTxIn> inputs,
      final List<BitcoinTxOut> outputs,
      final List<String> rbfChain,
      final int rbfIndex}) = _$LiquidTxImpl;
  _LiquidTx._() : super._();

  factory _LiquidTx.fromJson(Map<String, dynamic> json) =
      _$LiquidTxImpl.fromJson;

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
  int get height;
  @override
  int get version;
  @override
  int get vsize;
  @override
  int get weight;
  @override
  int get locktime;
  @override
  List<LiquidTxIn> get linputs;
  @override
  List<LiquidTxOut> get loutputs;
  @override
  String get toAddress;
  @override
  List<String> get labels;
  @override
  String? get walletId;
  @override
  List<BitcoinTxIn> get inputs;
  @override
  List<BitcoinTxOut> get outputs;
  @override
  List<String> get rbfChain;
  @override
  int get rbfIndex;
  @override
  @JsonKey(ignore: true)
  _$$LiquidTxImplCopyWith<_$LiquidTxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiquidOutPoint _$LiquidOutPointFromJson(Map<String, dynamic> json) {
  return _LiquidOutPoint.fromJson(json);
}

/// @nodoc
mixin _$LiquidOutPoint {
  String get txid => throw _privateConstructorUsedError;
  int get vout => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiquidOutPointCopyWith<LiquidOutPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidOutPointCopyWith<$Res> {
  factory $LiquidOutPointCopyWith(
          LiquidOutPoint value, $Res Function(LiquidOutPoint) then) =
      _$LiquidOutPointCopyWithImpl<$Res, LiquidOutPoint>;
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class _$LiquidOutPointCopyWithImpl<$Res, $Val extends LiquidOutPoint>
    implements $LiquidOutPointCopyWith<$Res> {
  _$LiquidOutPointCopyWithImpl(this._value, this._then);

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
abstract class _$$LiquidOutPointImplCopyWith<$Res>
    implements $LiquidOutPointCopyWith<$Res> {
  factory _$$LiquidOutPointImplCopyWith(_$LiquidOutPointImpl value,
          $Res Function(_$LiquidOutPointImpl) then) =
      __$$LiquidOutPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txid, int vout});
}

/// @nodoc
class __$$LiquidOutPointImplCopyWithImpl<$Res>
    extends _$LiquidOutPointCopyWithImpl<$Res, _$LiquidOutPointImpl>
    implements _$$LiquidOutPointImplCopyWith<$Res> {
  __$$LiquidOutPointImplCopyWithImpl(
      _$LiquidOutPointImpl _value, $Res Function(_$LiquidOutPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txid = null,
    Object? vout = null,
  }) {
    return _then(_$LiquidOutPointImpl(
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
class _$LiquidOutPointImpl implements _LiquidOutPoint {
  const _$LiquidOutPointImpl({this.txid = '', this.vout = 0});

  factory _$LiquidOutPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiquidOutPointImplFromJson(json);

  @override
  @JsonKey()
  final String txid;
  @override
  @JsonKey()
  final int vout;

  @override
  String toString() {
    return 'LiquidOutPoint(txid: $txid, vout: $vout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidOutPointImpl &&
            (identical(other.txid, txid) || other.txid == txid) &&
            (identical(other.vout, vout) || other.vout == vout));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, txid, vout);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidOutPointImplCopyWith<_$LiquidOutPointImpl> get copyWith =>
      __$$LiquidOutPointImplCopyWithImpl<_$LiquidOutPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiquidOutPointImplToJson(
      this,
    );
  }
}

abstract class _LiquidOutPoint implements LiquidOutPoint {
  const factory _LiquidOutPoint({final String txid, final int vout}) =
      _$LiquidOutPointImpl;

  factory _LiquidOutPoint.fromJson(Map<String, dynamic> json) =
      _$LiquidOutPointImpl.fromJson;

  @override
  String get txid;
  @override
  int get vout;
  @override
  @JsonKey(ignore: true)
  _$$LiquidOutPointImplCopyWith<_$LiquidOutPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiquidTxIn _$LiquidTxInFromJson(Map<String, dynamic> json) {
  return _LiquidTxIn.fromJson(json);
}

/// @nodoc
mixin _$LiquidTxIn {
  LiquidOutPoint get previousOutput => throw _privateConstructorUsedError;
  String get scriptSig => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiquidTxInCopyWith<LiquidTxIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidTxInCopyWith<$Res> {
  factory $LiquidTxInCopyWith(
          LiquidTxIn value, $Res Function(LiquidTxIn) then) =
      _$LiquidTxInCopyWithImpl<$Res, LiquidTxIn>;
  @useResult
  $Res call({LiquidOutPoint previousOutput, String scriptSig});

  $LiquidOutPointCopyWith<$Res> get previousOutput;
}

/// @nodoc
class _$LiquidTxInCopyWithImpl<$Res, $Val extends LiquidTxIn>
    implements $LiquidTxInCopyWith<$Res> {
  _$LiquidTxInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousOutput = null,
    Object? scriptSig = null,
  }) {
    return _then(_value.copyWith(
      previousOutput: null == previousOutput
          ? _value.previousOutput
          : previousOutput // ignore: cast_nullable_to_non_nullable
              as LiquidOutPoint,
      scriptSig: null == scriptSig
          ? _value.scriptSig
          : scriptSig // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LiquidOutPointCopyWith<$Res> get previousOutput {
    return $LiquidOutPointCopyWith<$Res>(_value.previousOutput, (value) {
      return _then(_value.copyWith(previousOutput: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LiquidTxInImplCopyWith<$Res>
    implements $LiquidTxInCopyWith<$Res> {
  factory _$$LiquidTxInImplCopyWith(
          _$LiquidTxInImpl value, $Res Function(_$LiquidTxInImpl) then) =
      __$$LiquidTxInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LiquidOutPoint previousOutput, String scriptSig});

  @override
  $LiquidOutPointCopyWith<$Res> get previousOutput;
}

/// @nodoc
class __$$LiquidTxInImplCopyWithImpl<$Res>
    extends _$LiquidTxInCopyWithImpl<$Res, _$LiquidTxInImpl>
    implements _$$LiquidTxInImplCopyWith<$Res> {
  __$$LiquidTxInImplCopyWithImpl(
      _$LiquidTxInImpl _value, $Res Function(_$LiquidTxInImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousOutput = null,
    Object? scriptSig = null,
  }) {
    return _then(_$LiquidTxInImpl(
      previousOutput: null == previousOutput
          ? _value.previousOutput
          : previousOutput // ignore: cast_nullable_to_non_nullable
              as LiquidOutPoint,
      scriptSig: null == scriptSig
          ? _value.scriptSig
          : scriptSig // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiquidTxInImpl extends _LiquidTxIn {
  _$LiquidTxInImpl(
      {this.previousOutput = const LiquidOutPoint(), this.scriptSig = ''})
      : super._();

  factory _$LiquidTxInImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiquidTxInImplFromJson(json);

  @override
  @JsonKey()
  final LiquidOutPoint previousOutput;
  @override
  @JsonKey()
  final String scriptSig;

  @override
  String toString() {
    return 'LiquidTxIn(previousOutput: $previousOutput, scriptSig: $scriptSig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidTxInImpl &&
            (identical(other.previousOutput, previousOutput) ||
                other.previousOutput == previousOutput) &&
            (identical(other.scriptSig, scriptSig) ||
                other.scriptSig == scriptSig));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, previousOutput, scriptSig);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidTxInImplCopyWith<_$LiquidTxInImpl> get copyWith =>
      __$$LiquidTxInImplCopyWithImpl<_$LiquidTxInImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiquidTxInImplToJson(
      this,
    );
  }
}

abstract class _LiquidTxIn extends LiquidTxIn {
  factory _LiquidTxIn(
      {final LiquidOutPoint previousOutput,
      final String scriptSig}) = _$LiquidTxInImpl;
  _LiquidTxIn._() : super._();

  factory _LiquidTxIn.fromJson(Map<String, dynamic> json) =
      _$LiquidTxInImpl.fromJson;

  @override
  LiquidOutPoint get previousOutput;
  @override
  String get scriptSig;
  @override
  @JsonKey(ignore: true)
  _$$LiquidTxInImplCopyWith<_$LiquidTxInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiquidTxOut _$LiquidTxOutFromJson(Map<String, dynamic> json) {
  return _LiquidTxOut.fromJson(json);
}

/// @nodoc
mixin _$LiquidTxOut {
  int get value => throw _privateConstructorUsedError;
  String get scriptPubKey => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiquidTxOutCopyWith<LiquidTxOut> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidTxOutCopyWith<$Res> {
  factory $LiquidTxOutCopyWith(
          LiquidTxOut value, $Res Function(LiquidTxOut) then) =
      _$LiquidTxOutCopyWithImpl<$Res, LiquidTxOut>;
  @useResult
  $Res call({int value, String scriptPubKey, String address});
}

/// @nodoc
class _$LiquidTxOutCopyWithImpl<$Res, $Val extends LiquidTxOut>
    implements $LiquidTxOutCopyWith<$Res> {
  _$LiquidTxOutCopyWithImpl(this._value, this._then);

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
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiquidTxOutImplCopyWith<$Res>
    implements $LiquidTxOutCopyWith<$Res> {
  factory _$$LiquidTxOutImplCopyWith(
          _$LiquidTxOutImpl value, $Res Function(_$LiquidTxOutImpl) then) =
      __$$LiquidTxOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, String scriptPubKey, String address});
}

/// @nodoc
class __$$LiquidTxOutImplCopyWithImpl<$Res>
    extends _$LiquidTxOutCopyWithImpl<$Res, _$LiquidTxOutImpl>
    implements _$$LiquidTxOutImplCopyWith<$Res> {
  __$$LiquidTxOutImplCopyWithImpl(
      _$LiquidTxOutImpl _value, $Res Function(_$LiquidTxOutImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? scriptPubKey = null,
    Object? address = null,
  }) {
    return _then(_$LiquidTxOutImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      scriptPubKey: null == scriptPubKey
          ? _value.scriptPubKey
          : scriptPubKey // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiquidTxOutImpl extends _LiquidTxOut {
  _$LiquidTxOutImpl({this.value = 0, this.scriptPubKey = '', this.address = ''})
      : super._();

  factory _$LiquidTxOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiquidTxOutImplFromJson(json);

  @override
  @JsonKey()
  final int value;
  @override
  @JsonKey()
  final String scriptPubKey;
  @override
  @JsonKey()
  final String address;

  @override
  String toString() {
    return 'LiquidTxOut(value: $value, scriptPubKey: $scriptPubKey, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidTxOutImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.scriptPubKey, scriptPubKey) ||
                other.scriptPubKey == scriptPubKey) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, scriptPubKey, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidTxOutImplCopyWith<_$LiquidTxOutImpl> get copyWith =>
      __$$LiquidTxOutImplCopyWithImpl<_$LiquidTxOutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiquidTxOutImplToJson(
      this,
    );
  }
}

abstract class _LiquidTxOut extends LiquidTxOut {
  factory _LiquidTxOut(
      {final int value,
      final String scriptPubKey,
      final String address}) = _$LiquidTxOutImpl;
  _LiquidTxOut._() : super._();

  factory _LiquidTxOut.fromJson(Map<String, dynamic> json) =
      _$LiquidTxOutImpl.fromJson;

  @override
  int get value;
  @override
  String get scriptPubKey;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$LiquidTxOutImplCopyWith<_$LiquidTxOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
