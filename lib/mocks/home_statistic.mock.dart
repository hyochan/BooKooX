import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/localization.dart';

List<LedgerItem> createHomeStatisticMock(Localization localization) {
  List<LedgerItem> ledgerList = [];
  var currentMonth = DateTime.now().month;

  ledgerList.addAll([
    LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8,
            label: localization.trans('EXERCISE')!,
            type: CategoryType.CONSUME),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItem(
        price: 300000,
        category: Category(
            iconId: 18,
            label: localization.trans('WALLET_MONEY')!,
            type: CategoryType.INCOME),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItem(
        price: -32000,
        category: Category(
            iconId: 4,
            label: localization.trans('DATING')!,
            type: CategoryType.CONSUME),
        memo: 'who1 gave me',
        selectedDate: DateTime(2019, currentMonth, 10))
  ]);

  /// test for stacking same ledgers
  ledgerList.addAll(normalExpenseList(localization, currentMonth));
  ledgerList.addAll(normalExpenseList(localization, currentMonth));
  ledgerList.addAll(normalIncomeList(localization, currentMonth));

  return ledgerList;
}

normalExpenseList(Localization localization, int month) {
  return [
    LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8,
            label: localization.trans('EXERCISE')!,
            type: CategoryType.CONSUME),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItem(
        price: -12000,
        category: Category(
            iconId: 4,
            label: localization.trans('DATING')!,
            type: CategoryType.CONSUME),
        selectedDate: DateTime(2019, month, 10)),
  ];
}

normalIncomeList(Localization localization, int month) {
  return [
    LedgerItem(
        price: 50000,
        category: Category(
            iconId: 18,
            label: localization.trans('WALLET_MONEY')!,
            type: CategoryType.INCOME),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItem(
        price: 300000,
        category: Category(
            iconId: 19,
            label: localization.trans('SALARY')!,
            type: CategoryType.INCOME),
        selectedDate: DateTime(2019, month, 10)),
  ];
}
