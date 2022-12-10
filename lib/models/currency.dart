import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
class Currency with _$Currency {
  const Currency._();
  factory Currency(
      {String? currency,
      String? locale,
      String? symbol,
      @Default(false) bool? selected}) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}

final List<Currency> currencies = [
  Currency(
    locale: 'es',
    currency: 'ARS',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'hy',
    currency: 'AMD',
    symbol: '؋',
    selected: false,
  ),
  Currency(
    locale: 'bs',
    currency: 'BAM',
    symbol: 'KM',
    selected: false,
  ),
  Currency(
    locale: 'bg',
    currency: 'BGN',
    symbol: 'лв',
    selected: false,
  ),
  Currency(
    locale: 'ms-bn',
    currency: 'BRN',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'es-bo',
    currency: 'BOB',
    symbol: '\$b',
    selected: false,
  ),
  Currency(
    locale: 'pt-br',
    currency: 'BRL',
    symbol: 'R\$',
    selected: false,
  ),
  Currency(
    locale: 'be',
    currency: 'BYN',
    symbol: 'Br',
    selected: false,
  ),
  Currency(
    locale: 'en-bz',
    currency: 'BZD',
    symbol: 'BZ\$',
    selected: false,
  ),
  Currency(
    locale: 'en-ca',
    currency: 'CAD',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'es-cl',
    currency: 'CLP',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'zh',
    currency: 'CNY',
    symbol: '¥',
    selected: false,
  ),
  Currency(
    locale: 'es-co',
    currency: 'COP',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'es-cr',
    currency: 'CRC',
    symbol: '₡',
    selected: false,
  ),
  Currency(
    locale: 'cs',
    currency: 'CZK',
    symbol: 'Kč',
    selected: false,
  ),
  Currency(
    locale: 'es-do',
    currency: 'DOP',
    symbol: 'RD\$',
    selected: false,
  ),
  Currency(
    locale: 'ar-eg',
    currency: 'EGP',
    symbol: '£',
    selected: false,
  ),
  Currency(
    locale: 'fr',
    currency: 'EUR',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'el',
    currency: 'GRD',
    symbol: 'GRD',
    selected: false,
  ),
  Currency(
    locale: 'es-gt',
    currency: 'GTQ',
    symbol: 'Q',
    selected: false,
  ),
  Currency(
    locale: 'es-hn',
    currency: 'HNL',
    symbol: 'L',
    selected: false,
  ),
  Currency(
    locale: 'zh-hk',
    currency: 'HKD',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'hr',
    currency: 'HRK',
    symbol: 'kn',
    selected: false,
  ),
  Currency(
    locale: 'hu',
    currency: 'HUF',
    symbol: 'Ft',
    selected: false,
  ),
  Currency(
    locale: 'id',
    currency: 'IDR',
    symbol: 'Rp',
    selected: false,
  ),
  Currency(
    locale: 'is',
    currency: 'IND',
    symbol: '₹',
    selected: false,
  ),
  Currency(
    locale: 'bn',
    currency: 'ISK',
    symbol: 'kr',
    selected: false,
  ),
  Currency(
    locale: 'it-it',
    currency: 'ITL',
    symbol: 'ITL',
    selected: false,
  ),
  Currency(
    locale: 'ja',
    currency: 'JPY',
    symbol: '¥',
    selected: false,
  ),
  Currency(
    locale: 'ko',
    currency: 'KRW',
    symbol: '₩',
    selected: false,
  ),
  Currency(
    locale: 'es-mx',
    currency: 'MXN',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'ms-my',
    currency: 'MYR',
    symbol: 'RM',
    selected: false,
  ),
  Currency(
    locale: 'no-no',
    currency: 'NOK',
    symbol: 'kr',
    selected: false,
  ),
  Currency(
    locale: 'ne',
    currency: 'NPR',
    symbol: 'Rs',
    selected: false,
  ),
  Currency(
    locale: 'en-ph',
    currency: 'PHP',
    symbol: '₱',
    selected: false,
  ),
  Currency(
    locale: 'ru',
    currency: 'RUB',
    symbol: 'руб',
    selected: false,
  ),
  Currency(
    locale: 'ro',
    currency: 'RON',
    symbol: 'lei',
    selected: false,
  ),
  Currency(
    locale: 'sv-se',
    currency: 'SEK',
    symbol: 'kr',
    selected: false,
  ),
  Currency(
    locale: 'so',
    currency: 'SOS',
    symbol: 'S',
    selected: false,
  ),
  Currency(
    locale: 'ar-sy',
    currency: 'SYP',
    symbol: '£',
    selected: false,
  ),
  Currency(
    locale: 'es-sv',
    currency: 'SVC',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'zh-tw',
    currency: 'TWD',
    symbol: 'NT\$',
    selected: false,
  ),
  Currency(
    locale: 'tr',
    currency: 'TRY',
    symbol: '₺',
    selected: false,
  ),
  Currency(
    locale: 'uz-uz',
    currency: 'UZS',
    symbol: 'UZS',
    selected: false,
  ),
  Currency(
    locale: 'en-us',
    currency: 'USD',
    symbol: '\$',
    selected: false,
  ),
  Currency(
    locale: 'vi',
    currency: 'VND',
    symbol: 'R',
    selected: false,
  ),
  Currency(
    locale: 'en-za',
    currency: 'ZAR',
    symbol: 'VND',
    selected: false,
  ),
];
