import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, dynamic> _sentences;

  Future<bool> load() async {
    print('languageCode: ${this.locale.languageCode}');

    String data = await rootBundle
        .loadString('res/langs/${this.locale.languageCode}.json');
    print('$data');

    this._sentences = json.decode(data);
    return true;
  }

  String trans(String key) {
    if (key == null) {
      return '...';
    }
    return this._sentences[key];
  }
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate({
    this.supportedLocales = const ['en', 'ko'],
  });
  final supportedLocales;

  @override
  bool isSupported(Locale locale) => this.supportedLocales.contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    Localization localizations = new Localization(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
