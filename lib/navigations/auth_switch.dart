import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bookoox/screens/splash.dart' show Splash;
import 'package:bookoox/screens/tutorial.dart' show Tutorial;
import 'package:bookoox/navigations/home_tab.dart' show HomeTab;

class AuthSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.providerData.length == 1) {
            return snapshot.data.isEmailVerified
                ? HomeTab()
                : Tutorial();
          }
          return HomeTab();
        }
        return Tutorial();
      },
    );
  }
}