import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import './navigations/home_tab.dart' show HomeTab;
import './screens/splash.dart' show Splash;
import './screens/intro.dart' show Intro;
import './screens/login.dart' show Login;
import './screens/sign_up.dart' show SignUp;
import './screens/find_pw.dart' show FindPw;
import './screens/terms.dart' show Terms;
import './screens/ledgers.dart' show Ledgers;
import './screens/ledger_add.dart' show LedgerAdd;
import './screens/profile_my.dart' show ProfileMy;
import './screens/setting.dart' show Setting;
import './screens/setting_announcement.dart' show SettingAnnouncement;
import './screens/setting_faq.dart' show SettingFAQ;
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
        primaryColor: const Color(0xff414d6b),
        primaryColorLight: const Color(0xff6d7999),
        primaryColorDark: const Color(0xff172540),
        accentColor: const Color(0xffe6677e),
        hintColor: const Color(0xffafc2db),
        disabledColor: const Color(0xffdde2ec),
        backgroundColor: const Color(0xfff9fbfd),
        dialogBackgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
        ),
      ),
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
         backgroundColor: const Color(0xff303030),
      ),
      routes: {
        '/splash': (BuildContext context) => Splash(),
        '/intro': (BuildContext context) => Intro(),
        '/login': (BuildContext context) => Login(),
        '/sign_up': (BuildContext context) => SignUp(),
        '/find_pw': (BuildContext context) => FindPw(),
        '/home': (BuildContext context) => HomeTab(),
        '/ledgers': (BuildContext context) => Ledgers(),
        '/ledger_add': (BuildContext context) => LedgerAdd(),
        '/terms': (BuildContext context) => Terms(),
        '/profile_my': (BuildContext context) => ProfileMy(),
        '/setting': (BuildContext context) => Setting(),
        '/setting_announcement': (BuildContext context) => SettingAnnouncement(),
        '/setting_faq': (BuildContext context) => SettingFAQ(),
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
