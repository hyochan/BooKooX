import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import 'package:bookoo2/utils/localization.dart' show Localization;
import 'package:bookoo2/screens/intro.dart';

class MyTestDelegate extends LocalizationsDelegate<Localization>{
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<Localization> load(Locale locale) async {
    return Localization(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) {
    return false;
  }
}

class TestUtils {
  static Widget makeTestableWidget({ Widget child }) {
    return MaterialApp(
      supportedLocales: [
        const Locale('en', 'US'),
      ],
      localizationsDelegates: [
        MyTestDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        return const Locale('en', 'US');
      },
      home: child,
    );
  }
}
