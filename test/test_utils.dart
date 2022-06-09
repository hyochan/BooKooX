import 'package:wecount/models/Currency.dart';
import 'package:wecount/models/Ledger.dart';
import 'package:wecount/navigations/home_tab.dart';
import 'package:wecount/providers/CurrentLedger.dart';
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/ledgers.dart';
import 'package:wecount/screens/main_empty.dart';
import 'package:wecount/screens/profile_my.dart';
import 'package:wecount/screens/setting.dart';
import 'package:wecount/screens/setting_announcement.dart';
import 'package:wecount/screens/setting_faq.dart';
import 'package:wecount/screens/setting_notification.dart';
import 'package:wecount/screens/setting_opinion.dart';
import 'package:wecount/screens/tutorial.dart';
import 'package:wecount/types/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:wecount/utils/localization.dart' show LocalizationDelegate;

import 'package:mockito/mockito.dart';
import 'package:wecount/screens/splash.dart' show Splash;
import 'package:wecount/screens/intro.dart' show Intro;
import 'package:wecount/screens/sign_in.dart' show SignIn;
import 'package:wecount/screens/sign_up.dart' show SignUp;
import 'package:wecount/screens/find_pw.dart' show FindPw;
import 'package:wecount/screens/terms.dart' show Terms;
import 'package:provider/provider.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestUtils {
  static MockNavigatorObserver observer;
  static Widget makeTestableWidget({Widget child}) {
    observer = MockNavigatorObserver();

    var widget = MediaQuery(
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
          '/sign_in': (BuildContext context) => SignIn(),
          '/sign_up': (BuildContext context) => SignUp(),
          '/find_pw': (BuildContext context) => FindPw(),
          '/main_empty': (BuildContext context) => MainEmpty(),
          '/home': (BuildContext context) => HomeTab(),
          '/ledgers': (BuildContext context) => Ledgers(),
          '/ledger_edit': (BuildContext context) => LedgerEdit(),
          '/terms': (BuildContext context) => Terms(),
          '/profile_my': (BuildContext context) => ProfileMy(),
          '/setting': (BuildContext context) => Setting(),
          '/setting_announcement': (BuildContext context) =>
              SettingAnnouncement(),
          '/setting_opinion': (BuildContext context) => SettingOpinion(),
          '/setting_faq': (BuildContext context) => SettingFAQ(),
          '/setting_notification': (BuildContext context) =>
              SettingNotification(),
        },
      ),
    );

    var ledger = Ledger(
        id: '1234',
        title: 'dooboolab',
        color: ColorType.DUSK,
        currency: Currency());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentLedger(ledger)),
      ],
      child: widget,
    );
  }
}
