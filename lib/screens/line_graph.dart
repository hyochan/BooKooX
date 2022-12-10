import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/mocks/line_graph.mock.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/widgets/line_graph_chart.dart';
import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../widgets/header.dart' show renderHeaderBack;

import 'package:intl/intl.dart' show DateFormat, NumberFormat;

class LineGraphArguments {
  final String title;
  final String year;
  final double? price;

  LineGraphArguments(this.title, this.year, this.price);
}

double getPriceSum(List<LedgerItem> items) {
  double sum = 0;
  for (final item in items) {
    sum += item.price!.abs();
  }
  return sum;
}

/// main
class LineGraph extends HookWidget {
  const LineGraph(
      {Key? key, this.title = '', this.year = '2019', this.price = 0.0})
      : super(key: key);
  final String title;
  final String year;
  final double price;

  @override
  Widget build(BuildContext context) {
    var selectedMonth = useState<int>(0);
    var priceSum = useState<double>(0);
    var items = useState<List<LedgerItem>>([]);
    var selectedItems = useState<List<LedgerItem>>([]);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        // this._items = createCafeList(_localization);
        items.value = createMockCafeList();
        selectedItems.value = items.value;
        priceSum.value = getPriceSum(items.value);
      });
      return null;
    }, []);

    /// on click the month on graph
    /// set bottom list to show selected month, total expenditure and its list
    void handleClickGraph({required int month, required double sumOfPrice}) {
      List<LedgerItem> itemsOfThisMonth = [];
      for (final item in items.value) {
        if (item.selectedDate!.month == month) {
          itemsOfThisMonth.add(item);
        }
      }

      selectedMonth.value = month;
      selectedItems.value = itemsOfThisMonth;
      priceSum.value = sumOfPrice;
    }

    /// Render
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).textTheme.displayLarge!.color,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            headerAlign(
              child: Text(
                title,
                // _t('CAFE')!,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
            ),
            items.value.isNotEmpty
                ? LineGraphChart(
                    items: items.value, onSelectMonth: handleClickGraph)
                : Container(),
            selectedMonth.value != 0
                ? BottomListTitle(
                    date: DateFormat('yMMM')
                        .format(DateTime(int.parse(year), selectedMonth.value)),
                    price: priceSum)
                : BottomListTitle(
                    date: DateFormat('y').format(DateTime(int.parse(year))),
                    price: price),
            const Divider(
              color: Colors.grey,
              height: 1,
              indent: 40,
              endIndent: 40,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              itemCount: selectedItems.value.length,
              itemBuilder: (context, index) {
                final item = selectedItems.value[index];
                return bottomItemWidget(
                  date: DateFormat('yyyy-MM-dd').format(item.selectedDate!),
                  price: item.price!.abs(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget headerAlign({required Widget child}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.only(left: 30),
      child: child,
    ),
  );
}

class BottomListTitle extends StatelessWidget {
  final String date;
  final String formattedPrice;
  final double fontSize = 25;
  final FontWeight fontWeight = FontWeight.w500;

  BottomListTitle({Key? key, required this.date, required price})
      : formattedPrice = NumberFormat.simpleCurrency().format(price ?? 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
      child: ListTile(
        leading: Text(
          date.toString(),
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        trailing: Text(
          formattedPrice,
          style: TextStyle(
            color: Colors.blue,
            fontSize: fontSize - 3,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}

Widget bottomItemWidget({required String date, required double price}) {
  double fontSize = 15;
  return ListTile(
    leading:
        Text(date, style: TextStyle(color: Colors.grey, fontSize: fontSize)),
    trailing: Text(NumberFormat.simpleCurrency().format(price),
        style: TextStyle(fontSize: fontSize)),
  );
}
