import 'package:bookoox/screens/line_graph.dart';
import 'package:bookoox/screens/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import './navigations/home_tab.dart' show HomeTab;
import './screens/tutorial.dart' show Tutorial;
import './screens/splash.dart' show Splash;
import './screens/intro.dart' show Intro;
import './screens/login.dart' show Login;
import './screens/sign_up.dart' show SignUp;
import './screens/find_pw.dart' show FindPw;
import './screens/main_empty.dart' show MainEmpty;
import './screens/terms.dart' show Terms;
import './screens/ledgers.dart' show Ledgers;
import './screens/ledger_add.dart' show LedgerAdd;
import './screens/ledger_view.dart' show LedgerView;
import './screens/ledger_item_add.dart' show LedgerItemAdd;
import './screens/profile_my.dart' show ProfileMy;
import './screens/setting.dart' show Setting;
import './screens/setting_announcement.dart' show SettingAnnouncement;
import './screens/setting_opinion.dart' show SettingOpinion;
import './screens/setting_faq.dart' show SettingFAQ;
import './screens/setting_notification.dart' show SettingNotification;
import './screens/setting_currency.dart' show SettingCurrency;
import './screens/setting_excel.dart' show SettingExcel;
import './screens/lock_register.dart' show LockRegister;
import './screens/lock_auth.dart' show LockAuth;

import './utils/asset.dart' as Asset;
import './utils/localization.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static const supportedLocales = ['en', 'ko'];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Theme.of(context).brightness,
        accentColor: Asset.Colors.greenBlue,
        hintColor: Asset.Colors.paleGray,
        primaryColor: Asset.Colors.dusk,
        primaryColorLight: const Color(0xff6d7999),
        primaryColorDark: const Color(0xff172540),
        secondaryHeaderColor: Asset.Colors.mediumGray,
        backgroundColor: Asset.Colors.light,
        bottomAppBarColor: Asset.Colors.lightDim,
        disabledColor: Asset.Colors.warmGray,
        dialogBackgroundColor: Asset.Colors.light,

        textTheme: TextTheme(
          headline1: TextStyle(color: Asset.Colors.dark),
          headline2: TextStyle(color: Asset.Colors.mediumGray),
          caption: TextStyle(color: Asset.Colors.light),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Asset.Colors.greenBlue,
        hintColor: Asset.Colors.warmGray,
        primaryColor: Asset.Colors.dusk,
        primaryColorLight: const Color(0xff6d7999),
        primaryColorDark: const Color(0xff172540),
        secondaryHeaderColor: Asset.Colors.mediumGray,
        backgroundColor: Asset.Colors.darkDim,
        bottomAppBarColor: Asset.Colors.darkDim,
        disabledColor: Asset.Colors.warmGray,
        dialogBackgroundColor: Asset.Colors.dark,

        textTheme: TextTheme(
          headline1: TextStyle(color: Asset.Colors.light),
          headline2: TextStyle(color: Asset.Colors.paleGray),
          caption: TextStyle(color: Asset.Colors.dark),
        ),
      ),
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
        '/ledger_view': (BuildContext context) => LedgerView(),
        '/terms': (BuildContext context) => Terms(),
        '/profile_my': (BuildContext context) => ProfileMy(),
        '/setting': (BuildContext context) => Setting(),
        '/setting_announcement': (BuildContext context) =>
            SettingAnnouncement(),
        '/setting_opinion': (BuildContext context) => SettingOpinion(),
        '/setting_faq': (BuildContext context) => SettingFAQ(),
        '/setting_notification': (BuildContext context) =>
            SettingNotification(),
        '/ledger_item_add': (BuildContext context) => LedgerItemAdd(),
        '/setting_currency': (BuildContext context) => SettingCurrency(),
        '/setting_excel': (BuildContext context) => SettingExcel(),
        '/lock_register': (BuildContext context) => LockRegister(),
        '/lock_auth': (BuildContext context) => LockAuth(),
        '/line_graph': (BuildContext context) => LineGraph(),
      },
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ko', 'KR'),
      ],
      localizationsDelegates: [
        const LocalizationDelegate(supportedLocales: ['en', 'ko']),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'BooKooX',
      // home: Tutorial(),
      home: HomeTab(),
    );
  }
}
