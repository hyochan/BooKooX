import 'package:wecount/models/ledger_item.dart';

List<LedgerItem> ledgerListByMonth(
  String month,
  List<LedgerItem> ledgersIn,
) {
  List<LedgerItem> ledgersOut = [];
  // logger.d('get ledgers by month of ' + month);
  for (LedgerItem ledger in ledgersIn) {
    // logger.d('item ' +
    //     ledger.category.toString() +
    //     ' price: ' +
    //     ledger.price.toString());

    if (ledger.selectedDate!.month.toString() == month) {
      // logger.d('added');
      ledgersOut.add(ledger);
    }
  }

  // logger.d('ledger quantity by Month: ' + ledgersOut.length.toString());
  return ledgersOut;
}

List<LedgerItem> condense(List<LedgerItem> ledgerList) {
  // logger.d('ledgerList');
  Map<String?, LedgerItem> mappedLedgerList = {};
  // ignore: avoid_function_literals_in_foreach_calls
  ledgerList.forEach((item) {
    // logger.d('item ' +
    //     item.category.toString() +
    //     ' price: ' +
    //     item.price.toString());
    mappedLedgerList.update(
      item.category!.label,
      (LedgerItem existingItem) {
        // existingItem.price += item.price!;
        return existingItem;
      },
      ifAbsent: () => item.createRoughCopy(),
    );
    // logger.d('Map ' + mappedLedgerList.length.toString());
  });

  List<LedgerItem> result = [];
  // logger.d('mapped result length : ${mappedLedgerList.length}');
  mappedLedgerList.forEach((key, value) {
    result.add(value);
  });
  // logger.d('list length : ${result.length}');
  return result;
}

Map<String, Map<String, double>> splitLedgers(List<LedgerItem> ledgerList) {
  Map<String, double> income = {};
  Map<String, double> expense = {};

  /// map ledgerList to dataMap
  for (var ledger in ledgerList) {
    if (ledger.price! > 0) {
      income.putIfAbsent(ledger.category!.label!, () => ledger.price!);
    } else {
      expense.putIfAbsent(ledger.category!.label!, () => ledger.price!);
    }
  }
  return {'income': income, 'expense': expense};
}
