import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/utils/localization.dart';

List<LedgerItemModel> createCalendarLedgerItemMock() {
  List<LedgerItemModel> ledgerList = [];
  var currentMonth = DateTime.now().month;

  ledgerList.add(LedgerItemModel(
      price: -12000,
      category: CategoryModel(
        iconId: 8,
        label: t('exercise'),
        type: CategoryType.consume,
      ),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItemModel(
      price: 300000,
      category: CategoryModel(
          iconId: 18, label: t('walletMoney'), type: CategoryType.income),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItemModel(
      price: -32000,
      category: CategoryModel(
          iconId: 4, label: t('dating'), type: CategoryType.consume),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItemModel(
      price: -3100,
      category: CategoryModel(
          iconId: 0, label: t('cafe'), type: CategoryType.consume),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItemModel(
      price: -3100,
      category: CategoryModel(
          iconId: 0, label: t('cafe'), type: CategoryType.consume),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItemModel(
      price: -3100,
      category: CategoryModel(
          iconId: 0, label: t('cafe'), type: CategoryType.consume),
      selectedDate: DateTime(2019, currentMonth, 10)));
  ledgerList.add(LedgerItemModel(
      price: -3100,
      category: CategoryModel(
          iconId: 0, label: t('cafe'), type: CategoryType.consume),
      selectedDate: DateTime(2019, currentMonth, 15)));
  ledgerList.add(LedgerItemModel(
      price: -12000,
      category: CategoryModel(
          iconId: 12, label: t('present'), type: CategoryType.consume),
      selectedDate: DateTime(2019, currentMonth, 15)));

  return ledgerList;
}
