import 'package:wecount/models/ledger_model.dart';
import 'package:flutter/material.dart';

class CurrentLedger with ChangeNotifier {
  LedgerModel? _ledger;
  String? _title;

  CurrentLedger(LedgerModel? ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }
  }

  LedgerModel? get ledger => _ledger;
  String? get title => _title;

  set ledger(ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }

    notifyListeners();
  }
}
