// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitcoin_tx.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BitcoinOutPointSchema = Schema(
  name: r'BitcoinOutPoint',
  id: -13103958193371140,
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
  estimateSize: _bitcoinOutPointEstimateSize,
  serialize: _bitcoinOutPointSerialize,
  deserialize: _bitcoinOutPointDeserialize,
  deserializeProp: _bitcoinOutPointDeserializeProp,
);

int _bitcoinOutPointEstimateSize(
  BitcoinOutPoint object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.txid.length * 3;
  return bytesCount;
}

void _bitcoinOutPointSerialize(
  BitcoinOutPoint object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.txid);
  writer.writeLong(offsets[1], object.vout);
}

BitcoinOutPoint _bitcoinOutPointDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BitcoinOutPoint(
    txid: reader.readString(offsets[0]),
    vout: reader.readLong(offsets[1]),
  );
  return object;
}

P _bitcoinOutPointDeserializeProp<P>(
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

extension BitcoinOutPointQueryFilter
    on QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QFilterCondition> {
  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
      txidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
      txidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'txid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
      txidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
      txidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
      voutEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vout',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

  QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QAfterFilterCondition>
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

extension BitcoinOutPointQueryObject
    on QueryBuilder<BitcoinOutPoint, BitcoinOutPoint, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BitcoinTxInSchema = Schema(
  name: r'BitcoinTxIn',
  id: 1232122495829966215,
  properties: {
    r'previousOutput': PropertySchema(
      id: 0,
      name: r'previousOutput',
      type: IsarType.object,
      target: r'BitcoinOutPoint',
    ),
    r'scriptSig': PropertySchema(
      id: 1,
      name: r'scriptSig',
      type: IsarType.longList,
    ),
    r'sequence': PropertySchema(
      id: 2,
      name: r'sequence',
      type: IsarType.long,
    ),
    r'witness': PropertySchema(
      id: 3,
      name: r'witness',
      type: IsarType.stringList,
    )
  },
  estimateSize: _bitcoinTxInEstimateSize,
  serialize: _bitcoinTxInSerialize,
  deserialize: _bitcoinTxInDeserialize,
  deserializeProp: _bitcoinTxInDeserializeProp,
);

int _bitcoinTxInEstimateSize(
  BitcoinTxIn object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      BitcoinOutPointSchema.estimateSize(
          object.previousOutput, allOffsets[BitcoinOutPoint]!, allOffsets);
  bytesCount += 3 + object.scriptSig.length * 8;
  bytesCount += 3 + object.witness.length * 3;
  {
    for (var i = 0; i < object.witness.length; i++) {
      final value = object.witness[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _bitcoinTxInSerialize(
  BitcoinTxIn object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<BitcoinOutPoint>(
    offsets[0],
    allOffsets,
    BitcoinOutPointSchema.serialize,
    object.previousOutput,
  );
  writer.writeLongList(offsets[1], object.scriptSig);
  writer.writeLong(offsets[2], object.sequence);
  writer.writeStringList(offsets[3], object.witness);
}

BitcoinTxIn _bitcoinTxInDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BitcoinTxIn(
    previousOutput: reader.readObjectOrNull<BitcoinOutPoint>(
          offsets[0],
          BitcoinOutPointSchema.deserialize,
          allOffsets,
        ) ??
        BitcoinOutPoint(),
    scriptSig: reader.readLongList(offsets[1]) ?? [],
    sequence: reader.readLong(offsets[2]),
    witness: reader.readStringList(offsets[3]) ?? [],
  );
  return object;
}

P _bitcoinTxInDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<BitcoinOutPoint>(
            offset,
            BitcoinOutPointSchema.deserialize,
            allOffsets,
          ) ??
          BitcoinOutPoint()) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BitcoinTxInQueryFilter
    on QueryBuilder<BitcoinTxIn, BitcoinTxIn, QFilterCondition> {
  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scriptSig',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scriptSig',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scriptSig',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scriptSig',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptSig',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptSig',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptSig',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptSig',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptSig',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      scriptSigLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptSig',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition> sequenceEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      sequenceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      sequenceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sequence',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition> sequenceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sequence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'witness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'witness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'witness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'witness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'witness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'witness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'witness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'witness',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'witness',
        value: '',
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'witness',
        value: '',
      ));
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'witness',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'witness',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'witness',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'witness',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'witness',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition>
      witnessLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'witness',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension BitcoinTxInQueryObject
    on QueryBuilder<BitcoinTxIn, BitcoinTxIn, QFilterCondition> {
  QueryBuilder<BitcoinTxIn, BitcoinTxIn, QAfterFilterCondition> previousOutput(
      FilterQuery<BitcoinOutPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'previousOutput');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BitcoinTxOutSchema = Schema(
  name: r'BitcoinTxOut',
  id: 1253314282146935425,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'scriptPubKey': PropertySchema(
      id: 1,
      name: r'scriptPubKey',
      type: IsarType.longList,
    ),
    r'value': PropertySchema(
      id: 2,
      name: r'value',
      type: IsarType.long,
    )
  },
  estimateSize: _bitcoinTxOutEstimateSize,
  serialize: _bitcoinTxOutSerialize,
  deserialize: _bitcoinTxOutDeserialize,
  deserializeProp: _bitcoinTxOutDeserializeProp,
);

int _bitcoinTxOutEstimateSize(
  BitcoinTxOut object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.scriptPubKey.length * 8;
  return bytesCount;
}

void _bitcoinTxOutSerialize(
  BitcoinTxOut object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeLongList(offsets[1], object.scriptPubKey);
  writer.writeLong(offsets[2], object.value);
}

BitcoinTxOut _bitcoinTxOutDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BitcoinTxOut(
    address: reader.readString(offsets[0]),
    scriptPubKey: reader.readLongList(offsets[1]) ?? [],
    value: reader.readLong(offsets[2]),
  );
  return object;
}

P _bitcoinTxOutDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BitcoinTxOutQueryFilter
    on QueryBuilder<BitcoinTxOut, BitcoinTxOut, QFilterCondition> {
  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressEqualTo(
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressLessThan(
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressBetween(
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressEndsWith(
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scriptPubKey',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scriptPubKey',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scriptPubKey',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scriptPubKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptPubKey',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptPubKey',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptPubKey',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptPubKey',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptPubKey',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
      scriptPubKeyLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scriptPubKey',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition> valueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition>
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<BitcoinTxOut, BitcoinTxOut, QAfterFilterCondition> valueBetween(
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

extension BitcoinTxOutQueryObject
    on QueryBuilder<BitcoinTxOut, BitcoinTxOut, QFilterCondition> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BitcoinTxImpl _$$BitcoinTxImplFromJson(Map<String, dynamic> json) =>
    _$BitcoinTxImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TxTypeEnumMap, json['type']),
      timestamp: json['timestamp'] as int,
      sent: json['sent'] as int? ?? 0,
      received: json['received'] as int? ?? 0,
      amount: json['amount'] as int,
      fee: json['fee'] as int,
      feeRate: (json['feeRate'] as num).toDouble(),
      height: json['height'] as int,
      psbt: json['psbt'] as String?,
      broadcastTime: json['broadcastTime'] as int?,
      rbfEnabled: json['rbfEnabled'] as bool,
      version: json['version'] as int,
      vsize: json['vsize'] as int,
      weight: json['weight'] as int,
      locktime: json['locktime'] as int,
      inputs: (json['inputs'] as List<dynamic>)
          .map((e) => BitcoinTxIn.fromJson(e as Map<String, dynamic>))
          .toList(),
      outputs: (json['outputs'] as List<dynamic>)
          .map((e) => BitcoinTxOut.fromJson(e as Map<String, dynamic>))
          .toList(),
      toAddress: json['toAddress'] as String,
      labels: (json['labels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      walletId: json['walletId'] as String?,
      linputs: (json['linputs'] as List<dynamic>?)
              ?.map((e) => LiquidTxIn.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      loutputs: (json['loutputs'] as List<dynamic>?)
              ?.map((e) => LiquidTxOut.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rbfChain: (json['rbfChain'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rbfIndex: json['rbfIndex'] as int? ?? -1,
    )..isarId = json['isarId'] as int;

Map<String, dynamic> _$$BitcoinTxImplToJson(_$BitcoinTxImpl instance) =>
    <String, dynamic>{
      'isarId': instance.isarId,
      'id': instance.id,
      'type': _$TxTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp,
      'sent': instance.sent,
      'received': instance.received,
      'amount': instance.amount,
      'fee': instance.fee,
      'feeRate': instance.feeRate,
      'height': instance.height,
      'psbt': instance.psbt,
      'broadcastTime': instance.broadcastTime,
      'rbfEnabled': instance.rbfEnabled,
      'version': instance.version,
      'vsize': instance.vsize,
      'weight': instance.weight,
      'locktime': instance.locktime,
      'inputs': instance.inputs,
      'outputs': instance.outputs,
      'toAddress': instance.toAddress,
      'labels': instance.labels,
      'walletId': instance.walletId,
      'linputs': instance.linputs,
      'loutputs': instance.loutputs,
      'rbfChain': instance.rbfChain,
      'rbfIndex': instance.rbfIndex,
    };

const _$TxTypeEnumMap = {
  TxType.Bitcoin: 'Bitcoin',
  TxType.Liquid: 'Liquid',
  TxType.Lightning: 'Lightning',
  TxType.Usdt: 'Usdt',
};

_$BitcoinOutPointImpl _$$BitcoinOutPointImplFromJson(
        Map<String, dynamic> json) =>
    _$BitcoinOutPointImpl(
      txid: json['txid'] as String? ?? '',
      vout: json['vout'] as int? ?? 0,
    );

Map<String, dynamic> _$$BitcoinOutPointImplToJson(
        _$BitcoinOutPointImpl instance) =>
    <String, dynamic>{
      'txid': instance.txid,
      'vout': instance.vout,
    };

_$BitcoinTxInImpl _$$BitcoinTxInImplFromJson(Map<String, dynamic> json) =>
    _$BitcoinTxInImpl(
      previousOutput: json['previousOutput'] == null
          ? const BitcoinOutPoint()
          : BitcoinOutPoint.fromJson(
              json['previousOutput'] as Map<String, dynamic>),
      scriptSig: (json['scriptSig'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      sequence: json['sequence'] as int? ?? 0,
      witness: (json['witness'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BitcoinTxInImplToJson(_$BitcoinTxInImpl instance) =>
    <String, dynamic>{
      'previousOutput': instance.previousOutput,
      'scriptSig': instance.scriptSig,
      'sequence': instance.sequence,
      'witness': instance.witness,
    };

_$BitcoinTxOutImpl _$$BitcoinTxOutImplFromJson(Map<String, dynamic> json) =>
    _$BitcoinTxOutImpl(
      value: json['value'] as int? ?? 0,
      scriptPubKey: (json['scriptPubKey'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      address: json['address'] as String? ?? '',
    );

Map<String, dynamic> _$$BitcoinTxOutImplToJson(_$BitcoinTxOutImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'scriptPubKey': instance.scriptPubKey,
      'address': instance.address,
    };
