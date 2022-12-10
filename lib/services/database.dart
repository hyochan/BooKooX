import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/services/storage.dart';
import 'package:wecount/utils/db_helper.dart';
import 'package:wecount/utils/firebase_config.dart';
import 'package:wecount/utils/logger.dart';

class DatabaseService {
  Future<String> requestCreateNewLedger(Ledger? ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logger.d('user is not sign-in');
      return '';
    }

    ledger = ledger!.copyWith(
        ownerId: user.uid,
        adminIds: [],
        members: [user.uid],
        createdAt: DateTime.now());

    DocumentReference ref = await FirestoreConfig.ledgerColRef.add(
      {
        'title': ledger.title,
        'color': ledger.color.index,
        'description': ledger.description,
        'ownerId': ledger.ownerId,
        'adminIds': FieldValue.arrayUnion(ledger.adminIds),
        'currency': ledger.currency.currency,
        'currencyLocale': ledger.currency.locale,
        'currencySymbol': ledger.currency.symbol,
        'createdAt': ledger.createdAt,
        'members': FieldValue.arrayUnion(
          ledger.members!,
        ),
      },
    );

    await FirestoreConfig.userColRef
        .doc(user.uid)
        .collection('ledgers')
        .doc(ref.id)
        .set(
          ledger.toJson()
            ..addAll(
              {'ref': ref, 'id': ref.id, 'currency': ledger.currency.toJson()},
            ),
        );

    await FirestoreConfig.userColRef.doc(user.uid).set({
      'selectedLedger': ref.id,
    }, SetOptions(merge: true));

    return ref.id;
  }

  Future<bool> requestUpdateLedger(Ledger? ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logger.d('user is not sign-in');
      return false;
    }

    await FirestoreConfig.ledgerColRef.doc(ledger!.id).set({
      'title': ledger.title,
      'color': ledger.color.index,
      'description': ledger.description,
      'currency': ledger.currency.currency,
      'currencyLocale': ledger.currency.locale,
      'currencySymbol': ledger.currency.symbol,
    }, SetOptions(merge: true));

    await FirestoreConfig.userColRef
        .doc(user.uid)
        .collection('ledgers')
        .doc(ledger.id)
        .set(
          ledger.toJson()
            ..addAll(
              {'id': ledger.id, 'currency': ledger.currency.toJson()},
            ),
        );

    return true;
  }

  Future<void> requestSelectLedger(String? ledgerId) async {
    User user = FirebaseAuth.instance.currentUser!;

    return FirestoreConfig.userColRef.doc(user.uid).set({
      'selectedLedger': ledgerId,
    }, SetOptions(merge: true));
  }

  Future<bool> requestLeaveLedger(String? ledgerId) async {
    User? user = FirebaseAuth.instance.currentUser;

    Future<Ledger> getLedger(String? ledgerId) async {
      var snap = await FirestoreConfig.ledgerColRef.doc(ledgerId).get();
      return Ledger.fromMap(snap.data());
    }

    Ledger ledger = await getLedger(ledgerId);

    bool hasOwnerPermission = user != null && ledger.ownerId == user.uid;

    Future<void> deleteLedgerItem(String? ledgerId) async {
      var snapItems = await FirestoreConfig.ledgerColRef
          .doc(ledgerId)
          .collection('ledgerItems')
          .get();
      for (final DocumentSnapshot doc in snapItems.docs) {
        doc.reference.delete();
      }
    }

    Future<void> deleteLedger(String? ledgerId) =>
        FirestoreConfig.ledgerColRef.doc(ledgerId).delete();

    Future<void> deleteLedgerFromUser(String? ledgerId) =>
        FirestoreConfig.userColRef
            .doc(user!.uid)
            .collection('ledgers')
            .doc(ledgerId)
            .delete();

    if (!hasOwnerPermission) {
      await deleteLedgerFromUser(ledgerId);
      return true;
    }

    await deleteLedgerItem(ledgerId);
    await deleteLedger(ledgerId);
    await deleteLedgerFromUser(ledgerId);
    return true;
  }

  Future<bool> requestCreateLedgerItem(LedgerItem ledgerItem) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      logger.d('user is not sign-in');
      return false;
    }

    var writer = await FirestoreConfig.userColRef.doc(user.uid).get();
    DocumentReference ref = await FirestoreConfig.ledgerColRef
        .doc(writer.data()!['selectedLedger'])
        .collection('ledgerItems')
        .add(
      {
        'price': ledgerItem.price,
        'category': ledgerItem.category?.toJson(),
        'memo': ledgerItem.memo,
        'writer': writer.data(),
        'selectedDate': ledgerItem.selectedDate,
        'picture': ledgerItem.picture,
        'latlng': ledgerItem.latlng,
        'address': ledgerItem.address,
        'createdAt': DateTime.now(),
        'updatedAt': ledgerItem.updatedAt,
        'deletedAt': ledgerItem.deletedAt,
      },
    );

    return true;
  }

  Stream<List<LedgerItem>> streamGetMyLedgerItems(
      String userId, String selectedLedger) {
    var ref = FirestoreConfig.userColRef
        .doc(userId)
        .collection('ledgers')
        .doc(selectedLedger)
        .collection('ledgerItems');

    var query = ref.withConverter<LedgerItem>(
        fromFirestore: (snapshot, _) =>
            LedgerItem.fromJson(snapshot.data() ?? {}),
        toFirestore: (ledgerItem, _) => ledgerItem.toJson());

    return query
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  Future<List<LedgerItem>> getMyLedgerItems({
    int size = 20,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      logger.d('user is not sign-in');
      return [];
    }

    var writer = await FirestoreConfig.userColRef.doc(user.uid).get();

    var userLedgerItemRef = FirestoreConfig.userColRef
        .doc(user.uid)
        .collection('ledgers')
        .doc(writer.data()!['selectedLedger'])
        .collection('ledgerItems');

    var query = userLedgerItemRef
        .withConverter<LedgerItem>(
            fromFirestore: (snapshot, _) =>
                LedgerItem.fromJson(snapshot.data() ?? {}),
            toFirestore: (ledger, _) => ledger.toJson())
        .limit(size);

    var snap = await query.get();

    if (snap.docs.isEmpty) {
      return [];
    }

    return snap.docs.map((e) => e.data()).toList();
  }

  Future<bool> requestUpdateProfile(
    UserModel? profile, {
    XFile? imgFile,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logger.d('user is not sign-in');
      return false;
    }

    if (imgFile != null) {
      profile = profile?.copyWith(
          thumbURL: await FireStorageService.instance.uploadImage(
        file: File(imgFile.path),
        uploadDir: 'profile',
        imgStr: '${profile.uid}_thumb',
        metaData: 'profile_thumb',
        compressed: true,
      ));

      profile = profile?.copyWith(
          photoURL: await FireStorageService.instance.uploadImage(
        file: File(imgFile.path),
        uploadDir: 'profile',
        imgStr: '${profile.uid}',
        metaData: 'profile',
      ));

      user.updatePhotoURL(profile?.thumbURL);
      user.updateDisplayName(profile?.displayName);

      await FirestoreConfig.userColRef.doc(profile?.uid).set({
        'photoURL': profile?.photoURL,
        'thumbURL': profile?.thumbURL,
      }, SetOptions(merge: true));
    }

    await FirestoreConfig.userColRef.doc(profile?.uid).set({
      'displayName': profile?.displayName,
      'phoneNumber': profile?.phoneNumber,
      'statusMsg': profile?.statusMsg,
    }, SetOptions(merge: true));

    return true;
  }

  Stream<Ledger> streamLedger(String? id) {
    return FirestoreConfig.ledgerColRef
        .doc(id)
        .snapshots()
        .map((snap) => Ledger.fromMap(snap.data()));
  }

  Stream<UserModel> streamUser(String id) {
    return FirestoreConfig.userColRef
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(snap.data(), id));
  }

  /// Used from `auth_switch.dart` to detect the initial widget.
  Stream<List<Ledger>> streamMyLedgers(User user) {
    var ref = FirestoreConfig.userColRef.doc(user.uid).collection('ledgers');

    var query = ref.withConverter<Ledger>(
        fromFirestore: (snapshot, _) => Ledger.fromJson(snapshot.data() ?? {}),
        toFirestore: (ledger, _) => ledger.toJson());

    return query
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  Future<void> createLedger(Ledger ledger) {
    return FirestoreConfig.ledgerColRef.add(
      {
        'title': ledger.title,
        'color': ledger.color,
        'currency': ledger.currency.locale,
        'currencyCode': ledger.currency.currency,
      },
    );
  }

  Future<DocumentSnapshot> fetchMe(User user) {
    return FirestoreConfig.userColRef.doc(user.uid).get();
  }

  Future<Ledger?> fetchSelectedLedger() async {
    User? user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot me = await DatabaseService().fetchMe(user);

    if (DBHelper.instance.isExistFiled(me, 'selectedLedger')) {
      var ledgers = await FirestoreConfig.userColRef
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
