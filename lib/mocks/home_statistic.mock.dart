import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/localization.dart';

List<LedgerItemModel> createHomeStatisticMock() {
  List<LedgerItemModel> ledgerList = [];
  var currentMonth = DateTime.now().month;

  ledgerList.addAll([
    LedgerItemModel(
        price: -12000,
        category: CategoryModel(
            iconId: 8, label: t('exercise'), type: CategoryType.consume),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItemModel(
        price: 300000,
        category: CategoryModel(
            iconId: 18, label: t('walletMoney'), type: CategoryType.income),
        selectedDate: DateTime(2019, currentMonth, 10)),
    LedgerItemModel(
        price: -32000,
        category: CategoryModel(
            iconId: 4, label: t('dating'), type: CategoryType.consume),
        memo: 'who1 gave me',
        selectedDate: DateTime(2019, currentMonth, 10))
  ]);

  /// test for stacking same ledgers
  ledgerList.addAll(normalExpenseList(currentMonth));
  ledgerList.addAll(normalExpenseList(currentMonth));
  ledgerList.addAll(normalIncomeList(currentMonth));

  return ledgerList;
}

List<LedgerItemModel> normalExpenseList(int month) {
  return [
    LedgerItemModel(
        price: -12000,
        category: CategoryModel(
            iconId: 8, label: t('exercise'), type: CategoryType.consume),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItemModel(
        price: -12000,
        category: CategoryModel(
            iconId: 4, label: t('dating'), type: CategoryType.consume),
        selectedDate: DateTime(2019, month, 10)),
  ];
}

List<LedgerItemModel> normalIncomeList(int month) {
  return [
    LedgerItemModel(
        price: 50000,
        category: CategoryModel(
            iconId: 18, label: t('walletMoney'), type: CategoryType.income),
        selectedDate: DateTime(2019, month, 1)),
    LedgerItemModel(
        price: 300000,
        category: CategoryModel(
            iconId: 19, label: t('salary'), type: CategoryType.income),
        selectedDate: DateTime(2019, month, 10)),
  ];
}
