import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/models/user.dart' as m;
import 'package:wecount/navigations/auth_switch.dart';
import 'package:wecount/services/storage.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/logger.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference<m.User> _userRef =
      FirebaseFirestore.instance.collection('users').withConverter<m.User>(
            fromFirestore: (snapshot, _) => m.User.fromJson(
              snapshot.data(),
              snapshot.id,
            ),
            toFirestore: (user, _) => user.toJson(),
          );
  get _currentUser => FirebaseAuth.instance.currentUser;

  Future<bool> requestCreateNewLedger(Ledger ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

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
      'memberIds': ledger.memberIds,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('ledgers')
        .doc(ref.id)
        .set({
      'id': ref.id,
    });

    return true;
  }

  Future<bool> requestUpdateLedger(Ledger? ledger) async {
    if (_currentUser == null) {
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
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .set({
      'selectedLedger': ledgerId,
    }, SetOptions(merge: true));
  }

  Future<Ledger> _getLedger(String? ledgerId) async {
    var snap = await _db.collection('ledgers').doc(ledgerId).get();

    return Ledger.fromJson(snap.data());
  }

  Future<bool> requestLeaveLedger(String? ledgerId) async {
    Ledger ledger = await _getLedger(ledgerId);

    bool hasOwnerPermission =
        _currentUser != null && ledger.ownerId == _currentUser.uid;
    bool hasMoreThanOneUser = ledger.memberIds.length > 1;

    if (hasOwnerPermission && !hasMoreThanOneUser) {
      await _deleteLedgerItems(ledgerId);
      await _deleteLedger(ledgerId);
      await _deleteLedgerFromUser(ledgerId);

      return true;
    }

    if (!hasOwnerPermission) {
      await _deleteLedgerFromUser(ledgerId);

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

  Future<void> _deleteLedgerFromUser(String? ledgerId) => _db
      .collection('users')
      .doc(_currentUser.uid)
      .collection('ledgers')
      .doc(ledgerId)
      .delete();

  Future<bool> requestUpdateProfile(
    m.User? profile, {
    XFile? imgFile,
  }) async {
    if (_currentUser == null) {
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

      _currentUser.updatePhotoURL(profile.thumbURL);
      _currentUser.updateDisplayName(profile.displayName);

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

  Stream<List<Ledger>> streamLedgersWithMembership() {
    var ref = _db
        .collection('ledgers')
        .where('memberIds', arrayContains: _currentUser.uid);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Ledger.fromFirestore(doc)).toList());
  }

  Stream<Ledger?> streamLedger(String? id) {
    return _db
        .collection('ledgers')
        .doc(id)
        .snapshots()
        .map((snap) => Ledger.fromJson(snap.data()));
  }

  Stream<m.User> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => m.User.fromJson(snap.data(), id));
  }

  Future<void> createLedger(Ledger ledger) {
    return _db.collection('ledgers').add({
      'title': ledger.title,
      'color': ledger.color,
      'currency': ledger.currency.locale,
      'currencyCode': ledger.currency.currency,
    });
  }

  Future<void> createUser(User user, String? googleIdToken) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'id': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'name': user.displayName,
      'googleIdToken': googleIdToken,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'deletedAt': null,
    });
  }

  Future<DocumentSnapshot?> fetchMe() async {
    DocumentSnapshot me =
        await _db.collection('users').doc(_currentUser.uid).get();

    if (!me.exists) {
      await FirebaseAuth.instance.signOut();

      return Get.offAll(() => const AuthSwitch());
    }

    return me;
  }

  Future<Ledger?> fetchSelectedLedger() async {
    DocumentSnapshot? me = await DatabaseService().fetchMe();

    if (me != null) {
      if (DBHelper.instance.isExistFiled(me, 'selectedLedger')) {
        return await streamLedger(me['selectedLedger']).first;
      }

      var ledgers = await _db
          .collection('users')
          .doc(_currentUser.uid)
          .collection('ledgers')
          .get();

      if (ledgers.size != 0) {
        String firstLedgerId = ledgers.docs[0].data()['id'];
        var ledger = await streamLedger(firstLedgerId).first;

        return ledger;
      }
    }

    return null;
  }

  List<m.User> _removeMe(List<m.User> users) {
    List<m.User> copyUsers = [...users];
    copyUsers.removeWhere((user) => user.uid == _currentUser.uid);

    return copyUsers;
  }

  Future<List<m.User>> searchUsers(String query) async {
    List<QuerySnapshot> res = await Future.wait([
      _userRef
          .orderBy("displayName")
          .startAt([query]).endAt(["$query\uf8ff"]).get(),
      _userRef.orderBy("email").startAt([query]).endAt(["$query\uf8ff"]).get(),
    ]);

    var docs = [...res[0].docs, ...res[1].docs];
    List<m.User> users = docs.map((doc) => doc.data() as m.User).toList();

    return _removeMe(users);
  }
}
