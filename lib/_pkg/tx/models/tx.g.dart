// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTxCollection on Isar {
  IsarCollection<Tx> get txs => this.collection();
}

const TxSchema = CollectionSchema(
  name: r'Tx',
  id: 4184853192607142548,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'broadcastTime': PropertySchema(
      id: 1,
      name: r'broadcastTime',
      type: IsarType.long,
    ),
    r'fee': PropertySchema(
      id: 2,
      name: r'fee',
      type: IsarType.long,
    ),
    r'height': PropertySchema(
      id: 3,
      name: r'height',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'inputs': PropertySchema(
      id: 5,
      name: r'inputs',
      type: IsarType.objectList,
      target: r'BitcoinTxIn',
    ),
    r'labels': PropertySchema(
      id: 6,
      name: r'labels',
      type: IsarType.stringList,
    ),
    r'linputs': PropertySchema(
      id: 7,
      name: r'linputs',
      type: IsarType.objectList,
      target: r'LiquidTxIn',
    ),
    r'locktime': PropertySchema(
      id: 8,
      name: r'locktime',
      type: IsarType.long,
    ),
    r'loutputs': PropertySchema(
      id: 9,
      name: r'loutputs',
      type: IsarType.objectList,
      target: r'LiquidTxOut',
    ),
    r'outputs': PropertySchema(
      id: 10,
      name: r'outputs',
      type: IsarType.objectList,
      target: r'BitcoinTxOut',
    ),
    r'psbt': PropertySchema(
      id: 11,
      name: r'psbt',
      type: IsarType.string,
    ),
    r'rbfChain': PropertySchema(
      id: 12,
      name: r'rbfChain',
      type: IsarType.stringList,
    ),
    r'rbfEnabled': PropertySchema(
      id: 13,
      name: r'rbfEnabled',
      type: IsarType.bool,
    ),
    r'rbfIndex': PropertySchema(
      id: 14,
      name: r'rbfIndex',
      type: IsarType.long,
    ),
    r'received': PropertySchema(
      id: 15,
      name: r'received',
      type: IsarType.long,
    ),
    r'sent': PropertySchema(
      id: 16,
      name: r'sent',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 17,
      name: r'timestamp',
      type: IsarType.long,
    ),
    r'toAddress': PropertySchema(
      id: 18,
      name: r'toAddress',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 19,
      name: r'type',
      type: IsarType.byte,
      enumMap: _TxtypeEnumValueMap,
    ),
    r'version': PropertySchema(
      id: 20,
      name: r'version',
      type: IsarType.long,
    ),
    r'vsize': PropertySchema(
      id: 21,
      name: r'vsize',
      type: IsarType.long,
    ),
    r'walletId': PropertySchema(
      id: 22,
      name: r'walletId',
      type: IsarType.string,
    ),
    r'weight': PropertySchema(
      id: 23,
      name: r'weight',
      type: IsarType.long,
    )
  },
  estimateSize: _txEstimateSize,
  serialize: _txSerialize,
  deserialize: _txDeserialize,
  deserializeProp: _txDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'labels': IndexSchema(
      id: 78128526024441885,
      name: r'labels',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'labels',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'walletId': IndexSchema(
      id: -1783113319798776304,
      name: r'walletId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'walletId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'BitcoinTxIn': BitcoinTxInSchema,
    r'BitcoinOutPoint': BitcoinOutPointSchema,
    r'BitcoinTxOut': BitcoinTxOutSchema,
    r'LiquidTxIn': LiquidTxInSchema,
    r'LiquidOutPoint': LiquidOutPointSchema,
    r'LiquidTxOut': LiquidTxOutSchema
  },
  getId: _txGetId,
  getLinks: _txGetLinks,
  attach: _txAttach,
  version: '3.1.0+1',
);

int _txEstimateSize(
  Tx object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  {
    final list = object.inputs;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[BitcoinTxIn]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              BitcoinTxInSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.labels;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.linputs;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[LiquidTxIn]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              LiquidTxInSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.loutputs;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[LiquidTxOut]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              LiquidTxOutSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.outputs;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[BitcoinTxOut]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              BitcoinTxOutSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.psbt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.rbfChain.length * 3;
  {
    for (var i = 0; i < object.rbfChain.length; i++) {
      final value = object.rbfChain[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.toAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.walletId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _txSerialize(
  Tx object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeLong(offsets[1], object.broadcastTime);
  writer.writeLong(offsets[2], object.fee);
  writer.writeLong(offsets[3], object.height);
  writer.writeString(offsets[4], object.id);
  writer.writeObjectList<BitcoinTxIn>(
    offsets[5],
    allOffsets,
    BitcoinTxInSchema.serialize,
    object.inputs,
  );
  writer.writeStringList(offsets[6], object.labels);
  writer.writeObjectList<LiquidTxIn>(
    offsets[7],
    allOffsets,
    LiquidTxInSchema.serialize,
    object.linputs,
  );
  writer.writeLong(offsets[8], object.locktime);
  writer.writeObjectList<LiquidTxOut>(
    offsets[9],
    allOffsets,
    LiquidTxOutSchema.serialize,
    object.loutputs,
  );
  writer.writeObjectList<BitcoinTxOut>(
    offsets[10],
    allOffsets,
    BitcoinTxOutSchema.serialize,
    object.outputs,
  );
  writer.writeString(offsets[11], object.psbt);
  writer.writeStringList(offsets[12], object.rbfChain);
  writer.writeBool(offsets[13], object.rbfEnabled);
  writer.writeLong(offsets[14], object.rbfIndex);
  writer.writeLong(offsets[15], object.received);
  writer.writeLong(offsets[16], object.sent);
  writer.writeLong(offsets[17], object.timestamp);
  writer.writeString(offsets[18], object.toAddress);
  writer.writeByte(offsets[19], object.type.index);
  writer.writeLong(offsets[20], object.version);
  writer.writeLong(offsets[21], object.vsize);
  writer.writeString(offsets[22], object.walletId);
  writer.writeLong(offsets[23], object.weight);
}

Tx _txDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tx();
  object.amount = reader.readLong(offsets[0]);
  object.broadcastTime = reader.readLongOrNull(offsets[1]);
  object.fee = reader.readLong(offsets[2]);
  object.height = reader.readLongOrNull(offsets[3]);
  object.id = reader.readString(offsets[4]);
  object.inputs = reader.readObjectList<BitcoinTxIn>(
    offsets[5],
    BitcoinTxInSchema.deserialize,
    allOffsets,
    BitcoinTxIn(),
  );
  object.isarId = id;
  object.labels = reader.readStringList(offsets[6]);
  object.linputs = reader.readObjectList<LiquidTxIn>(
    offsets[7],
    LiquidTxInSchema.deserialize,
    allOffsets,
    LiquidTxIn(),
  );
  object.locktime = reader.readLongOrNull(offsets[8]);
  object.loutputs = reader.readObjectList<LiquidTxOut>(
    offsets[9],
    LiquidTxOutSchema.deserialize,
    allOffsets,
    LiquidTxOut(),
  );
  object.outputs = reader.readObjectList<BitcoinTxOut>(
    offsets[10],
    BitcoinTxOutSchema.deserialize,
    allOffsets,
    BitcoinTxOut(),
  );
  object.psbt = reader.readStringOrNull(offsets[11]);
  object.rbfChain = reader.readStringList(offsets[12]) ?? [];
  object.rbfEnabled = reader.readBoolOrNull(offsets[13]);
  object.rbfIndex = reader.readLong(offsets[14]);
  object.received = reader.readLong(offsets[15]);
  object.sent = reader.readLong(offsets[16]);
  object.timestamp = reader.readLong(offsets[17]);
  object.toAddress = reader.readStringOrNull(offsets[18]);
  object.type =
      _TxtypeValueEnumMap[reader.readByteOrNull(offsets[19])] ?? TxType.Bitcoin;
  object.version = reader.readLongOrNull(offsets[20]);
  object.vsize = reader.readLongOrNull(offsets[21]);
  object.walletId = reader.readStringOrNull(offsets[22]);
  object.weight = reader.readLongOrNull(offsets[23]);
  return object;
}

P _txDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectList<BitcoinTxIn>(
        offset,
        BitcoinTxInSchema.deserialize,
        allOffsets,
        BitcoinTxIn(),
      )) as P;
    case 6:
      return (reader.readStringList(offset)) as P;
    case 7:
      return (reader.readObjectList<LiquidTxIn>(
        offset,
        LiquidTxInSchema.deserialize,
        allOffsets,
        LiquidTxIn(),
      )) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readObjectList<LiquidTxOut>(
        offset,
        LiquidTxOutSchema.deserialize,
        allOffsets,
        LiquidTxOut(),
      )) as P;
    case 10:
      return (reader.readObjectList<BitcoinTxOut>(
        offset,
        BitcoinTxOutSchema.deserialize,
        allOffsets,
        BitcoinTxOut(),
      )) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringList(offset) ?? []) as P;
    case 13:
      return (reader.readBoolOrNull(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (_TxtypeValueEnumMap[reader.readByteOrNull(offset)] ??
          TxType.Bitcoin) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TxtypeEnumValueMap = {
  'Bitcoin': 0,
  'Liquid': 1,
  'Lightning': 2,
  'Usdt': 3,
};
const _TxtypeValueEnumMap = {
  0: TxType.Bitcoin,
  1: TxType.Liquid,
  2: TxType.Lightning,
  3: TxType.Usdt,
};

Id _txGetId(Tx object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _txGetLinks(Tx object) {
  return [];
}

void _txAttach(IsarCollection<dynamic> col, Id id, Tx object) {
  object.isarId = id;
}

extension TxQueryWhereSort on QueryBuilder<Tx, Tx, QWhere> {
  QueryBuilder<Tx, Tx, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhere> anyLabelsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'labels'),
      );
    });
  }
}

extension TxQueryWhere on QueryBuilder<Tx, Tx, QWhereClause> {
  QueryBuilder<Tx, Tx, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> timestampEqualTo(int timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> timestampNotEqualTo(int timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> timestampGreaterThan(
    int timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [timestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> timestampLessThan(
    int timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [],
        upper: [timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> timestampBetween(
    int lowerTimestamp,
    int upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [lowerTimestamp],
        includeLower: includeLower,
        upper: [upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementEqualTo(
      String labelsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'labels',
        value: [labelsElement],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementNotEqualTo(
      String labelsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'labels',
              lower: [],
              upper: [labelsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'labels',
              lower: [labelsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'labels',
              lower: [labelsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'labels',
              lower: [],
              upper: [labelsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementGreaterThan(
    String labelsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'labels',
        lower: [labelsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementLessThan(
    String labelsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'labels',
        lower: [],
        upper: [labelsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementBetween(
    String lowerLabelsElement,
    String upperLabelsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'labels',
        lower: [lowerLabelsElement],
        includeLower: includeLower,
        upper: [upperLabelsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementStartsWith(
      String LabelsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'labels',
        lower: [LabelsElementPrefix],
        upper: ['$LabelsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'labels',
        value: [''],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> labelsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'labels',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'labels',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'labels',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'labels',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> walletIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'walletId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> walletIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'walletId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> walletIdEqualTo(String? walletId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'walletId',
        value: [walletId],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> walletIdNotEqualTo(String? walletId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'walletId',
              lower: [],
              upper: [walletId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'walletId',
              lower: [walletId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'walletId',
              lower: [walletId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'walletId',
              lower: [],
              upper: [walletId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TxQueryFilter on QueryBuilder<Tx, Tx, QFilterCondition> {
  QueryBuilder<Tx, Tx, QAfterFilterCondition> amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> broadcastTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'broadcastTime',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> broadcastTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'broadcastTime',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> broadcastTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'broadcastTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> broadcastTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'broadcastTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> broadcastTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'broadcastTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> broadcastTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'broadcastTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> feeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fee',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> feeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fee',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> feeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fee',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> feeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fee',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> heightEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> heightGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> heightLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> heightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'labels',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'labels',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'labels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'labels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'labels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'labels',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'labels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'labels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'labels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'labels',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'labels',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'labels',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labels',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labels',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labels',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labels',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labels',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> labelsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labels',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linputs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linputs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linputs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linputs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linputs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'linputs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> locktimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locktime',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> locktimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locktime',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> locktimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locktime',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> locktimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locktime',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> locktimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locktime',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> locktimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locktime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loutputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loutputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loutputs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loutputs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loutputs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loutputs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loutputs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loutputs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'outputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'outputs',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'outputs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'outputs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'outputs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'outputs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'outputs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'outputs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'psbt',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'psbt',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'psbt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'psbt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'psbt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'psbt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'psbt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'psbt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'psbt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'psbt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'psbt',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> psbtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'psbt',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rbfChain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rbfChain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rbfChain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rbfChain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rbfChain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rbfChain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rbfChain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rbfChain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rbfChain',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rbfChain',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rbfChain',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rbfChain',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rbfChain',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rbfChain',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rbfChain',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfChainLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rbfChain',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfEnabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rbfEnabled',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfEnabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rbfEnabled',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfEnabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rbfEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rbfIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rbfIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rbfIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rbfIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rbfIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> receivedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'received',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> receivedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'received',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> receivedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'received',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> receivedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'received',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> sentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sent',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> sentGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sent',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> sentLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sent',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> sentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> timestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> timestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> timestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> timestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toAddress',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toAddress',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> toAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> typeEqualTo(TxType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> typeGreaterThan(
    TxType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> typeLessThan(
    TxType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> typeBetween(
    TxType lower,
    TxType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> versionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'version',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> versionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'version',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> versionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> versionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> versionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> versionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> vsizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vsize',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> vsizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vsize',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> vsizeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vsize',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> vsizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vsize',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> vsizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vsize',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> vsizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vsize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'walletId',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'walletId',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'walletId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'walletId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'walletId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'walletId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'walletId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'walletId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'walletId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'walletId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'walletId',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> walletIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'walletId',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> weightEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> weightGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> weightLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> weightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TxQueryObject on QueryBuilder<Tx, Tx, QFilterCondition> {
  QueryBuilder<Tx, Tx, QAfterFilterCondition> inputsElement(
      FilterQuery<BitcoinTxIn> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'inputs');
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> linputsElement(
      FilterQuery<LiquidTxIn> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'linputs');
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> loutputsElement(
      FilterQuery<LiquidTxOut> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'loutputs');
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> outputsElement(
      FilterQuery<BitcoinTxOut> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'outputs');
    });
  }
}

extension TxQueryLinks on QueryBuilder<Tx, Tx, QFilterCondition> {}

extension TxQuerySortBy on QueryBuilder<Tx, Tx, QSortBy> {
  QueryBuilder<Tx, Tx, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByBroadcastTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'broadcastTime', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByBroadcastTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'broadcastTime', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fee', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fee', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByLocktime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locktime', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByLocktimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locktime', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByPsbt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psbt', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByPsbtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psbt', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByRbfEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfEnabled', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByRbfEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfEnabled', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByRbfIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfIndex', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByRbfIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfIndex', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'received', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'received', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortBySent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sent', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortBySentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sent', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByToAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByToAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByVsize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vsize', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByVsizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vsize', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByWalletId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walletId', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByWalletIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walletId', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension TxQuerySortThenBy on QueryBuilder<Tx, Tx, QSortThenBy> {
  QueryBuilder<Tx, Tx, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByBroadcastTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'broadcastTime', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByBroadcastTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'broadcastTime', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fee', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fee', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByLocktime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locktime', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByLocktimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locktime', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByPsbt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psbt', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByPsbtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psbt', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByRbfEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfEnabled', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByRbfEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfEnabled', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByRbfIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfIndex', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByRbfIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rbfIndex', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'received', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'received', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenBySent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sent', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenBySentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sent', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByToAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByToAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByVsize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vsize', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByVsizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vsize', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByWalletId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walletId', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByWalletIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walletId', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension TxQueryWhereDistinct on QueryBuilder<Tx, Tx, QDistinct> {
  QueryBuilder<Tx, Tx, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByBroadcastTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'broadcastTime');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fee');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByLabels() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'labels');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByLocktime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locktime');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByPsbt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'psbt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByRbfChain() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rbfChain');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByRbfEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rbfEnabled');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByRbfIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rbfIndex');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'received');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctBySent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sent');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByToAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByVsize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vsize');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByWalletId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walletId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension TxQueryProperty on QueryBuilder<Tx, Tx, QQueryProperty> {
  QueryBuilder<Tx, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<Tx, int?, QQueryOperations> broadcastTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'broadcastTime');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> feeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fee');
    });
  }

  QueryBuilder<Tx, int?, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<Tx, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tx, List<BitcoinTxIn>?, QQueryOperations> inputsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inputs');
    });
  }

  QueryBuilder<Tx, List<String>?, QQueryOperations> labelsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'labels');
    });
  }

  QueryBuilder<Tx, List<LiquidTxIn>?, QQueryOperations> linputsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linputs');
    });
  }

  QueryBuilder<Tx, int?, QQueryOperations> locktimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locktime');
    });
  }

  QueryBuilder<Tx, List<LiquidTxOut>?, QQueryOperations> loutputsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loutputs');
    });
  }

  QueryBuilder<Tx, List<BitcoinTxOut>?, QQueryOperations> outputsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outputs');
    });
  }

  QueryBuilder<Tx, String?, QQueryOperations> psbtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'psbt');
    });
  }

  QueryBuilder<Tx, List<String>, QQueryOperations> rbfChainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rbfChain');
    });
  }

  QueryBuilder<Tx, bool?, QQueryOperations> rbfEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rbfEnabled');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> rbfIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rbfIndex');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> receivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'received');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> sentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sent');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<Tx, String?, QQueryOperations> toAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toAddress');
    });
  }

  QueryBuilder<Tx, TxType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Tx, int?, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }

  QueryBuilder<Tx, int?, QQueryOperations> vsizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vsize');
    });
  }

  QueryBuilder<Tx, String?, QQueryOperations> walletIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walletId');
    });
  }

  QueryBuilder<Tx, int?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}
