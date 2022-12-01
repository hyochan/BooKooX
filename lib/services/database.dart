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
import 'package:wecount/utils/logger.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> requestCreateNewLedger(Ledger? ledger) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('user is not sign-in');
      return false;
    }

    ledger =
        ledger!.copyWith(ownerId: user.uid, adminIds: [], members: [user.uid]);
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
        ledger.members!,
      ),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('ledgers')
        .doc(ref.id)
        .set(
          ledger.toJson()
            ..addAll(
              {'ref': ref, 'id': ref.id, 'currency': ledger.currency.toJson()},
            ),
        );

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

  Future<void> requestSelectLedger(String? ledgerId) async {
    User user = FirebaseAuth.instance.currentUser!;

    return FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'selectedLedger': ledgerId,
    }, SetOptions(merge: true));
  }

  Future<bool> requestLeaveLedger(String? ledgerId) async {
    User? user = FirebaseAuth.instance.currentUser;

    getLedger(String? ledgerId) async {
      var snap = await db.collection('ledgers').doc(ledgerId).get();
      return Ledger.fromMap(snap.data());
    }

    Ledger ledger = await getLedger(ledgerId);

    bool hasOwnerPermission = user != null && ledger.ownerId == user.uid;
    bool hasMoreThanOneUser = ledger.memberIds.length > 1;

    deleteLedgerItem(String? ledgerId) async {
      var snapItems = await db
          .collection('ledgers')
          .doc(ledgerId)
          .collection('items')
          .get();
      for (DocumentSnapshot doc in snapItems.docs) {
        doc.reference.delete();
      }
    }

    deleteLedger(String? ledgerId) =>
        db.collection('ledgers').doc(ledgerId).delete();

    deleteLedgerFromUser(String? ledgerId) => db
        .collection('users')
        .doc(user!.uid)
        .collection('ledgers')
        .doc(ledgerId)
        .delete();

    if (hasOwnerPermission && !hasMoreThanOneUser) {
      await deleteLedgerItem(ledgerId);
      await deleteLedger(ledgerId);
      await deleteLedgerFromUser(ledgerId);
      return true;
    }

    if (!hasOwnerPermission) {
      await deleteLedgerFromUser(ledgerId);
      return true;
    }

    return false;
  }

  Future<bool> requestCreateLedgerItem(LedgerItem ledgerItem) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('user is not sign-in');
      return false;
    }

    var writer = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    DocumentReference ref = await FirebaseFirestore.instance
        .collection("ledgers")
        .doc(writer.data()!['selectedLedger'])
        .collection("ledgerItems")
        .add(
      {
        'price': ledgerItem.price,
        'category': {
          'id': ledgerItem.category?.id,
          'iconId': ledgerItem.category?.iconId,
          'label': ledgerItem.category?.label,
          'type': '${ledgerItem.category?.type}',
          'showDelete': ledgerItem.category?.showDelete,
        },
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

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('ledgers')
        .doc(writer.data()!['selectedLedger'])
        .collection("ledgerItems")
        .doc(ref.id)
        .set(
          ledgerItem.toJson()
            ..addAll(
              {
                'ref': ref,
                'writer': writer.data(),
                'createdAt': DateTime.now(),
                'category': ledgerItem.category?.toJson()
              },
            ),
        );

    return true;
  }

  Stream<List<LedgerItem>> streamGetMyLedgerItems(
      String userId, String selectedledger) {
    var ref = db
        .collection("users")
        .doc(userId)
        .collection('ledgers')
        .doc(selectedledger)
        .collection('ledgerItems');

    var query = ref.withConverter<LedgerItem>(
        fromFirestore: (snapshot, _) =>
            LedgerItem.fromJson(snapshot.data() ?? {}),
        toFirestore: (ledgerItem, _) => ledgerItem.toJson());

    return query
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  Future<List<LedgerItem>> getMyLedgerItmes({
    int size = 20,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('user is not sign-in');
      return [];
    }

    var writer = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    var userLedgerItemRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection('ledgers')
        .doc(writer.data()!['selectedLedger'])
        .collection("ledgerItems");

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
      print('user is not sign-in');
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

      await FirebaseFirestore.instance
          .collection('users')
          .doc(profile?.uid)
          .set({
        'photoURL': profile?.photoURL,
        'thumbURL': profile?.thumbURL,
      }, SetOptions(merge: true));
    }

    await FirebaseFirestore.instance.collection('users').doc(profile?.uid).set({
      'displayName': profile?.displayName,
      'phoneNumber': profile?.phoneNumber,
      'statusMsg': profile?.statusMsg,
    }, SetOptions(merge: true));

    return true;
  }

  Stream<List<Ledger>> streamLedgersWithMembership(User user) {
    var ref =
        db.collection('ledgers').where('members', arrayContains: user.uid);

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Ledger.fromFirestore(doc)).toList());
  }

  Stream<Ledger> streamLedger(String? id) {
    return db
        .collection('ledgers')
        .doc(id)
        .snapshots()
        .map((snap) => Ledger.fromMap(snap.data()));
  }

  Stream<UserModel> streamUser(String id) {
    return db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => UserModel.fromMap(snap.data(), id));
  }

  /// Used from [auth_switch] to detect the initial widget.
  Stream<List<Ledger>> streamMyLedgers(User user) {
    var ref = db.collection('users').doc(user.uid).collection('ledgers');

    var query = ref.withConverter<Ledger>(
        fromFirestore: (snapshot, _) => Ledger.fromJson(snapshot.data() ?? {}),
        toFirestore: (ledger, _) => ledger.toJson());

    return query
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()).toList());
  }

  Future<void> createLedger(Ledger ledger) {
    return db.collection('ledgers').add(
      {
        'title': ledger.title,
        'color': ledger.color,
        'currency': ledger.currency.locale,
        'currencyCode': ledger.currency.currency,
      },
    );
  }

  Future<DocumentSnapshot> fetchMe(User user) {
    return db.collection('users').doc(user.uid).get();
  }

  Future<Ledger?> fetchSelectedLedger() async {
    User? user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot me = await DatabaseService().fetchMe(user);

    if (DBHelper.instance.isExistFiled(me, 'selectedLedger')) {
      var ledgers = await db
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
