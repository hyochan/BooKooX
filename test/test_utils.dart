import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

import 'package:wecount/utils/colors.dart';
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/navigations/home_tab.dart';
import 'package:wecount/screens/splash.dart' show Splash;
import 'package:wecount/screens/intro.dart' show Intro;
import 'package:wecount/screens/sign_in.dart' show SignIn;
import 'package:wecount/screens/sign_up.dart' show SignUp;
import 'package:wecount/screens/find_pw.dart' show FindPw;
import 'package:wecount/screens/terms.dart' show Terms;
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
import 'package:wecount/utils/themes.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/generated/l10n.dart' show S;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestUtils {
  static late MockNavigatorObserver observer;
  static Widget makeTestableWidget({Widget? child}) {
    observer = MockNavigatorObserver();

    var widget = MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: Themes.light,
        darkTheme: Themes.dark,
        home: child,
        navigatorObservers: <NavigatorObserver>[observer],
        routes: {
          AppRoute.splash.fullPath: (BuildContext context) => const Splash(),
          AppRoute.tutorial.fullPath: (BuildContext context) =>
              const Tutorial(),
          AppRoute.intro.fullPath: (BuildContext context) => const Intro(),
          AppRoute.signIn.fullPath: (BuildContext context) => const SignIn(),
          AppRoute.signUp.fullPath: (BuildContext context) => const SignUp(),
          AppRoute.findPw.fullPath: (BuildContext context) => const FindPw(),
          AppRoute.mainEmpty.fullPath: (BuildContext context) =>
              const MainEmpty(),
          AppRoute.homeTab.fullPath: (BuildContext context) => const HomeTab(),
          AppRoute.ledgers.fullPath: (BuildContext context) => const Ledgers(),
          AppRoute.ledgerEdit.fullPath: (BuildContext context) =>
              const LedgerEdit(),
          AppRoute.terms.fullPath: (BuildContext context) => const Terms(),
          AppRoute.profileMy.fullPath: (BuildContext context) =>
              const ProfileMy(),
          AppRoute.setting.fullPath: (BuildContext context) => const Setting(),
          AppRoute.settingAnnouncement.fullPath: (BuildContext context) =>
              const SettingAnnouncement(),
          AppRoute.settingOpinion.fullPath: (BuildContext context) =>
              const SettingOpinion(),
          AppRoute.settingFAQ.fullPath: (BuildContext context) =>
              const SettingFAQ(),
          AppRoute.settingNotification.fullPath: (BuildContext context) =>
              const SettingNotification(),
        },
      ),
    );

    var ledger = Ledger(
        id: '1234',
        title: 'dooboolab',
        color: ColorType.dusk,
        currency: Currency());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentLedger(ledger)),
      ],
      child: widget,
    );
  }
}
