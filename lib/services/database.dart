import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/models/user.dart' as UserM;
import 'package:wecount/services/storage.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/logger.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> requestCreateNewLedger(Ledger? ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('user is not sign-in');
      return false;
    }

    ledger!.ownerId = user.uid;
    ledger.adminIds = [];

    ledger.members = [
      UserM.User(uid: user.uid),
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
      print('user is not sign-in');
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

  Future<void> requestSelectLedger(String? _ledgerId) async {
    User user = FirebaseAuth.instance.currentUser!;

    return FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'selectedLedger': _ledgerId,
    }, SetOptions(merge: true));
  }

  Future<bool> requestLeaveLedger(String? _ledgerId) async {
    User? user = FirebaseAuth.instance.currentUser;

    var getLedger = (String? _ledgerId) async {
      var snap = await _db.collection('ledgers').doc(_ledgerId).get();
      return Ledger.fromMap(snap.data());
    };

    Ledger ledger = await getLedger(_ledgerId);

    bool hasOwnerPermission = user != null && ledger.ownerId == user.uid;
    bool hasMoreThanOneUser = ledger.memberIds.length > 1;

    var deleteLedgerItems = (String? _ledgerId) async {
      var snapItems = await _db
          .collection('ledgers')
          .doc(_ledgerId)
          .collection('items')
          .get();
      for (DocumentSnapshot doc in snapItems.docs) {
        doc.reference.delete();
      }
    };

    var deleteLedger = (String? _ledgerId) =>
        _db.collection('ledgers').doc(_ledgerId).delete();

    var deleteLedgerFromUser = (String? _ledgerId) => _db
        .collection('users')
        .doc(user!.uid)
        .collection('ledgers')
        .doc(_ledgerId)
        .delete();

    if (hasOwnerPermission && !hasMoreThanOneUser) {
      await deleteLedgerItems(_ledgerId);
      await deleteLedger(_ledgerId);
      await deleteLedgerFromUser(_ledgerId);
      return true;
    }

    if (!hasOwnerPermission) {
      await deleteLedgerFromUser(_ledgerId);
      return true;
    }

    return false;
  }

  Future<bool> requestUpdateProfile(
    UserM.User? _profile, {
    XFile? imgFile,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('user is not sign-in');
      return false;
    }

    if (imgFile != null) {
      _profile!.thumbURL = await FireStorageService.instance.uploadImage(
        file: File(imgFile.path),
        uploadDir: 'profile',
        imgStr: '${_profile.uid}_thumb',
        metaData: 'profile_thumb',
        compressed: true,
      );

      _profile.photoURL = await FireStorageService.instance.uploadImage(
        file: File(imgFile.path),
        uploadDir: 'profile',
        imgStr: '${_profile.uid}',
        metaData: 'profile',
      );

      user.updatePhotoURL(_profile.thumbURL);
      user.updateDisplayName(_profile.displayName);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_profile.uid)
          .set({
        'photoURL': _profile.photoURL,
        'thumbURL': _profile.thumbURL,
      }, SetOptions(merge: true));
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_profile!.uid)
        .set({
      'displayName': _profile.displayName,
      'phoneNumber': _profile.phoneNumber,
      'statusMsg': _profile.statusMsg,
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

  Stream<UserM.User> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => UserM.User.fromMap(snap.data(), id));
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
