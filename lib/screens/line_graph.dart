import 'package:wecount/mocks/line_graph.mock.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/shared/line_graph_chart.dart';
import 'package:flutter/material.dart';

import '../shared/header.dart' show renderHeaderBack;

import 'package:intl/intl.dart' show DateFormat, NumberFormat;

import '../utils/localization.dart';

double getPriceSum(List<LedgerItemModel> items) {
  double sum = 0;
  // ignore: avoid_function_literals_in_foreach_calls
  items.forEach((item) {
    sum += item.price!.abs();
  });
  return sum;
}

/// main
class LineGraph extends StatefulWidget {
  static const String name = '/line_graph';

  const LineGraph({
    Key? key,
    this.title = '',
    this.year = '2019',
  }) : super(key: key);
  final String title;
  final String year;

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  int _selectedMonth = 0;
  double _priceSum = 0;
  List<LedgerItemModel> _items = [];
  List<LedgerItemModel> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _items = createMockCafeList();
        _selectedItems = _items;
        _priceSum = getPriceSum(_items);
      });
    });
  }

  /// on click the month on graph
  /// set bottom list to show selected month, total expenditure and its list
  void handleClickGraph({required int month, required double sumOfPrice}) {
    List<LedgerItemModel> itemsOfThisMonth = [];
    // ignore: avoid_function_literals_in_foreach_calls
    _items.forEach((item) {
      if (item.selectedDate!.month == month) {
        itemsOfThisMonth.add(item);
      }
    });

    setState(() {
      _selectedMonth = month;
      _selectedItems = itemsOfThisMonth;
      _priceSum = sumOfPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Render
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).textTheme.headline1!.color,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            headerAlign(
              child: Text(
                t('CAFE'),
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
            _items.isNotEmpty
                ? LineGraphChart(items: _items, onSelectMonth: handleClickGraph)
                : Container(),
            _selectedMonth != 0
                ? BottomListTitle(
                    date: DateFormat('yMMM').format(
                        DateTime(int.parse(widget.year), _selectedMonth)),
                    price: _priceSum)
                : BottomListTitle(
                    date: DateFormat('y')
                        .format(DateTime(int.parse(widget.year))),
                    price: _priceSum),
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
              itemCount: _selectedItems.length,
              itemBuilder: (context, index) {
                final item = _selectedItems[index];
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
