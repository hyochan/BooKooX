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
import './screens/ledger_item_add.dart' show LedgerItemAdd;
import './screens/profile_my.dart' show ProfileMy;
import './screens/setting.dart' show Setting;
import './screens/setting_announcement.dart' show SettingAnnouncement;
import './screens/setting_opinion.dart' show SettingOpinion;
import './screens/setting_faq.dart' show SettingFAQ;
import './screens/setting_notification.dart' show SettingNotification;
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
        brightness: Brightness.light,
        accentColor: Asset.Colors.red,
        hintColor: Asset.Colors.paleGray,
        primaryColor: Asset.Colors.dusk,
        primaryColorLight: const Color(0xff6d7999),
        primaryColorDark: const Color(0xff172540),
        disabledColor: const Color(0xffdde2ec),
        backgroundColor: const Color(0xfff9fbfd),
        dialogBackgroundColor: Colors.white,
        textTheme: TextTheme(
          title: TextStyle(color: Asset.Colors.dusk),
          subtitle: TextStyle(color: Asset.Colors.cloudyBlue),
          subhead: TextStyle(color: Colors.black),
          body1: TextStyle(color: Colors.black),
          display1: TextStyle(color: Asset.Colors.paleGray),
          display2: TextStyle(color: Asset.Colors.mediumGray),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Asset.Colors.red,
        hintColor: Asset.Colors.paleGray,
        disabledColor: const Color(0xffdde2ec),
        backgroundColor: const Color(0xff303030),
        dialogBackgroundColor: Colors.white,
        textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          subhead: TextStyle(color: Colors.white),
          display1: TextStyle(color: Asset.Colors.paleGray),
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
        '/terms': (BuildContext context) => Terms(),
        '/profile_my': (BuildContext context) => ProfileMy(),
        '/setting': (BuildContext context) => Setting(),
        '/setting_announcement': (BuildContext context) => SettingAnnouncement(),
        '/setting_opinion': (BuildContext context) => SettingOpinion(),
        '/setting_faq': (BuildContext context) => SettingFAQ(),
        '/setting_notification': (BuildContext context) => SettingNotification(),
        '/ledger_item_add': (BuildContext context) => LedgerItemAdd(),
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
      title: 'BooKoo2',
      home: HomeTab(),
    );
  }
}
