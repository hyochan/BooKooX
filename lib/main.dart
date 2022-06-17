import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecount/firebase_options.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/line_graph.dart';
import 'package:wecount/screens/tutorial.dart';

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
import './utils/asset.dart' as Asset;
import './utils/localization.dart';

void main() async {
  await _initFire();
  runApp(MyApp());
  _fcmListeners();
}

Future<void> _initFire() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void checkIOSPermission() {
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

  if (Platform.isIOS) checkIOSPermission();

  FirebaseMessaging.instance.getToken().then((String? token) async {
    assert(token != null);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('pushToken', token!);
    print('token: $token');
  });
}

class MyApp extends StatelessWidget {
  static const supportedLocales = ['en', 'ko'];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User?>.value(
            value: FirebaseAuth.instance.authStateChanges(),
            initialData: null,
          ),
          ChangeNotifierProvider(create: (context) => CurrentLedger(null)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            hintColor: Asset.Colors.mediumGray,
            primaryColor: Asset.Colors.main,
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
              headline3: TextStyle(color: Asset.Colors.paleGray),
              caption: TextStyle(color: Asset.Colors.light),
            ),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Asset.Colors.greenBlue),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: Asset.Colors.greenBlue,
            hintColor: Asset.Colors.warmGray,
            primaryColor: Asset.Colors.main,
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
              headline3: TextStyle(color: Asset.Colors.mediumGray),
              caption: TextStyle(color: Asset.Colors.dark),
            ),
          ),
          routes: {
            AuthSwitch.name: (BuildContext context) => AuthSwitch(),
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
            LedgerView.name: (BuildContext context) => LedgerView(),
            Terms.name: (BuildContext context) => Terms(),
            ProfileMy.name: (BuildContext context) => ProfileMy(),
            Setting.name: (BuildContext context) => Setting(),
            SettingAnnouncement.name: (BuildContext context) =>
                SettingAnnouncement(),
            SettingOpinion.name: (BuildContext context) => SettingOpinion(),
            SettingFAQ.name: (BuildContext context) => SettingFAQ(),
            SettingNotification.name: (BuildContext context) =>
                SettingNotification(),
            LedgerItemEdit.name: (BuildContext context) => LedgerItemEdit(),
            SettingCurrency.name: (BuildContext context) => SettingCurrency(),
            SettingExcel.name: (BuildContext context) => SettingExcel(),
            LockRegister.name: (BuildContext context) => LockRegister(),
            LockAuth.name: (BuildContext context) => LockAuth(),
            LineGraph.name: (BuildContext context) => LineGraph(),
          },
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('ko', 'KR'),
          ],
          localizationsDelegates: [
            const LocalizationDelegate(supportedLocales: ['en', 'ko']),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
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
          title: 'WeCount',
          home: AuthSwitch(),
        ));
  }
}
