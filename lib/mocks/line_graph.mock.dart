import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/utils/localization.dart';

List<LedgerItem> createMockCafeList(Localization localization) {
  List<LedgerItem> ledgerList = [];
  var currentMonth = DateTime.now().month;

  /// should show
  /// - summed(same date)
  ledgerList.addAll(cafe(localization, currentMonth, 1));
  ledgerList.addAll(cafe(localization, currentMonth, 3));
  ledgerList.addAll(cafe(localization, currentMonth, 3));
  ledgerList.addAll(cafe(localization, currentMonth, 6));
  ledgerList.addAll(cafe(localization, currentMonth, 10));
  ledgerList.addAll(cafe(localization, currentMonth, 6));
  ledgerList.addAll(cafe(localization, currentMonth, 20));
  ledgerList.addAll(cafe(localization, currentMonth, 20));
  ledgerList.addAll(cafe(localization, currentMonth, 20));
  ledgerList.addAll(cafe(localization, currentMonth, 20));
  ledgerList.addAll(cafe(localization, currentMonth, 29));
  ledgerList.addAll(cafe(localization, currentMonth, 8));

  ledgerList.addAll(cafe(localization, 1, 1));
  ledgerList.addAll(cafe(localization, 4, 3));
  ledgerList.addAll(cafe(localization, 2, 3));
  ledgerList.addAll(cafe(localization, 6, 6));
  ledgerList.addAll(cafe(localization, 7, 10));
  ledgerList.addAll(cafe(localization, 4, 6));
  ledgerList.addAll(cafe(localization, 3, 20));
  ledgerList.addAll(cafe(localization, 2, 20));
  ledgerList.addAll(cafe(localization, 7, 20));
  ledgerList.addAll(cafe(localization, 4, 20));
  ledgerList.addAll(cafe(localization, 3, 29));
  ledgerList.addAll(cafe(localization, 9, 8));

  ledgerList.addAll(cafe(localization, 12, 20));
  ledgerList.addAll(cafe(localization, 11, 20));
  ledgerList.addAll(cafe(localization, 10, 20));
  ledgerList.addAll(cafe(localization, 12, 20));
  ledgerList.addAll(cafe(localization, 3, 29));
  ledgerList.addAll(cafe(localization, 1, 8));

  return ledgerList;
}

cafe(Localization localization, month, day) {
  return [
    LedgerItem(
      price: -12000,
      category: Category(
          iconId: 8,
          label: localization.trans('CAFE')!,
          type: CategoryType.consume),
      selectedDate: DateTime(2019, month, day),
    ),
  ];
}
