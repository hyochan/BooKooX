import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:bookoox/screens/tutorial.dart' show Tutorial;
import 'package:bookoox/navigations/home_tab.dart' show HomeTab;
import 'package:bookoox/screens/main_empty.dart' show MainEmpty;

class AuthSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    Widget renderMainLedger() {
      return HomeTab();
    }

    Widget renderMainEmpty() {
      return MainEmpty();
    }

    if (user != null) {
      if (user.providerData.length == 1) {
        if (user.isEmailVerified) {
          return renderMainLedger();
        }

        return Tutorial();
      }

      return renderMainLedger();
    }

    return Tutorial();
  }
}