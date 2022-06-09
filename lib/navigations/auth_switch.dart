import 'package:bookoox/models/Ledger.dart';
import 'package:bookoox/providers/CurrentLedger.dart';
import 'package:bookoox/services/database.dart';
import 'package:bookoox/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:bookoox/screens/tutorial.dart' show Tutorial;
import 'package:bookoox/navigations/home_tab.dart' show HomeTab;
import 'package:bookoox/screens/main_empty.dart' show MainEmpty;

class AuthSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _db = DatabaseService();
    var user = Provider.of<User>(context);

    Widget renderMainLedger() {
      return StreamProvider<List<Ledger>>.value(
        value: _db.streamMyLedgers(user),
        initialData: [],
        child: Consumer<List<Ledger>>(
          builder: (context, ledgers, child) {
            return FutureBuilder(
              future: DatabaseService().fetchSelectedLedger(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (ledgers == null || ledgers.length == 0) {
                    return MainEmpty();
                  }
                  if (snapshot.hasData) {
                    Provider.of<CurrentLedger>(context, listen: false)
                        .setLedger(snapshot.data);
                  }
                  return HomeTab();
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: Localization.of(context).trans('LOADING'),
                      backgroundColor: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    if (user != null && user.emailVerified) {
      return renderMainLedger();
    }

    return Tutorial();
  }
}
