// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LedgerItem _$$_LedgerItemFromJson(Map<String, dynamic> json) =>
    _$_LedgerItem(
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      memo: json['memo'] as String?,
      writer: json['writer'] == null
          ? null
          : UserModel.fromJson(json['writer'] as Map<String, dynamic>),
      selectedDate:
          const ServerTimestampConverter().fromJson(json['selectedDate']),
      picture: (json['picture'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      latlng: json['latlng'] as String?,
      address: json['address'] as String?,
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      updatedAt: const ServerTimestampConverter().fromJson(json['updatedAt']),
      deletedAt: const ServerTimestampConverter().fromJson(json['deletedAt']),
    );

Map<String, dynamic> _$$_LedgerItemToJson(_$_LedgerItem instance) =>
    <String, dynamic>{
      'price': instance.price,
      'category': instance.category,
      'memo': instance.memo,
      'writer': instance.writer,
      'selectedDate': _$JsonConverterToJson<Object?, DateTime>(
          instance.selectedDate, const ServerTimestampConverter().toJson),
      'picture': instance.picture,
      'latlng': instance.latlng,
      'address': instance.address,
      'createdAt': _$JsonConverterToJson<Object?, DateTime>(
          instance.createdAt, const ServerTimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<Object?, DateTime>(
          instance.updatedAt, const ServerTimestampConverter().toJson),
      'deletedAt': _$JsonConverterToJson<Object?, DateTime>(
          instance.deletedAt, const ServerTimestampConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as int?,
      iconId: json['iconId'] as int?,
      label: json['label'] as String,
      type: $enumDecodeNullable(_$CategoryTypeEnumMap, json['type']),
      showDelete: json['showDelete'] as bool? ?? false,
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iconId': instance.iconId,
      'label': instance.label,
      'type': _$CategoryTypeEnumMap[instance.type],
      'showDelete': instance.showDelete,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.CONSUME: 'CONSUME',
  CategoryType.INCOME: 'INCOME',
};
