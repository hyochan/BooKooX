import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/navigations/home_tab.dart' show HomeTab;
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/main_empty.dart' show MainEmpty;
import 'package:wecount/screens/tutorial.dart' show Tutorial;
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/localization.dart';

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    var user = Provider.of<User?>(context);

    Widget renderMainLedger() {
      return StreamProvider<List<LedgerModel>>.value(
        value: db.streamMyLedgers(user!),
        initialData: const [],
        child: Consumer<List<LedgerModel>>(
          builder: (context, ledgers, child) {
            return FutureBuilder(
              future: DatabaseService().fetchSelectedLedger(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (ledgers.isEmpty) {
                    return const MainEmpty();
                  }
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Provider.of<CurrentLedger>(context, listen: false)
                          .setLedger(snapshot.data as LedgerModel);
                    });
                  }

                  return const HomeTab();
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: localization(context).loading,
                      backgroundColor: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
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

    return const Tutorial();
  }
}
