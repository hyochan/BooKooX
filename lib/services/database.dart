import 'package:bookoox/models/Currency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:bookoox/models/Ledger.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<Ledger> streamLedger(String id) {
    return _db
      .collection('ledgers')
      .document(id)
      .snapshots()
      .map((snap) => Ledger.fromMap(snap.data));
  }

  Stream<List<Ledger>> streamMyLedgers(FirebaseUser user) {
    var ref = _db.collection('users').document(user.uid).collection('ledgers');

    return ref.snapshots().map((list) =>
      list.documents.map((doc) => Ledger.fromFirestore(doc)).toList());
  }

  Future<void> createLedger(Ledger ledger) {
    return _db.collection('ledgers').add({
      'title': ledger.title,
      'color': ledger.color,
      'currency': ledger.currency.currency,
      'currencyCode': ledger.currency.code,
    });
  }
}