import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/models/ledger_model.dart';
import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/models/photo_model.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/firebase_config.dart';

abstract class ILedgerRepository {
  Future<List<LedgerItemModel>?> getLedgerItems();
  Future<List<LedgerModel>> getLedgersWithMembership(User user);
}

class LedgerRepository implements ILedgerRepository {
  static final LedgerRepository instance = LedgerRepository();

  @override
  Future<List<LedgerItemModel>?> getLedgerItems() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    var userSnap = await FirestoreConfig.userColRef.doc(user.uid).get();

    if (!userSnap.exists) return null;

    var selectedLedger = userSnap.data()!['selectedLedger'];

    var ref = FirestoreConfig.ledgerColRef
        .doc(selectedLedger)
        .collection('ledgerItems');

    var query = ref
        .withConverter<LedgerItemModel>(
            fromFirestore: (snapshot, _) =>
                LedgerItemModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (ledgerItem, _) => ledgerItem.toJson())
        .orderBy('selectedDate', descending: false);

    var snap = await query.get();
    return snap.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<LedgerModel>> getLedgersWithMembership(User user) async {
    var ref = FirestoreConfig.ledgerColRef
        .where('members', arrayContains: user.uid)
        .orderBy('createdAt', descending: false);

    var query = ref.withConverter<LedgerModel>(
        fromFirestore: (snapshot, _) => LedgerModel.fromFirestore(snapshot),
        toFirestore: (ledger, _) => ledger.toJson());

    var snap = await query.get();

    return snap.docs.map((e) => e.data()).toList();
  }
}
