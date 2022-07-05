import 'package:wecount/models/ledger.dart';
import 'package:flutter/material.dart';

class CurrentLedger with ChangeNotifier {
  Ledger? _ledger;
  String? _title;

  CurrentLedger(Ledger? ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }
  }

  Ledger? get ledger => _ledger;
  String? get title => _title;

  set ledger(ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }

    notifyListeners();
  }
}
