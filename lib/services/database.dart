import 'dart:io';

import 'package:bookoox/models/Currency.dart';
import 'package:bookoox/models/User.dart';
import 'package:bookoox/services/storage.dart';
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
      new User(uid: user.uid),
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
        .document(ref.documentID)
        .setData({
      'id': ref.documentID,
    });

    return true;
  }

  Future<bool> requestUpdateLedger(Ledger ledger) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      print('user is not signined in');
      return false;
    }

    await Firestore.instance.collection('ledgers').document(ledger.id).setData({
      'title': ledger.title,
      'color': ledger.color.index,
      'description': ledger.description,
      'currency': ledger.currency.currency,
      'currencyLocale': ledger.currency.locale,
      'currencySymbol': ledger.currency.symbol,
    }, merge: true);

    return true;
  }

  Future<void> requestSelectLedger(String _ledgerId) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return Firestore.instance.collection('users').document(user.uid).setData({
      'selectedLedger': _ledgerId,
    }, merge: true);
  }

  Future<bool> requestUpdateProfile(
    User _profile, {
    File imgFile,
  }) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    UserUpdateInfo info = UserUpdateInfo();

    if (user == null) {
      print('user is not signined in');
      return false;
    }

    if (imgFile != null) {
      _profile.thumbURL = await FireStorageService.instance.uploadImage(
        file: imgFile,
        uploadDir: 'profile',
        imgStr: '${_profile.uid}_thumb',
        metaData: 'profile_thumb',
        compressed: true,
      );

      _profile.photoURL = await FireStorageService.instance.uploadImage(
        file: imgFile,
        uploadDir: 'profile',
        imgStr: '${_profile.uid}',
        metaData: 'profile',
      );

      info.photoUrl = _profile.thumbURL;

      await Firestore.instance
          .collection('users')
          .document(_profile.uid)
          .setData({
        'photoURL': _profile.photoURL,
        'thumbURL': _profile.thumbURL,
      }, merge: true);
    }

    info.displayName = _profile.displayName;
    user.updateProfile(info);

    await Firestore.instance
        .collection('users')
        .document(_profile.uid)
        .setData({
      'displayName': _profile.displayName,
      'phoneNumber': _profile.phoneNumber,
      'statusMsg': _profile.statusMsg,
    }, merge: true);

    return true;
  }

  Stream<FirebaseUser> streamFirebaseUser() {
    return FirebaseAuth.instance.currentUser().asStream();
  }

  Stream<List<Ledger>> streamLedgersWithMembership(FirebaseUser user) {
    var ref =
        _db.collection('ledgers').where('members', arrayContains: user.uid);

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

  Stream<User> streamUser(String id) {
    return _db
        .collection('users')
        .document(id)
        .snapshots()
        .map((snap) => User.fromMap(snap.data, id));
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

  Future<DocumentSnapshot> fetchMe(FirebaseUser user) {
    return _db.collection('users').document(user.uid).get();
  }

  Future<Ledger> fetchSelectedLedger() async {
    var user = await FirebaseAuth.instance.currentUser();
    var me = await DatabaseService().fetchMe(user);
    var selectedLedger = me['selectedLedger'];

    if (selectedLedger == null) {
      var ledgers = await _db
          .collection('users')
          .document(user.uid)
          .collection('ledgers')
          .getDocuments();

      var firstLedgerId = ledgers.documents[0].data['id'];
      var ledger = await streamLedger(firstLedgerId).first;

      return ledger;
    }

    var ledger = await streamLedger(selectedLedger).first;
    return ledger;
  }
}
