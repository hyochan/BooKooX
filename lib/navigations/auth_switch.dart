import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/navigations/home_tab.dart' show HomeTab;
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/main_empty.dart' show MainEmpty;
import 'package:wecount/screens/tutorial.dart' show Tutorial;
import 'package:wecount/services/database.dart';
import 'package:wecount/utils/localization.dart';

class AuthSwitch extends StatefulWidget {
  static const String name = '/auth_switch';

  const AuthSwitch({Key? key}) : super(key: key);

  @override
  State<AuthSwitch> createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {
  bool _isLedgerLoading = true;
  Ledger? _selectedLedger;
  User? _user;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _user = Provider.of<User?>(context);

    if (_user != null) {
      await _initLedger();
    }
  }

  Future<void> _initLedger() async {
    _selectedLedger = await DatabaseService().fetchSelectedLedger();

    if (_selectedLedger != null && mounted) {
      Provider.of<CurrentLedger>(context, listen: false).ledger =
          _selectedLedger;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _isLedgerLoading = false);
    });
  }

  Widget _renderLoadingIndicator() => Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            semanticsLabel: t('LOADING'),
            backgroundColor: Theme.of(context).primaryColor,
            strokeWidth: 2,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Tutorial();
    }

    if (_isLedgerLoading) {
      return _renderLoadingIndicator();
    }

    return Consumer<CurrentLedger>(
      builder: (_, currentLedger, __) {
        if (currentLedger.ledger == null) {
          return const MainEmpty();
        }

        return const HomeTab();
      },
    );
  }
}
