import 'package:wecount/models/category.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user.dart';

import '../utils/localization.dart';

List<LedgerItem> createHomeStatisticMock() {
  List<LedgerItem> ledgerList = [];
  var currentMonth = DateTime.now().month;

  ledgerList.addAll([
    LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8, label: t('EXERCISE'), type: CategoryType.consume),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItem(
        price: 300000,
        category: Category(
            iconId: 18, label: t('WALLET_MONEY'), type: CategoryType.income),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItem(
        price: -32000,
        category:
            Category(iconId: 4, label: t('DATING'), type: CategoryType.consume),
        memo: 'who1 gave me',
        writer: User(uid: 'who1@gmail.com'),
        selectedDate: DateTime(2019, currentMonth, 10))
  ]);

  /// test for stacking same ledgers
  ledgerList.addAll(normalExpenseList(currentMonth));
  ledgerList.addAll(normalExpenseList(currentMonth));
  ledgerList.addAll(normalIncomeList(currentMonth));

  return ledgerList;
}

normalExpenseList(int month) {
  return [
    LedgerItem(
        price: -12000,
        category: Category(
            iconId: 8, label: t('EXERCISE'), type: CategoryType.consume),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItem(
        price: -12000,
        category:
            Category(iconId: 4, label: t('DATING'), type: CategoryType.consume),
        selectedDate: DateTime(2019, month, 10)),
  ];
}

normalIncomeList(int month) {
  return [
    LedgerItem(
        price: 50000,
        category: Category(
            iconId: 18, label: t('WALLET_MONEY'), type: CategoryType.income),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItem(
        price: 300000,
        category:
            Category(iconId: 19, label: t('SALARY'), type: CategoryType.income),
        selectedDate: DateTime(2019, month, 10)),
  ];
}
