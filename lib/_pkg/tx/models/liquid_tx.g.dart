// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquid_tx.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LiquidOutPointSchema = Schema(
  name: r'LiquidOutPoint',
  id: -3887333566499496371,
  properties: {
    r'txid': PropertySchema(
      id: 0,
      name: r'txid',
      type: IsarType.string,
    ),
    r'vout': PropertySchema(
      id: 1,
      name: r'vout',
      type: IsarType.long,
    )
  },
  estimateSize: _liquidOutPointEstimateSize,
  serialize: _liquidOutPointSerialize,
  deserialize: _liquidOutPointDeserialize,
  deserializeProp: _liquidOutPointDeserializeProp,
);

int _liquidOutPointEstimateSize(
  LiquidOutPoint object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.txid.length * 3;
  return bytesCount;
}

void _liquidOutPointSerialize(
  LiquidOutPoint object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.txid);
  writer.writeLong(offsets[1], object.vout);
}

LiquidOutPoint _liquidOutPointDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LiquidOutPoint(
    txid: reader.readString(offsets[0]),
    vout: reader.readLong(offsets[1]),
  );
  return object;
}

P _liquidOutPointDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LiquidOutPointQueryFilter
    on QueryBuilder<LiquidOutPoint, LiquidOutPoint, QFilterCondition> {
  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'txid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'txid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      txidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      voutEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vout',
        value: value,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      voutGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vout',
        value: value,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      voutLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vout',
        value: value,
      ));
    });
  }

  QueryBuilder<LiquidOutPoint, LiquidOutPoint, QAfterFilterCondition>
      voutBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vout',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LiquidOutPointQueryObject
    on QueryBuilder<LiquidOutPoint, LiquidOutPoint, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LiquidTxInSchema = Schema(
  name: r'LiquidTxIn',
  id: 478234690796836591,
  properties: {
    r'previousOutput': PropertySchema(
      id: 0,
      name: r'previousOutput',
      type: IsarType.object,
      target: r'LiquidOutPoint',
    ),
    r'scriptSig': PropertySchema(
      id: 1,
      name: r'scriptSig',
      type: IsarType.string,
    )
  },
  estimateSize: _liquidTxInEstimateSize,
  serialize: _liquidTxInSerialize,
  deserialize: _liquidTxInDeserialize,
  deserializeProp: _liquidTxInDeserializeProp,
);

int _liquidTxInEstimateSize(
  LiquidTxIn object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      LiquidOutPointSchema.estimateSize(
          object.previousOutput, allOffsets[LiquidOutPoint]!, allOffsets);
  bytesCount += 3 + object.scriptSig.length * 3;
  return bytesCount;
}

void _liquidTxInSerialize(
  LiquidTxIn object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<LiquidOutPoint>(
    offsets[0],
    allOffsets,
    LiquidOutPointSchema.serialize,
    object.previousOutput,
  );
  writer.writeString(offsets[1], object.scriptSig);
}

LiquidTxIn _liquidTxInDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LiquidTxIn(
    previousOutput: reader.readObjectOrNull<LiquidOutPoint>(
          offsets[0],
          LiquidOutPointSchema.deserialize,
          allOffsets,
        ) ??
        LiquidOutPoint(),
    scriptSig: reader.readString(offsets[1]),
  );
  return object;
}

P _liquidTxInDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<LiquidOutPoint>(
            offset,
            LiquidOutPointSchema.deserialize,
            allOffsets,
          ) ??
          LiquidOutPoint()) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LiquidTxInQueryFilter
    on QueryBuilder<LiquidTxIn, LiquidTxIn, QFilterCondition> {
  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> scriptSigEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scriptSig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition>
      scriptSigGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scriptSig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> scriptSigLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scriptSig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> scriptSigBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scriptSig',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition>
      scriptSigStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scriptSig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> scriptSigEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scriptSig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> scriptSigContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scriptSig',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> scriptSigMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scriptSig',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition>
      scriptSigIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scriptSig',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition>
      scriptSigIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scriptSig',
        value: '',
      ));
    });
  }
}

extension LiquidTxInQueryObject
    on QueryBuilder<LiquidTxIn, LiquidTxIn, QFilterCondition> {
  QueryBuilder<LiquidTxIn, LiquidTxIn, QAfterFilterCondition> previousOutput(
      FilterQuery<LiquidOutPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'previousOutput');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LiquidTxOutSchema = Schema(
  name: r'LiquidTxOut',
  id: -8506920197926433088,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'scriptPubKey': PropertySchema(
      id: 1,
      name: r'scriptPubKey',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 2,
      name: r'value',
      type: IsarType.long,
    )
  },
  estimateSize: _liquidTxOutEstimateSize,
  serialize: _liquidTxOutSerialize,
  deserialize: _liquidTxOutDeserialize,
  deserializeProp: _liquidTxOutDeserializeProp,
);

int _liquidTxOutEstimateSize(
  LiquidTxOut object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.scriptPubKey.length * 3;
  return bytesCount;
}

void _liquidTxOutSerialize(
  LiquidTxOut object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.scriptPubKey);
  writer.writeLong(offsets[2], object.value);
}

LiquidTxOut _liquidTxOutDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LiquidTxOut(
    address: reader.readString(offsets[0]),
    scriptPubKey: reader.readString(offsets[1]),
    value: reader.readLong(offsets[2]),
  );
  return object;
}

P _liquidTxOutDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LiquidTxOutQueryFilter
    on QueryBuilder<LiquidTxOut, LiquidTxOut, QFilterCondition> {
  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> addressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> addressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scriptPubKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scriptPubKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scriptPubKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scriptPubKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scriptPubKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scriptPubKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scriptPubKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scriptPubKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scriptPubKey',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      scriptPubKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scriptPubKey',
        value: '',
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> valueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition>
      valueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> valueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<LiquidTxOut, LiquidTxOut, QAfterFilterCondition> valueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LiquidTxOutQueryObject
    on QueryBuilder<LiquidTxOut, LiquidTxOut, QFilterCondition> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiquidTxImpl _$$LiquidTxImplFromJson(Map<String, dynamic> json) =>
    _$LiquidTxImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TxTypeEnumMap, json['type']),
      timestamp: json['timestamp'] as int,
      sent: json['sent'] as int? ?? 0,
      received: json['received'] as int? ?? 0,
      amount: json['amount'] as int,
      fee: json['fee'] as int,
      height: json['height'] as int,
      version: json['version'] as int,
      vsize: json['vsize'] as int,
      weight: json['weight'] as int,
      locktime: json['locktime'] as int,
      linputs: (json['linputs'] as List<dynamic>)
          .map((e) => LiquidTxIn.fromJson(e as Map<String, dynamic>))
          .toList(),
      loutputs: (json['loutputs'] as List<dynamic>)
          .map((e) => LiquidTxOut.fromJson(e as Map<String, dynamic>))
          .toList(),
      toAddress: json['toAddress'] as String,
      labels: (json['labels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      walletId: json['walletId'] as String?,
      inputs: (json['inputs'] as List<dynamic>?)
              ?.map((e) => BitcoinTxIn.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      outputs: (json['outputs'] as List<dynamic>?)
              ?.map((e) => BitcoinTxOut.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rbfChain: (json['rbfChain'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rbfIndex: json['rbfIndex'] as int? ?? 0,
    )
      ..isarId = json['isarId'] as int
      ..psbt = json['psbt'] as String?
      ..broadcastTime = json['broadcastTime'] as int?
      ..rbfEnabled = json['rbfEnabled'] as bool?;

Map<String, dynamic> _$$LiquidTxImplToJson(_$LiquidTxImpl instance) =>
    <String, dynamic>{
      'isarId': instance.isarId,
      'psbt': instance.psbt,
      'broadcastTime': instance.broadcastTime,
      'rbfEnabled': instance.rbfEnabled,
      'id': instance.id,
      'type': _$TxTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp,
      'sent': instance.sent,
      'received': instance.received,
      'amount': instance.amount,
      'fee': instance.fee,
      'height': instance.height,
      'version': instance.version,
      'vsize': instance.vsize,
      'weight': instance.weight,
      'locktime': instance.locktime,
      'linputs': instance.linputs,
      'loutputs': instance.loutputs,
      'toAddress': instance.toAddress,
      'labels': instance.labels,
      'walletId': instance.walletId,
      'inputs': instance.inputs,
      'outputs': instance.outputs,
      'rbfChain': instance.rbfChain,
      'rbfIndex': instance.rbfIndex,
    };

const _$TxTypeEnumMap = {
  TxType.Bitcoin: 'Bitcoin',
  TxType.Liquid: 'Liquid',
  TxType.Lightning: 'Lightning',
  TxType.Usdt: 'Usdt',
};

_$LiquidOutPointImpl _$$LiquidOutPointImplFromJson(Map<String, dynamic> json) =>
    _$LiquidOutPointImpl(
      txid: json['txid'] as String? ?? '',
      vout: json['vout'] as int? ?? 0,
    );

Map<String, dynamic> _$$LiquidOutPointImplToJson(
        _$LiquidOutPointImpl instance) =>
    <String, dynamic>{
      'txid': instance.txid,
      'vout': instance.vout,
    };

_$LiquidTxInImpl _$$LiquidTxInImplFromJson(Map<String, dynamic> json) =>
    _$LiquidTxInImpl(
      previousOutput: json['previousOutput'] == null
          ? const LiquidOutPoint()
          : LiquidOutPoint.fromJson(
              json['previousOutput'] as Map<String, dynamic>),
      scriptSig: json['scriptSig'] as String? ?? '',
    );

Map<String, dynamic> _$$LiquidTxInImplToJson(_$LiquidTxInImpl instance) =>
    <String, dynamic>{
      'previousOutput': instance.previousOutput,
      'scriptSig': instance.scriptSig,
    };

_$LiquidTxOutImpl _$$LiquidTxOutImplFromJson(Map<String, dynamic> json) =>
    _$LiquidTxOutImpl(
      value: json['value'] as int? ?? 0,
      scriptPubKey: json['scriptPubKey'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );

Map<String, dynamic> _$$LiquidTxOutImplToJson(_$LiquidTxOutImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'scriptPubKey': instance.scriptPubKey,
      'address': instance.address,
    };
