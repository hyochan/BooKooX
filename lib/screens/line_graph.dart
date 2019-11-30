import 'package:bookoo2/mocks/line_graph.mock.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/shared/line_graph_chart.dart';
import 'package:flutter/material.dart';

import '../utils/localization.dart' show Localization;
import '../shared/header.dart' show renderHeaderBack;

import 'package:intl/intl.dart' show DateFormat, NumberFormat;

/// utils
bool notNull(Object o) => o != null;

double getPriceSum(List<LedgerItem> items) {
  double sum = 0;
  items.forEach((item) {
    sum += item.price.abs();
  });
  return sum;
}

/// main
class LineGraph extends StatefulWidget {
  LineGraph({
    Key key,
    this.title = '',
    this.year = '2019',
  }) : super(key: key);
  final String title;
  final String year;

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  int _selectedMonth = 0;
  double _priceSum = 0;
  List<LedgerItem> _items = new List();
  List<LedgerItem> _selectedItems = new List();

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      var _localization = Localization.of(context);

      // this._items = createCafeList(_localization);
      this.setState(() {
        this._items = createMockCafeList(_localization);
        this._selectedItems = this._items;
        this._priceSum = getPriceSum(this._items);
      });
    });
  }

  /// on click the month on graph
  /// set bottom list to show selected month, total expenditure and its list
  void handleClickGraph({@required int month, @required double sumOfPrice}) {
    List<LedgerItem> itemsOfThisMonth = new List();
    this._items.forEach((item) {
      if (item.selectedDate.month == month) {
        itemsOfThisMonth.add(item);
      }
    });

    this.setState(() {
      this._selectedMonth = month;
      this._selectedItems = itemsOfThisMonth;
      this._priceSum = sumOfPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    /// Render
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).textTheme.title.color,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            headerAlign(
              child: Text(
                _localization.trans('CAFE'),
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.title.color,
                ),
              ),
            ),
            this._items.length != 0
                ? LineGraphChart(
                    items: this._items, onSelectMonth: this.handleClickGraph)
                : Container(),
            this._selectedMonth != 0
                ? BottomListTitle(
                    date: DateFormat('yMMM').format(
                        DateTime(int.parse(widget.year), this._selectedMonth)),
                    price: this._priceSum)
                : BottomListTitle(
                    date: DateFormat('y')
                        .format(DateTime(int.parse(widget.year))),
                    price: this._priceSum),
            Divider(
              color: Colors.grey,
              height: 1,
              indent: 40,
              endIndent: 40,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              itemCount: this._selectedItems.length,
              itemBuilder: (context, index) {
                final item = this._selectedItems[index];
                return bottomItemWidget(
                  date: DateFormat('yyyy-MM-dd').format(item.selectedDate),
                  price: item.price.abs(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Wigets
Widget headerAlign({@required Widget child}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.only(left: 30),
      child: child,
    ),
  );
}

class BottomListTitle extends StatelessWidget {
  final String date;
  final String formattedPrice;
  final double fontSize = 25;
  final FontWeight fontWeight = FontWeight.w500;

  BottomListTitle({Key key, @required this.date, @required price})
      : this.formattedPrice =
            NumberFormat.simpleCurrency().format(price ?? 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
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

Widget bottomItemWidget({@required String date, @required double price}) {
  double fontSize = 15;
  return ListTile(
    leading:
        Text(date, style: TextStyle(color: Colors.grey, fontSize: fontSize)),
    trailing: Text(NumberFormat.simpleCurrency().format(price ?? 0.0),
        style: TextStyle(fontSize: fontSize)),
  );
}
