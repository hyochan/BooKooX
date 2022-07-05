import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecount/generated/l10n.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/line_graph.dart';
import 'package:wecount/screens/tutorial.dart';
import 'package:wecount/utils/constants.dart';
import 'package:wecount/utils/firebase_config.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/themes.dart';

import './navigations/auth_switch.dart' show AuthSwitch;
import './navigations/home_tab.dart' show HomeTab;
import './screens/find_pw.dart' show FindPw;
import './screens/intro.dart' show Intro;
import './screens/ledger_edit.dart' show LedgerEdit;
import './screens/ledger_item_edit.dart' show LedgerItemEdit;
import './screens/ledger_view.dart' show LedgerView;
import './screens/ledgers.dart' show Ledgers;
import './screens/lock_auth.dart' show LockAuth;
import './screens/lock_register.dart' show LockRegister;
import './screens/main_empty.dart' show MainEmpty;
import './screens/profile_my.dart' show ProfileMy;
import './screens/setting.dart' show Setting;
import './screens/setting_announcement.dart' show SettingAnnouncement;
import './screens/setting_currency.dart' show SettingCurrency;
import './screens/setting_excel.dart' show SettingExcel;
import './screens/setting_faq.dart' show SettingFAQ;
import './screens/setting_notification.dart' show SettingNotification;
import './screens/setting_opinion.dart' show SettingOpinion;
import './screens/sign_in.dart' show SignIn;
import './screens/sign_up.dart' show SignUp;
import './screens/splash.dart' show Splash;
import './screens/terms.dart' show Terms;
import './screens/tutorial.dart' show Tutorial;

void main() async {
  await _initFire();
  runApp(const Wecount());
  _fcmListeners();
}

Future<void> _initFire() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await FirebaseConfig.initializeApp();
}

void _checkIOSPermission() {
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    sound: true,
  );
}

void _fcmListeners() {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  if (Platform.isIOS) _checkIOSPermission();

  FirebaseMessaging.instance.getToken().then((String? token) async {
    assert(token != null);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('pushToken', token!);

    logger.d('token: $token');
  });
}

Locale _setupLocale(
  Locale? locale,
  Iterable<Locale> supportedLocales,
) {
  if (locale == null) {
    return supportedLocales.first;
  }

  for (Locale supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode ||
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.first;
}

class Wecount extends StatelessWidget {
  static const supportedLocales = ['en', 'ko'];

  const Wecount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentLedger(null),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.system,
        routes: {
          AuthSwitch.name: (BuildContext context) => const AuthSwitch(),
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
          LedgerView.name: (BuildContext context) => const LedgerView(),
          Terms.name: (BuildContext context) => const Terms(),
          ProfileMy.name: (BuildContext context) => const ProfileMy(),
          Setting.name: (BuildContext context) => const Setting(),
          SettingAnnouncement.name: (BuildContext context) =>
              const SettingAnnouncement(),
          SettingOpinion.name: (BuildContext context) => const SettingOpinion(),
          SettingFAQ.name: (BuildContext context) => const SettingFAQ(),
          SettingNotification.name: (BuildContext context) =>
              const SettingNotification(),
          LedgerItemEdit.name: (BuildContext context) => const LedgerItemEdit(),
          SettingCurrency.name: (BuildContext context) =>
              const SettingCurrency(),
          SettingExcel.name: (BuildContext context) => const SettingExcel(),
          LockRegister.name: (BuildContext context) => const LockRegister(),
          LockAuth.name: (BuildContext context) => const LockAuth(),
          LineGraph.name: (BuildContext context) => const LineGraph(),
        },
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ko', 'KR'),
        ],
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: _setupLocale,
        title: appName,
        home: const AuthSwitch(),
      ),
    );
  }
}
