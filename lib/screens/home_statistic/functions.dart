import 'package:wecount/models/ledger_item.dart';

List<LedgerItem> ledgerListByMonth(
  String month,
  List<LedgerItem> ledgersIn,
) {
  List<LedgerItem> ledgersOut = [];
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

List<LedgerItem> condense(List<LedgerItem> ledgerList) {
  // print('ledgerList');
  Map<String?, LedgerItem> mappedLedgerList = {};
  for (final item in ledgerList) {
    // print('item ' +
    //     item.category.toString() +
    //     ' price: ' +
    //     item.price.toString());
    mappedLedgerList.update(
      item.category!.label,
      (LedgerItem existingItem) {
        // existingItem.price += item.price!;
        return existingItem;
      },
      ifAbsent: () => LedgerItem.createRoughCopy(item),
    );
    // print('Map ' + mappedLedgerList.length.toString());
  }

  List<LedgerItem> result = [];
  // print('mapped result length : ${mappedLedgerList.length}');
  mappedLedgerList.forEach((key, value) {
    result.add(value);
  });
  // print('list length : ${result.length}');
  return result;
}

Map<String, Map<String, double>> splitLedgers(List<LedgerItem> ledgerList) {
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
