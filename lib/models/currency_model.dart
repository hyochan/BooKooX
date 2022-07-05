class CurrencyModel {
  String? currency;
  String? locale;
  String? symbol;
  bool? selected = false;

  CurrencyModel({
    this.locale,
    this.currency,
    this.symbol,
    this.selected,
  });

  @override
  String toString() {
    return 'currency: $currency, locale: $locale, symbol: $symbol';
  }
}

final List<CurrencyModel> currencies = [
  CurrencyModel(
    locale: 'es',
    currency: 'ARS',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'hy',
    currency: 'AMD',
    symbol: '؋',
    selected: false,
  ),
  CurrencyModel(
    locale: 'bs',
    currency: 'BAM',
    symbol: 'KM',
    selected: false,
  ),
  CurrencyModel(
    locale: 'bg',
    currency: 'BGN',
    symbol: 'лв',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ms-bn',
    currency: 'BRN',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-bo',
    currency: 'BOB',
    symbol: '\$b',
    selected: false,
  ),
  CurrencyModel(
    locale: 'pt-br',
    currency: 'BRL',
    symbol: 'R\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'be',
    currency: 'BYN',
    symbol: 'Br',
    selected: false,
  ),
  CurrencyModel(
    locale: 'en-bz',
    currency: 'BZD',
    symbol: 'BZ\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'en-ca',
    currency: 'CAD',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-cl',
    currency: 'CLP',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'zh',
    currency: 'CNY',
    symbol: '¥',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-co',
    currency: 'COP',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-cr',
    currency: 'CRC',
    symbol: '₡',
    selected: false,
  ),
  CurrencyModel(
    locale: 'cs',
    currency: 'CZK',
    symbol: 'Kč',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-do',
    currency: 'DOP',
    symbol: 'RD\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ar-eg',
    currency: 'EGP',
    symbol: '£',
    selected: false,
  ),
  CurrencyModel(
    locale: 'fr',
    currency: 'EUR',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'el',
    currency: 'GRD',
    symbol: 'GRD',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-gt',
    currency: 'GTQ',
    symbol: 'Q',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-hn',
    currency: 'HNL',
    symbol: 'L',
    selected: false,
  ),
  CurrencyModel(
    locale: 'zh-hk',
    currency: 'HKD',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'hr',
    currency: 'HRK',
    symbol: 'kn',
    selected: false,
  ),
  CurrencyModel(
    locale: 'hu',
    currency: 'HUF',
    symbol: 'Ft',
    selected: false,
  ),
  CurrencyModel(
    locale: 'id',
    currency: 'IDR',
    symbol: 'Rp',
    selected: false,
  ),
  CurrencyModel(
    locale: 'is',
    currency: 'IND',
    symbol: '₹',
    selected: false,
  ),
  CurrencyModel(
    locale: 'bn',
    currency: 'ISK',
    symbol: 'kr',
    selected: false,
  ),
  CurrencyModel(
    locale: 'it-it',
    currency: 'ITL',
    symbol: 'ITL',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ja',
    currency: 'JPY',
    symbol: '¥',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ko',
    currency: 'KRW',
    symbol: '₩',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-mx',
    currency: 'MXN',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ms-my',
    currency: 'MYR',
    symbol: 'RM',
    selected: false,
  ),
  CurrencyModel(
    locale: 'no-no',
    currency: 'NOK',
    symbol: 'kr',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ne',
    currency: 'NPR',
    symbol: 'Rs',
    selected: false,
  ),
  CurrencyModel(
    locale: 'en-ph',
    currency: 'PHP',
    symbol: '₱',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ru',
    currency: 'RUB',
    symbol: 'руб',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ro',
    currency: 'RON',
    symbol: 'lei',
    selected: false,
  ),
  CurrencyModel(
    locale: 'sv-se',
    currency: 'SEK',
    symbol: 'kr',
    selected: false,
  ),
  CurrencyModel(
    locale: 'so',
    currency: 'SOS',
    symbol: 'S',
    selected: false,
  ),
  CurrencyModel(
    locale: 'ar-sy',
    currency: 'SYP',
    symbol: '£',
    selected: false,
  ),
  CurrencyModel(
    locale: 'es-sv',
    currency: 'SVC',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'zh-tw',
    currency: 'TWD',
    symbol: 'NT\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'tr',
    currency: 'TRY',
    symbol: '₺',
    selected: false,
  ),
  CurrencyModel(
    locale: 'uz-uz',
    currency: 'UZS',
    symbol: 'UZS',
    selected: false,
  ),
  CurrencyModel(
    locale: 'en-us',
    currency: 'USD',
    symbol: '\$',
    selected: false,
  ),
  CurrencyModel(
    locale: 'vi',
    currency: 'VND',
    symbol: 'R',
    selected: false,
  ),
  CurrencyModel(
    locale: 'en-za',
    currency: 'ZAR',
    symbol: 'VND',
    selected: false,
  ),
];
