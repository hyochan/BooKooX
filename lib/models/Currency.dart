class Currency {
  String code;
  String currency;

  Currency({
    this.code,
    this.currency,
  });

  @override
  String toString() {
    return 'code: $code, currency: $currency';
  }
}