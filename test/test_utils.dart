import 'package:wecount/generated/l10n.dart';
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/navigations/home_tab.dart';
import 'package:wecount/providers/current_ledger.dart';
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
  static late MockNavigatorObserver observer;
  static Widget makeTestableWidget({Widget? child}) {
    observer = MockNavigatorObserver();

    var widget = MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: child,
        navigatorObservers: <NavigatorObserver>[observer],
        routes: {
          Splash.name: (BuildContext context) => Splash(),
          Tutorial.name: (BuildContext context) => Tutorial(),
          Intro.name: (BuildContext context) => Intro(),
          SignIn.name: (BuildContext context) => SignIn(),
          SignUp.name: (BuildContext context) => SignUp(),
          FindPw.name: (BuildContext context) => FindPw(),
          MainEmpty.name: (BuildContext context) => MainEmpty(),
          HomeTab.name: (BuildContext context) => HomeTab(),
          Ledgers.name: (BuildContext context) => Ledgers(),
          LedgerEdit.name: (BuildContext context) => LedgerEdit(),
          Terms.name: (BuildContext context) => Terms(),
          ProfileMy.name: (BuildContext context) => ProfileMy(),
          Setting.name: (BuildContext context) => Setting(),
          SettingAnnouncement.name: (BuildContext context) =>
              SettingAnnouncement(),
          SettingOpinion.name: (BuildContext context) => SettingOpinion(),
          SettingFAQ.name: (BuildContext context) => SettingFAQ(),
          SettingNotification.name: (BuildContext context) =>
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
