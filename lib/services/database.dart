import 'package:bookoox/models/Currency.dart';
import 'package:bookoox/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:bookoox/models/Ledger.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Future<bool> requestCreateNewLedger(Ledger ledger) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      print('user is not signined in');
      return false;
    }

    ledger.ownerId = user.uid;
    ledger.adminIds = [];

    ledger.members = [
      new User(
        uid: user.uid
      ),
    ];

    DocumentReference ref = await Firestore.instance.collection('ledgers').add({
      'title': ledger.title,
      'color': ledger.color.index,
      'description': ledger.description,
      'ownerId': ledger.ownerId,
      'adminIds': FieldValue.arrayUnion(ledger.adminIds),
      'currency': ledger.currency.currency,
      'currencyLocale': ledger.currency.locale,
      'currencySymbol': ledger.currency.symbol,
      'members': FieldValue.arrayUnion(
        ledger.members.map((el) => el.uid).toList(),
      ),
    });

    await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('ledgers')
      .document(ref.documentID).setData({
        'id': ref.documentID,
      });

    return true;
  }

  Stream<FirebaseUser> streamFirebaseUser() {
    return FirebaseAuth.instance.currentUser().asStream();
  }

  Stream<List<Ledger>> streamLedgersWithMembership(FirebaseUser user) {
    var ref = _db.collection('ledgers').where('members', arrayContains: user.uid);

    return ref.snapshots().map((list) =>
      list.documents.map((doc) => Ledger.fromFirestore(doc)).toList());
  }


  Stream<Ledger> streamLedger(String id) {
    return _db
      .collection('ledgers')
      .document(id)
      .snapshots()
      .map((snap) => Ledger.fromMap(snap.data));
  }

  /// Used from [auth_switch] to detect the initial widget.
  Stream<List<Ledger>> streamMyLedgers(FirebaseUser user) {
    var ref = _db.collection('users').document(user.uid).collection('ledgers');

    return ref.snapshots().map((list) =>
      list.documents.map((doc) => Ledger.fromFirestore(doc)).toList());
  }

  Future<void> createLedger(Ledger ledger) {
    return _db.collection('ledgers').add({
      'title': ledger.title,
      'color': ledger.color,
      'currency': ledger.currency.locale,
      'currencyCode': ledger.currency.currency,
    });
  }
}