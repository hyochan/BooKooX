// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ledger _$$_LedgerFromJson(Map<String, dynamic> json) => _$_Ledger(
      id: json['id'] as String?,
      title: json['title'] as String,
      color: $enumDecode(_$ColorTypeEnumMap, json['color']),
      description: json['description'] as String?,
      people: json['people'] as int?,
      ownerId: json['ownerId'] as String?,
      adminIds: (json['adminIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => LedgerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );

Map<String, dynamic> _$$_LedgerToJson(_$_Ledger instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': _$ColorTypeEnumMap[instance.color]!,
      'description': instance.description,
      'people': instance.people,
      'ownerId': instance.ownerId,
      'adminIds': instance.adminIds,
      'items': instance.items,
      'currency': instance.currency,
      'memberIds': instance.memberIds,
      'members': instance.members,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
    };

const _$ColorTypeEnumMap = {
  ColorType.red: 'red',
  ColorType.orange: 'orange',
  ColorType.yellow: 'yellow',
  ColorType.green: 'green',
  ColorType.blue: 'blue',
  ColorType.dusk: 'dusk',
  ColorType.purple: 'purple',
};
