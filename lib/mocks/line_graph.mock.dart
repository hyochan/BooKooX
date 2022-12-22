import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/utils/localization.dart';

List<LedgerItemModel> createMockCafeList() {
  List<LedgerItemModel> ledgerList = [];
  var currentMonth = DateTime.now().month;

  /// should show
  /// - summed(same date)
  ledgerList.addAll(cafe(currentMonth, 1));
  ledgerList.addAll(cafe(currentMonth, 3));
  ledgerList.addAll(cafe(currentMonth, 3));
  ledgerList.addAll(cafe(currentMonth, 6));
  ledgerList.addAll(cafe(currentMonth, 10));
  ledgerList.addAll(cafe(currentMonth, 6));
  ledgerList.addAll(cafe(currentMonth, 20));
  ledgerList.addAll(cafe(currentMonth, 20));
  ledgerList.addAll(cafe(currentMonth, 20));
  ledgerList.addAll(cafe(currentMonth, 20));
  ledgerList.addAll(cafe(currentMonth, 29));
  ledgerList.addAll(cafe(currentMonth, 8));

  ledgerList.addAll(cafe(1, 1));
  ledgerList.addAll(cafe(4, 3));
  ledgerList.addAll(cafe(2, 3));
  ledgerList.addAll(cafe(6, 6));
  ledgerList.addAll(cafe(7, 10));
  ledgerList.addAll(cafe(4, 6));
  ledgerList.addAll(cafe(3, 20));
  ledgerList.addAll(cafe(2, 20));
  ledgerList.addAll(cafe(7, 20));
  ledgerList.addAll(cafe(4, 20));
  ledgerList.addAll(cafe(3, 29));
  ledgerList.addAll(cafe(9, 8));

  ledgerList.addAll(cafe(12, 20));
  ledgerList.addAll(cafe(11, 20));
  ledgerList.addAll(cafe(10, 20));
  ledgerList.addAll(cafe(12, 20));
  ledgerList.addAll(cafe(3, 29));
  ledgerList.addAll(cafe(1, 8));

  return ledgerList;
}

List<LedgerItemModel> cafe(month, day) {
  return [
    LedgerItemModel(
      price: -12000,
      category: CategoryModel(
          iconId: 8, label: t('cafe'), type: CategoryType.consume),
      selectedDate: DateTime(2019, month, day),
    ),
  ];
}
