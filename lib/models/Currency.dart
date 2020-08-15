class Currency {
  String currency;
  String locale;
  String symbol;
  bool selected = false;

  Currency({
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

final List<Currency> currencies = [
  new Currency(
    locale: 'es',
    currency: 'ARS',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'hy',
    currency: 'AMD',
    symbol: '؋',
    selected: false,
  ),
  new Currency(
    locale: 'bs',
    currency: 'BAM',
    symbol: 'KM',
    selected: false,
  ),
  new Currency(
    locale: 'bg',
    currency: 'BGN',
    symbol: 'лв',
    selected: false,
  ),
  new Currency(
    locale: 'ms-bn',
    currency: 'BRN',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'es-bo',
    currency: 'BOB',
    symbol: '\$b',
    selected: false,
  ),
  new Currency(
    locale: 'pt-br',
    currency: 'BRL',
    symbol: 'R\$',
    selected: false,
  ),
  new Currency(
    locale: 'be',
    currency: 'BYN',
    symbol: 'Br',
    selected: false,
  ),
  new Currency(
    locale: 'en-bz',
    currency: 'BZD',
    symbol: 'BZ\$',
    selected: false,
  ),
  new Currency(
    locale: 'en-ca',
    currency: 'CAD',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'es-cl',
    currency: 'CLP',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'zh',
    currency: 'CNY',
    symbol: '¥',
    selected: false,
  ),
  new Currency(
    locale: 'es-co',
    currency: 'COP',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'es-cr',
    currency: 'CRC',
    symbol: '₡',
    selected: false,
  ),
  new Currency(
    locale: 'cs',
    currency: 'CZK',
    symbol: 'Kč',
    selected: false,
  ),
  new Currency(
    locale: 'es-do',
    currency: 'DOP',
    symbol: 'RD\$',
    selected: false,
  ),
  new Currency(
    locale: 'ar-eg',
    currency: 'EGP',
    symbol: '£',
    selected: false,
  ),
  new Currency(
    locale: 'fr',
    currency: 'EUR',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'el',
    currency: 'GRD',
    symbol: 'GRD',
    selected: false,
  ),
  new Currency(
    locale: 'es-gt',
    currency: 'GTQ',
    symbol: 'Q',
    selected: false,
  ),
  new Currency(
    locale: 'es-hn',
    currency: 'HNL',
    symbol: 'L',
    selected: false,
  ),
  new Currency(
    locale: 'zh-hk',
    currency: 'HKD',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'hr',
    currency: 'HRK',
    symbol: 'kn',
    selected: false,
  ),
  new Currency(
    locale: 'hu',
    currency: 'HUF',
    symbol: 'Ft',
    selected: false,
  ),
  new Currency(
    locale: 'id',
    currency: 'IDR',
    symbol: 'Rp',
    selected: false,
  ),
  new Currency(
    locale: 'is',
    currency: 'IND',
    symbol: '₹',
    selected: false,
  ),
  new Currency(
    locale: 'bn',
    currency: 'ISK',
    symbol: 'kr',
    selected: false,
  ),
  new Currency(
    locale: 'it-it',
    currency: 'ITL',
    symbol: 'ITL',
    selected: false,
  ),
  new Currency(
    locale: 'ja',
    currency: 'JPY',
    symbol: '¥',
    selected: false,
  ),
  new Currency(
    locale: 'ko',
    currency: 'KRW',
    symbol: '₩',
    selected: false,
  ),
  new Currency(
    locale: 'es-mx',
    currency: 'MXN',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'ms-my',
    currency: 'MYR',
    symbol: 'RM',
    selected: false,
  ),
  new Currency(
    locale: 'no-no',
    currency: 'NOK',
    symbol: 'kr',
    selected: false,
  ),
  new Currency(
    locale: 'ne',
    currency: 'NPR',
    symbol: 'Rs',
    selected: false,
  ),
  new Currency(
    locale: 'en-ph',
    currency: 'PHP',
    symbol: '₱',
    selected: false,
  ),
  new Currency(
    locale: 'ru',
    currency: 'RUB',
    symbol: 'руб',
    selected: false,
  ),
  new Currency(
    locale: 'ro',
    currency: 'RON',
    symbol: 'lei',
    selected: false,
  ),
  new Currency(
    locale: 'sv-se',
    currency: 'SEK',
    symbol: 'kr',
    selected: false,
  ),
  new Currency(
    locale: 'so',
    currency: 'SOS',
    symbol: 'S',
    selected: false,
  ),
  new Currency(
    locale: 'ar-sy',
    currency: 'SYP',
    symbol: '£',
    selected: false,
  ),
  new Currency(
    locale: 'es-sv',
    currency: 'SVC',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'zh-tw',
    currency: 'TWD',
    symbol: 'NT\$',
    selected: false,
  ),
  new Currency(
    locale: 'tr',
    currency: 'TRY',
    symbol: '₺',
    selected: false,
  ),
  new Currency(
    locale: 'uz-uz',
    currency: 'UZS',
    symbol: 'UZS',
    selected: false,
  ),
  new Currency(
    locale: 'en-us',
    currency: 'USD',
    symbol: '\$',
    selected: false,
  ),
  new Currency(
    locale: 'vi',
    currency: 'VND',
    symbol: 'R',
    selected: false,
  ),
  new Currency(
    locale: 'en-za',
    currency: 'ZAR',
    symbol: 'VND',
    selected: false,
  ),
];