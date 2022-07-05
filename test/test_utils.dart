import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:wecount/generated/l10n.dart';
import 'package:wecount/models/currency_model.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/navigations/home_tab.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/find_pw.dart' show FindPw;
import 'package:wecount/screens/intro.dart' show Intro;
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/ledgers.dart';
import 'package:wecount/screens/main_empty.dart';
import 'package:wecount/screens/profile_my.dart';
import 'package:wecount/screens/setting.dart';
import 'package:wecount/screens/setting_announcement.dart';
import 'package:wecount/screens/setting_faq.dart';
import 'package:wecount/screens/setting_notification.dart';
import 'package:wecount/screens/setting_opinion.dart';
import 'package:wecount/screens/sign_in.dart' show SignIn;
import 'package:wecount/screens/sign_up.dart' show SignUp;
import 'package:wecount/screens/splash.dart' show Splash;
import 'package:wecount/screens/terms.dart' show Terms;
import 'package:wecount/screens/tutorial.dart';
import 'package:wecount/types/color.dart';

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
        ],
        home: child,
        navigatorObservers: <NavigatorObserver>[observer],
        routes: {
          Splash.name: (BuildContext context) => const Splash(),
          Tutorial.name: (BuildContext context) => const Tutorial(),
          Intro.name: (BuildContext context) => const Intro(),
          SignIn.name: (BuildContext context) => const SignIn(),
          SignUp.name: (BuildContext context) => const SignUp(),
          FindPw.name: (BuildContext context) => const FindPw(),
          MainEmpty.name: (BuildContext context) => const MainEmpty(),
          HomeTab.name: (BuildContext context) => const HomeTab(),
          Ledgers.name: (BuildContext context) => const Ledgers(),
          LedgerEdit.name: (BuildContext context) => const LedgerEdit(),
          Terms.name: (BuildContext context) => const Terms(),
          ProfileMy.name: (BuildContext context) => const ProfileMy(),
          Setting.name: (BuildContext context) => const Setting(),
          SettingAnnouncement.name: (BuildContext context) =>
              const SettingAnnouncement(),
          SettingOpinion.name: (BuildContext context) => const SettingOpinion(),
          SettingFAQ.name: (BuildContext context) => const SettingFAQ(),
          SettingNotification.name: (BuildContext context) =>
              const SettingNotification(),
        },
      ),
    );

    var ledger = LedgerModel(
        id: '1234',
        title: 'dooboolab',
        color: ColorType.dusk,
        currency: CurrencyModel());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentLedger(ledger)),
      ],
      child: widget,
    );
  }
}
