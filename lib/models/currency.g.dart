// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Currency _$$_CurrencyFromJson(Map<String, dynamic> json) => _$_Currency(
      currency: json['currency'] as String?,
      locale: json['locale'] as String?,
      symbol: json['symbol'] as String?,
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$$_CurrencyToJson(_$_Currency instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'locale': instance.locale,
      'symbol': instance.symbol,
      'selected': instance.selected,
    };
