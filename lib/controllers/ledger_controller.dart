import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wecount/utils/logger.dart';

import '../models/ledger_model.dart';

class LedgerController extends GetxController {
  Rxn<LedgerModel> selectedLedger = Rxn<LedgerModel>();

  static LedgerController get to => Get.find();

  final CollectionReference<LedgerModel> _ledgerRef = FirebaseFirestore.instance
      .collection('ledgers')
      .withConverter<LedgerModel>(
        fromFirestore: (snapshot, _) => LedgerModel.fromJson(
          snapshot.data(),
        ),
        toFirestore: (ledger, _) => ledger.toJson(),
      );

  Future<void> updateSelectedLedger(String ledgerId) async {
    DocumentSnapshot<LedgerModel> snapshot =
        await _ledgerRef.doc(ledgerId).get();
    logger.i(snapshot.data());

    if (snapshot.exists) {
      selectedLedger(snapshot.data());
    }
  }
}
