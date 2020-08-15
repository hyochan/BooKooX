import 'package:bookoox/models/Ledger.dart';
import 'package:flutter/material.dart';

class CurrentLedger with ChangeNotifier {
  Ledger _ledger;
  String _title;

  Ledger getLedger() => _ledger;
  String getTitle() => _title;

  CurrentLedger(Ledger ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }
  }

  void setLedger(Ledger ledger) {
    _ledger = ledger;

    if (ledger != null) {
      _title = ledger.title;
    }
    notifyListeners();
  }
}
