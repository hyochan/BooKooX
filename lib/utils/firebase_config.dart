import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreConfig {
  static final rootDoc =
      FirebaseFirestore.instance.collection('wecount').doc('app');

  static final ledgerColRef = FirebaseFirestore.instance
      .collection('wecount')
      .doc('app')
      .collection('ledgers');

  static final userColRef = FirebaseFirestore.instance
      .collection('wecount')
      .doc('app')
      .collection('users');

  static final ledgerItemsColRef = FirebaseFirestore.instance
      .collection('wecount')
      .doc('app')
      .collection('ledgerItems');

  FirestoreConfig._();
}
