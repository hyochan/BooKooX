import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:bookoo2/utils/localization.dart' show LocalizationDelegate;

import 'package:mockito/mockito.dart';
import 'package:bookoo2/screens/splash.dart' show Splash;
import 'package:bookoo2/screens/intro.dart' show Intro;
import 'package:bookoo2/screens/login.dart' show Login;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestUtils {
  static MockNavigatorObserver observer;
  static Widget makeTestableWidget({ Widget child }) {
    observer = MockNavigatorObserver();

    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        localizationsDelegates: [
          LocalizationDelegate(isTest: true),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: child,
        navigatorObservers: <NavigatorObserver>[observer],
        routes: {
          '/splash': (BuildContext context) => Splash(),
          '/intro': (BuildContext context) => Intro(),
          '/login': (BuildContext context) => Login(),
        },
      ),
    );
  }
}
