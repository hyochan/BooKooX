import 'package:bookoo2/mocks/home_statistic.mock.dart';
import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/shared/home_list_item.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:bookoo2/mocks/home_statistic.mock.dart';

import 'package:bookoo2/utils/general.dart' show General;
import 'package:bookoo2/shared/home_header.dart' show renderHomeAppBar;
import 'package:pie_chart/pie_chart.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:intl/intl.dart' show DateFormat;

class HomeStatistic extends StatefulWidget {
  HomeStatistic({
    Key key,
    this.title = '대학 하계 MT',
  }) : super(key: key);
  final String title;

  @override
  _HomeStatisticState createState() => new _HomeStatisticState();
}

class _HomeStatisticState extends State<HomeStatistic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: widget.title,
        actions: [
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () => General.instance
                  .navigateScreenNamed(context, '/ledger_item_add'),
              child: Icon(
                Icons.add,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          child: Center(child: Content()),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => new _ContentState();
}

class _ContentState extends State<Content> {
  /// From parent
  List<LedgerItem> _ledgerList;

  /// State
  DateTime _date = DateTime.now(); //todo: initialize with parent's
  List<LedgerItem> _ledgerListOfSelectedMonth = new List<LedgerItem>();
  List<LedgerItem> _condensedLedgerList = new List();
  Map<String, double> _dataMapIncome = new Map();
  Map<String, double> _dataMapExpense = new Map();
  int _chartType;

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _ledgerList = createHomeStatisticMock(Localization.of(context));

      calculateAndRender(this._date.month.toString(), _ledgerList);
      this.setState(() => this._chartType = 1);
    });
  }

  ///h1
  void calculateAndRender(String month, List<LedgerItem> ledgerList) {
    var ledgerListOfSelectedMonth = ledgerListByMonth(month, ledgerList);

    /// sum up same category into one. but before that I can make ui first
    var condensedLedgerList = condense(ledgerListOfSelectedMonth);
    var result = splitLedger(condensedLedgerList);
    // ledgerList.addAll(normalIncomeList(localization, 10));

    this.setState(() {
      this._condensedLedgerList = condensedLedgerList;
      this._ledgerListOfSelectedMonth = ledgerListOfSelectedMonth;
      this._dataMapIncome = result['income'];
      this._dataMapExpense = result['expense'];
    });
    print(
        'dataMapIncome : ${this._dataMapIncome} / dataMapExpense: ${this._dataMapExpense}');
  }

  @override
  Widget build(BuildContext context) {
    /// Month select Widget -> select month, set _date and calculate
    void onDatePressed() async {
      int year = this._date.year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime pickDate = await showMonthPicker(
        context: context,
        initialDate: this._date,
        firstDate: DateTime(prevDate),
        lastDate: DateTime(lastDate),
      );
      if (pickDate != null) {
        this.setState(() => this._date = pickDate);
        calculateAndRender(this._date.month.toString(), _ledgerList);
      }
    }

    var currentMonthWidget = Container(
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        children: <Widget>[
          Text(
            DateFormat.yMMM().format(_date),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_drop_down),
            color: Colors.grey,
            onPressed: onDatePressed,
          ),
        ],
      ),
    );

    Map<String, double> dataMap =
        this._chartType == 1 ? this._dataMapIncome : this._dataMapExpense;

    /// PieChart throws error when `_dataMap` is empty
    var chartWidget = dataMap.length > 0
        ? PieChart(
            dataMap: dataMap,
            legendFontColor: Colors.blueGrey[900],
            legendFontSize: 14.0,
            legendFontWeight: FontWeight.w500,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            showChartValuesInPercentage: true,
            showChartValues: true,
            showChartValuesOutside: false,
            chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
            colorList: colorList,
            showLegends: true,
            decimalPlaces: 1,
          )
        : Container(
            child: Text(
              'No data to show',
            ),
          );

    var buttonGroupWidget = Material(
      // elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          ButtonTheme(
            minWidth: 120.0,
            child: RaisedButton(
              color: this._chartType == 1 ? Colors.amber : Colors.white,
              onPressed: () {
                this.setState(() {
                  this._chartType = 1;
                });
              },
              child: Text("수입"),
            ),
          ),
          ButtonTheme(
            minWidth: 120.0,
            child: RaisedButton(
              color: this._chartType == 2 ? Colors.amber : Colors.white,
              onPressed: () {
                this.setState(() {
                  this._chartType = 2;
                });
              },
              child: Text("지출"),
            ),
          ),
        ],
      ),
    );


    var bottomList = this._chartType == 1? this._dataMapIncome: this._dataMapExpense;
    var bottomListWidget = ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: _condensedLedgerList.length,
      itemBuilder: (BuildContext context, int index) {
        return HomeListItem(ledgerItem: _condensedLedgerList[index]);
      },
    );


    return SafeArea(
      top: false,
      child: Container(
        margin: EdgeInsets.only(
          top: 5.0,
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            currentMonthWidget,
            buttonGroupWidget,
            chartWidget,
            Divider(
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
            ),
            bottomListWidget,
          ],
        ),
      ),
    );
  }
}

List<LedgerItem> ledgerListByMonth(
  String month,
  List<LedgerItem> ledgersIn,
) {
  List<LedgerItem> ledgersOut = new List<LedgerItem>();
  print('get ledgers by month of ' + month);
  ledgersIn.forEach((ledger) {
    print('item ' +
        ledger.category.toString() +
        ' price: ' +
        ledger.price.toString());

    if (ledger.selectedDate.month.toString() == month) {
      print('added');
      ledgersOut.add(ledger);
    }
  });

  print('ledger quantity by Month: ' + ledgersOut.length.toString());
  return ledgersOut;
}

///h2
List<LedgerItem> condense(List<LedgerItem> ledgerList) {
  print('ledgerList');
  Map<String, LedgerItem> mappedLedgerList = new Map();
  ledgerList.forEach((item) {
    print('item ' +
        item.category.toString() +
        ' price: ' +
        item.price.toString());
    mappedLedgerList.update(
      item.category.label,
      (LedgerItem existingItem) {
        existingItem.price += item.price;
        return existingItem;
      },
      ifAbsent: () => item.createRoughCopy(),
    );
    print('Map ' + mappedLedgerList.length.toString());
  });

  List<LedgerItem> result = new List();
  print('mapped result length : ${mappedLedgerList.length}');
  mappedLedgerList.forEach((key, value) {
    result.add(value);
  });
  print('list length : ${result.length}');
  return result;
}

Map<String, Map<String, double>> splitLedger(List<LedgerItem> ledgerList) {
  Map<String, double> income = new Map();
  Map<String, double> expense = new Map();

  /// map ledgerList to dataMap
  ledgerList.forEach((ledger) {
    if (ledger.price > 0) {
      income.putIfAbsent(ledger.category.label, () => ledger.price);
    } else {
      expense.putIfAbsent(ledger.category.label, () => ledger.price);
    }
  });
  return {'income': income, 'expense': expense};
}
