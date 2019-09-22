import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale, {
    this.isTest = false,
  });
  final Locale locale;
  bool isTest;
  Map<String, String> _sentences;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Future<Localization> loadTest(Locale locale) async {
    return Localization(locale);
  }

  Future<Localization> load() async {
    String data = await rootBundle
        .loadString('res/langs/${locale.languageCode}.json');

    Map<String, dynamic> _result = json.decode(data);
    _sentences = new Map();
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });
    return Localization(locale);
  }


  String trans(String key) {
    if (isTest) return key;

    if (key == null) {
      return '...';
    }
    return this._sentences[key];
  }
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate({
    this.supportedLocales = const ['en'],
    this.isTest = false,
  });
  final List<String> supportedLocales;
  final bool isTest;

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    Localization localizations = new Localization(locale, isTest: isTest);
    if (isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    return localizations;
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
