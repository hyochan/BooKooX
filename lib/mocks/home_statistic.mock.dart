import 'package:wecount/models/category_model.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';

import '../utils/localization.dart';

List<LedgerItemModel> createHomeStatisticMock() {
  List<LedgerItemModel> ledgerList = [];
  var currentMonth = DateTime.now().month;

  ledgerList.addAll([
    LedgerItemModel(
        price: -12000,
        category: Category(
            iconId: 8, label: t('EXERCISE'), type: CategoryType.consume),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItemModel(
        price: 300000,
        category: Category(
            iconId: 18, label: t('WALLET_MONEY'), type: CategoryType.income),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItemModel(
        price: -32000,
        category:
            Category(iconId: 4, label: t('DATING'), type: CategoryType.consume),
        memo: 'who1 gave me',
        writer: UserModel(uid: 'who1@gmail.com'),
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
    LedgerItemModel(
        price: -12000,
        category: Category(
            iconId: 8, label: t('EXERCISE'), type: CategoryType.consume),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItemModel(
        price: -12000,
        category:
            Category(iconId: 4, label: t('DATING'), type: CategoryType.consume),
        selectedDate: DateTime(2019, month, 10)),
  ];
}

normalIncomeList(int month) {
  return [
    LedgerItemModel(
        price: 50000,
        category: Category(
            iconId: 18, label: t('WALLET_MONEY'), type: CategoryType.income),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItemModel(
        price: 300000,
        category:
            Category(iconId: 19, label: t('SALARY'), type: CategoryType.income),
        selectedDate: DateTime(2019, month, 10)),
  ];
}
