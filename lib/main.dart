import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations,
        GlobalCupertinoLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'package:wecount/generated/l10n.dart' show S;
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/utils/constants.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/utils/themes.dart';

import './utils/localization.dart';

void main() async {
  await _initFire();
  runApp(const MyApp());
  _fcmListeners();
}

Future<void> _initFire() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await FlutterConfig.loadEnvVariables();
  }
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
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
        theme: Themes.light,
        darkTheme: Themes.dark,
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          if (locale == null) {
            debugPrint('*language locale is null!!!');
            return supportedLocales.first;
          }
          for (final Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ko', 'KR'),
        ],
        initialRoute: AppRoute.authSwitch.fullPath,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        title: appName,
      ),
    );
  }
}
