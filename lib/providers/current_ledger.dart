import 'package:wecount/models/ledger_model.dart';
import 'package:flutter/material.dart';

class CurrentLedger with ChangeNotifier {
  LedgerModel? _ledger;
  String? _title;

  LedgerModel? getLedger() => _ledger;
  String? getTitle() => _title;

  CurrentLedger(LedgerModel? ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }
  }

  void setLedger(LedgerModel? ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }
    notifyListeners();
  }
}
