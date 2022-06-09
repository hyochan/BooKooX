import 'dart:io' show Platform;

import 'package:bookoox/providers/CurrentLedger.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:bookoox/screens/line_graph.dart';
import 'package:bookoox/screens/tutorial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './navigations/home_tab.dart' show HomeTab;
import './navigations/auth_switch.dart' show AuthSwitch;
import './screens/tutorial.dart' show Tutorial;
import './screens/splash.dart' show Splash;
import './screens/intro.dart' show Intro;
import './screens/sign_in.dart' show SignIn;
import './screens/sign_up.dart' show SignUp;
import './screens/find_pw.dart' show FindPw;
import './screens/main_empty.dart' show MainEmpty;
import './screens/terms.dart' show Terms;
import './screens/ledgers.dart' show Ledgers;
import './screens/ledger_edit.dart' show LedgerEdit;
import './screens/ledger_view.dart' show LedgerView;
import './screens/ledger_item_edit.dart' show LedgerItemEdit;
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

void main() async {
  await _initFire();
  runApp(MyApp());
  _fcmListeners();
}

Future<void> _initFire() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  await Firebase.initializeApp(
    name: 'BooKooX',
    options: FirebaseOptions(
        apiKey: FlutterConfig.get('API_KEY'),
        databaseURL: FlutterConfig.get('DATABASE_URL'),
        projectId: FlutterConfig.get('PROJECT_ID'),
        iosBundleId: FlutterConfig.get('BUNDLE_ID'),
        storageBucket: FlutterConfig.get('STORAGE_BUCKET'),
        messagingSenderId: FlutterConfig.get('GCM_SENDER_ID'),
        appId: Platform.isIOS
            ? FlutterConfig.get('APP_ID_IOS')
            : Platform.isAndroid
                ? FlutterConfig.get('APP_ID_ANDROID')
                : FlutterConfig.get('APP_ID_WEB')),
  );
  // FirebaseFirestore(app: app);
  // FirebaseStorage(
  //   app: app,
  //   storageBucket: 'gs://bookoox-609bf.appspot.com',
  // );
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

  FirebaseMessaging.instance.getToken().then((String token) async {
    assert(token != null);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('pushToken', token);
    print('token: $token');
  });

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   if (notification != null && android != null && !kIsWeb) {
  //     flutterLocalNotificationsPlugin.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //           channel.description,
  //           // TODO add a proper drawable resource to android, for now using
  //           //      one that already exists in example app.
  //           icon: 'launch_background',
  //         ),
  //       ),
  //     );
  //   }
  // });
}

class MyApp extends StatelessWidget {
  static const supportedLocales = ['en', 'ko'];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges(),
            initialData: null,
          ),
          ChangeNotifierProvider(create: (context) => CurrentLedger(null)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            accentColor: Asset.Colors.greenBlue,
            hintColor: Asset.Colors.mediumGray,
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
              headline3: TextStyle(color: Asset.Colors.paleGray),
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
              headline3: TextStyle(color: Asset.Colors.mediumGray),
              caption: TextStyle(color: Asset.Colors.dark),
            ),
          ),
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
            '/ledger_item_add': (BuildContext context) => LedgerItemEdit(),
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
          home: AuthSwitch(),
        ));
  }
}
