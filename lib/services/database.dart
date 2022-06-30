import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/models/user.dart' as model;
import 'package:wecount/services/storage.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/logger.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> requestCreateNewLedger(Ledger? ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logger.d('user is not sign-in');
      return false;
    }

    ledger!.ownerId = user.uid;
    ledger.adminIds = [];

    ledger.members = [
      model.User(uid: user.uid),
    ];

    DocumentReference ref =
        await FirebaseFirestore.instance.collection('ledgers').add({
      'title': ledger.title,
      'color': ledger.color.index,
      'description': ledger.description,
      'ownerId': ledger.ownerId,
      'adminIds': FieldValue.arrayUnion(ledger.adminIds),
      'currency': ledger.currency.currency,
      'currencyLocale': ledger.currency.locale,
      'currencySymbol': ledger.currency.symbol,
      'members': FieldValue.arrayUnion(
        ledger.members!.map((el) => el.uid).toList(),
      ),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('ledgers')
        .doc(ref.id)
        .set({
      'id': ref.id,
    });

    return true;
  }

  Future<bool> requestUpdateLedger(Ledger? ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logger.d('user is not sign-in');
      return false;
    }

    await FirebaseFirestore.instance.collection('ledgers').doc(ledger!.id).set({
      'title': ledger.title,
      'color': ledger.color.index,
      'description': ledger.description,
      'currency': ledger.currency.currency,
      'currencyLocale': ledger.currency.locale,
      'currencySymbol': ledger.currency.symbol,
    }, SetOptions(merge: true));

    return true;
  }

  Future<void> requestSelectLedger(String? ledgerId) async {
    User user = FirebaseAuth.instance.currentUser!;

    return FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'selectedLedger': ledgerId,
    }, SetOptions(merge: true));
  }

  Future<Ledger> _getLedger(String? ledgerId) async {
    var snap = await _db.collection('ledgers').doc(ledgerId).get();

    return Ledger.fromMap(snap.data());
  }

  Future<bool> requestLeaveLedger(String? ledgerId) async {
    User? user = FirebaseAuth.instance.currentUser;
    Ledger ledger = await _getLedger(ledgerId);

    bool hasOwnerPermission = user != null && ledger.ownerId == user.uid;
    bool hasMoreThanOneUser = ledger.memberIds.length > 1;

    if (hasOwnerPermission && !hasMoreThanOneUser) {
      await _deleteLedgerItems(ledgerId);
      await _deleteLedger(ledgerId);
      await _deleteLedgerFromUser(ledgerId, user);
      return true;
    }

    if (!hasOwnerPermission) {
      await _deleteLedgerFromUser(ledgerId, user!);
      return true;
    }

    return false;
  }

  Future<void> _deleteLedgerItems(String? ledgerId) async {
    var snapItems =
        await _db.collection('ledgers').doc(ledgerId).collection('items').get();
    for (DocumentSnapshot doc in snapItems.docs) {
      doc.reference.delete();
    }
  }

  Future<void> _deleteLedger(String? ledgerId) =>
      _db.collection('ledgers').doc(ledgerId).delete();

  Future<void> _deleteLedgerFromUser(String? ledgerId, User user) => _db
      .collection('users')
      .doc(user.uid)
      .collection('ledgers')
      .doc(ledgerId)
      .delete();

  Future<bool> requestUpdateProfile(
    model.User? profile, {
    XFile? imgFile,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logger.d('user is not sign-in');

      return false;
    }

    if (imgFile != null) {
      profile!.thumbURL = await FireStorageService.instance.uploadImage(
        file: File(imgFile.path),
        uploadDir: 'profile',
        imgStr: '${profile.uid}_thumb',
        metaData: 'profile_thumb',
        compressed: true,
      );

      profile.photoURL = await FireStorageService.instance.uploadImage(
        file: File(imgFile.path),
        uploadDir: 'profile',
        imgStr: '${profile.uid}',
        metaData: 'profile',
      );

      user.updatePhotoURL(profile.thumbURL);
      user.updateDisplayName(profile.displayName);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(profile.uid)
          .set({
        'photoURL': profile.photoURL,
        'thumbURL': profile.thumbURL,
      }, SetOptions(merge: true));
    }

    await FirebaseFirestore.instance.collection('users').doc(profile!.uid).set({
      'displayName': profile.displayName,
      'phoneNumber': profile.phoneNumber,
      'statusMsg': profile.statusMsg,
    }, SetOptions(merge: true));

    return true;
  }

  Stream<List<Ledger>> streamLedgersWithMembership(User user) {
    var ref =
        _db.collection('ledgers').where('members', arrayContains: user.uid);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Ledger.fromFirestore(doc)).toList());
  }

  Stream<Ledger> streamLedger(String? id) {
    return _db
        .collection('ledgers')
        .doc(id)
        .snapshots()
        .map((snap) => Ledger.fromMap(snap.data()));
  }

  Stream<model.User> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => model.User.fromMap(snap.data(), id));
  }

  /// Used from [auth_switch] to detect the initial widget.
  Stream<List<Ledger>> streamMyLedgers(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('ledgers');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Ledger.fromFirestore(doc)).toList());
  }

  Future<void> createLedger(Ledger ledger) {
    return _db.collection('ledgers').add({
      'title': ledger.title,
      'color': ledger.color,
      'currency': ledger.currency.locale,
      'currencyCode': ledger.currency.currency,
    });
  }

  Future<DocumentSnapshot> fetchMe(User user) {
    return _db.collection('users').doc(user.uid).get();
  }

  Future<Ledger?> fetchSelectedLedger() async {
    User? user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot me = await DatabaseService().fetchMe(user);

    if (DBHelper.instance.isExistFiled(me, 'selectedLedger')) {
      var ledgers = await _db
          .collection('users')
          .doc(user.uid)
          .collection('ledgers')
          .get();

      var firstLedgerId = ledgers.docs[0].data()['id'];
      var ledger = await streamLedger(firstLedgerId).first;

      return ledger;
    }

    return null;
  }
}
