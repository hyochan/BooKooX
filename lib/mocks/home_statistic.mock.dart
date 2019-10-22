import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/utils/localization.dart';

List<LedgerItem> createHomeStatisticMock(Localization localization) {
  List<LedgerItem> ledgerList = new List<LedgerItem>();

  ledgerList.addAll([
    new LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8,
            label: localization.trans('EXERCISE'),
            type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 9, 10)),
    new LedgerItem(
        price: 300000,
        category: Category(
            iconId: 18,
            label: localization.trans('WALLET_MONEY'),
            type: CategoryType.INCOME),
        selectedDate: new DateTime(2019, 9, 10)),
    new LedgerItem(
        price: -32000,
        category: Category(
            iconId: 4,
            label: localization.trans('DATING'),
            type: CategoryType.CONSUME),
        memo: 'who1 gave me',
        writer: new User(uid: 'who1@gmail.com'),
        selectedDate: new DateTime(2019, 9, 10))
  ]);

  /// test for stacking same ledgers
  ledgerList.addAll(normalExpenseList(localization, 10));
  ledgerList.addAll(normalExpenseList(localization, 10));
  ledgerList.addAll(normalIncomeList(localization, 10));


  return ledgerList;
}

normalExpenseList(Localization localization, int month) {
  return [
    new LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8,
            label: localization.trans('EXERCISE'),
            type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, month, 1)),
    new LedgerItem(
        price: -12000,
        category: Category(
            iconId: 4,
            label: localization.trans('DATING'),
            type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, month, 10)),
  ];
}

normalIncomeList(Localization localization, int month) {
  return [
    new LedgerItem(
        price: 50000,
        category: Category(
            iconId: 18,
            label: localization.trans('WALLET_MONEY'),
            type: CategoryType.INCOME),
        selectedDate: new DateTime(2019, month, 1)),
    new LedgerItem(
        price: 300000,
        category: Category(
            iconId: 19,
            label: localization.trans('SALARY'),
            type: CategoryType.INCOME),
        selectedDate: new DateTime(2019, month, 10)),
  ];
}
