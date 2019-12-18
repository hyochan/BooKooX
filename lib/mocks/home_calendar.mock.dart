import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/utils/localization.dart';

List<LedgerItem> createCalendarLedgerItemMock(Localization localization) {
  List<LedgerItem> ledgerList = List<LedgerItem>();
  var currentMonth = DateTime.now().month;

  ledgerList.add(LedgerItem(
      price: -12000,
      category: Category(
          iconId: 8,
          label: localization.trans('EXERCISE'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItem(
      price: 300000,
      category: Category(
          iconId: 18,
          label: localization.trans('WALLET_MONEY'),
          type: CategoryType.INCOME),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItem(
      price: -32000,
      category: Category(
          iconId: 4,
          label: localization.trans('DATING'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItem(
      price: -3100,
      category: Category(
          iconId: 0,
          label: localization.trans('CAFE'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItem(
      price: -3100,
      category: Category(
          iconId: 0,
          label: localization.trans('CAFE'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItem(
      price: -3100,
      category: Category(
          iconId: 0,
          label: localization.trans('CAFE'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItem(
      price: -3100,
      category: Category(
          iconId: 0,
          label: localization.trans('CAFE'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 15)));
  ledgerList.add(LedgerItem(
      price: -12000,
      category: Category(
          iconId: 12,
          label: localization.trans('PRESENT'),
          type: CategoryType.CONSUME),
      selectedDate: DateTime(2019, currentMonth, 15)));

  return ledgerList;
}
