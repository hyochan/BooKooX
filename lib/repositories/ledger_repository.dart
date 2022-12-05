import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/photo.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/firebase_config.dart';

abstract class ILedgerRepository {
  Future<List<LedgerItem>?> getLedgerItems();
  Future<List<Ledger>> getLedgersWithMembership(User user);
}

class LedgerRepository implements ILedgerRepository {
  static final LedgerRepository instance = LedgerRepository();

  @override
  Future<List<LedgerItem>?> getLedgerItems() async {
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
        .withConverter<LedgerItem>(
            fromFirestore: (snapshot, _) =>
                LedgerItem.fromJson(snapshot.data() ?? {}),
            toFirestore: (ledgerItem, _) => ledgerItem.toJson())
        .orderBy('selectedDate', descending: false);

    var snap = await query.get();
    return snap.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<Ledger>> getLedgersWithMembership(User user) async {
    var ref = FirestoreConfig.ledgerColRef
        .where('members', arrayContains: user.uid)
        .orderBy('createdAt', descending: false);

    var query = ref.withConverter<Ledger>(
        fromFirestore: (snapshot, _) => Ledger.fromFirestore(snapshot),
        toFirestore: (ledger, _) => ledger.toJson());

    var snap = await query.get();

    return snap.docs.map((e) => e.data()).toList();
  }
}
