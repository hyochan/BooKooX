### How to add localization
1. Add `flutter_localizations` dependency in `pubspec.yaml` below `flutter: sdk: flutter`.
  ```
  flutter_localizations:
    sdk: flutter
  ```
2. Add languages to localize inside resource folder. Here, we created `res/langs` directory and created two json files which are `en.json` and `ko.json`.
3. Add assets dir in `pubspec.yaml`.
  ```
  assets:
    - res/langs/en.json
    - res/langs/ko.json
  ```
4. Put your Strings in each file like below.
  ```dart
  /// en.json
  {
    "LOADING": "Loading...",
    "INTRO": "Create App!"
  }
  /// ko.json
  {
    "LOADING": "로딩중...",
    "INTRO": "앱을 만들어봐요!"
  }
  ```
5. Create `localization.dart` in `utils` and add below codes.
  ```dart
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
      String data = await rootBundle
          .loadString('res/langs/${this.locale.languageCode}.json');

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
      supprt
    });

    @override
    bool isSupported(Locale locale) => [
      'en',
      'ko',
    ].contains(locale.languageCode);

    @override
    Future<Localization> load(Locale locale) async {
      Localization localizations = new Localization(locale);
      await localizations.load();
      return localizations;
    }

    @override
    bool shouldReload(LocalizationDelegate old) => false;
  }
  ```
6. Now in your `MaterialApp` which will be in your `root` `widget`, add below.
  ```dart
  supportedLocales: [
    const Locale('en', 'US'),
    const Locale('ko', 'KR')
  ],
  localizationsDelegates: [
    const LocalizationDelegate(
      supportedLocales: supportedLocales,
    ),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ],
  localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      debugPrint("*language locale is null!!!");
      return supportedLocales.first;
    }
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  },
  ```
  * Note that if you want to change the `supportedLocales`, you can pass parameters to `LocalizationDelegate`. You should also change the `supportedLocales` field in `MaterialApp`.
