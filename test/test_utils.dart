import 'package:bookoo2/navigations/home_tab.dart';
import 'package:bookoo2/screens/ledger_add.dart';
import 'package:bookoo2/screens/ledgers.dart';
import 'package:bookoo2/screens/main_empty.dart';
import 'package:bookoo2/screens/profile_my.dart';
import 'package:bookoo2/screens/setting.dart';
import 'package:bookoo2/screens/setting_announcement.dart';
import 'package:bookoo2/screens/setting_faq.dart';
import 'package:bookoo2/screens/setting_notification.dart';
import 'package:bookoo2/screens/setting_opinion.dart';
import 'package:bookoo2/screens/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:bookoo2/utils/localization.dart' show LocalizationDelegate;

import 'package:mockito/mockito.dart';
import 'package:bookoo2/screens/splash.dart' show Splash;
import 'package:bookoo2/screens/intro.dart' show Intro;
import 'package:bookoo2/screens/login.dart' show Login;
import 'package:bookoo2/screens/sign_up.dart' show SignUp;
import 'package:bookoo2/screens/find_pw.dart' show FindPw;
import 'package:bookoo2/screens/home_calendar.dart' show HomeCalendar;
import 'package:bookoo2/screens/terms.dart' show Terms;


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
          '/tutorial': (BuildContext context) => Tutorial(),
          '/intro': (BuildContext context) => Intro(),
          '/login': (BuildContext context) => Login(),
          '/sign_up': (BuildContext context) => SignUp(),
          '/find_pw': (BuildContext context) => FindPw(),
          '/main_empty': (BuildContext context) => MainEmpty(),
          '/home': (BuildContext context) => HomeTab(),
          '/ledgers': (BuildContext context) => Ledgers(),
          '/ledger_add': (BuildContext context) => LedgerAdd(),
          '/terms': (BuildContext context) => Terms(),
          '/profile_my': (BuildContext context) => ProfileMy(),
          '/setting': (BuildContext context) => Setting(),
          '/setting_announcement': (BuildContext context) => SettingAnnouncement(),
          '/setting_opinion': (BuildContext context) => SettingOpinion(),
          '/setting_faq': (BuildContext context) => SettingFAQ(),
          '/setting_notification': (BuildContext context) => SettingNotification(),
        },
      ),
    );
  }
}
