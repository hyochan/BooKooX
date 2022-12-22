import 'package:wecount/models/ledger_item_model.dart';

List<LedgerItemModel> ledgerListByMonth(
  String month,
  List<LedgerItemModel> ledgersIn,
) {
  List<LedgerItemModel> ledgersOut = [];
  // print('get ledgers by month of ' + month);
  for (final ledger in ledgersIn) {
    // print('item ' +
    //     ledger.category.toString() +
    //     ' price: ' +
    //     ledger.price.toString());

    if (ledger.selectedDate!.month.toString() == month) {
      // print('added');
      ledgersOut.add(ledger);
    }
  }

  // print('ledger quantity by Month: ' + ledgersOut.length.toString());
  return ledgersOut;
}

List<LedgerItemModel> condense(List<LedgerItemModel> ledgerList) {
  // print('ledgerList');
  Map<String?, LedgerItemModel> mappedLedgerList = {};
  for (final item in ledgerList) {
    // print('item ' +
    //     item.category.toString() +
    //     ' price: ' +
    //     item.price.toString());
    mappedLedgerList.update(
      item.category!.label,
      (LedgerItemModel existingItem) {
        // existingItem.price += item.price!;
        return existingItem;
      },
      ifAbsent: () => LedgerItemModel.createRoughCopy(item),
    );
    // print('Map ' + mappedLedgerList.length.toString());
  }

  List<LedgerItemModel> result = [];
  // print('mapped result length : ${mappedLedgerList.length}');
  mappedLedgerList.forEach((key, value) {
    result.add(value);
  });
  // print('list length : ${result.length}');
  return result;
}

Map<String, Map<String, double>> splitLedgers(
    List<LedgerItemModel> ledgerList) {
  Map<String, double> income = {};
  Map<String, double> expense = {};

  /// map ledgerList to dataMap
  for (final ledger in ledgerList) {
    if (ledger.price! > 0) {
      income.putIfAbsent(ledger.category!.label, () => ledger.price!);
    } else {
      expense.putIfAbsent(ledger.category!.label, () => ledger.price!);
    }
  }
  return {'income': income, 'expense': expense};
}
