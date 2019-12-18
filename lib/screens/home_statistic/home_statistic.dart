import 'package:bookoo2/mocks/home_statistic.mock.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/shared/date_selector.dart' show DateSelector;
import 'package:bookoo2/screens/home_statistic/functions.dart';

import 'package:bookoo2/shared/home_list_item.dart';
import 'package:bookoo2/utils/asset.dart' as Assets;
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:bookoo2/utils/general.dart' show General;
import 'package:bookoo2/shared/home_header.dart' show renderHomeAppBar;
import 'package:pie_chart/pie_chart.dart' show PieChart;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:bookoo2/utils/localization.dart' show Localization;

class HomeStatistic extends StatelessWidget {
  HomeStatistic({
    Key key,
    this.title = '대학 하계 MT',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: this.title,
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
          child: Center(
            child: Content(),
          ),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  /// From parent
  List<LedgerItem> _ledgerList;

  /// State
  DateTime _date = DateTime.now(); //todo: initialize with parent's
  List<LedgerItem> _ledgerListOfSelectedMonth = List<LedgerItem>();
  List<LedgerItem> _condensedLedgerList = List();
  Map<String, double> _dataMapIncome = Map();
  Map<String, double> _dataMapExpense = Map();
  int _selectedChart;

  List<Color> colorList = [
    Assets.Colors.blue,
    Assets.Colors.orange,
    Assets.Colors.green,
    Assets.Colors.yellow,
    Assets.Colors.purple,
    Assets.Colors.dusk,
    Assets.Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _ledgerList = createHomeStatisticMock(Localization.of(context));

      calculateAndRender(this._date.month.toString(), _ledgerList);
      this.setState(() => this._selectedChart = 1);
    });
  }

  void calculateAndRender(String month, List<LedgerItem> ledgerList) {
    var ledgerListOfSelectedMonth = ledgerListByMonth(month, ledgerList);

    /// sum up same category into one. but before that I can make ui first
    var condensedLedgerList = condense(ledgerListOfSelectedMonth);
    var result = splitLedgers(condensedLedgerList);
    // ledgerList.addAll(normalIncomeList(localization, 10));

    this.setState(() {
      this._condensedLedgerList = condensedLedgerList;
      this._ledgerListOfSelectedMonth = ledgerListOfSelectedMonth;
      this._dataMapIncome = result['income'];
      this._dataMapExpense = result['expense'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

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

    Map<String, double> dataMap =
        this._selectedChart == 1 ? this._dataMapIncome : this._dataMapExpense;

    /// PieChart throws error when `_dataMap` is empty
    var chartWidget = dataMap.length > 0
        ? PieChart(
            dataMap: dataMap,
            legendFontColor: Theme.of(context).textTheme.title.color,
            legendFontSize: 14.0,
            legendFontWeight: FontWeight.w500,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            showChartValuesInPercentage: true,
            showChartValues: true,
            showChartValuesOutside: false,
            chartValuesColor:
                Theme.of(context).textTheme.display3.color.withOpacity(0.9),
            colorList: colorList,
            showLegends: true,
            decimalPlaces: 1,
          )
        : Container(
            child: Flex(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                ),
                Text(
                  localization.trans('NO_DATA'),
                  style: TextStyle(),
                ),
              ],
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          );

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
            DateSelector(
              date: DateFormat.yMMM().format(_date),
              onDatePressed: onDatePressed,
            ),
            ButtonGroup(
              onButtonOnePressed: () {
                this.setState(() {
                  this._selectedChart = 1;
                });
              },
              onButtonTwoPressed: () {
                this.setState(() {
                  this._selectedChart = 2;
                });
              },
              selected: this._selectedChart,
            ),
            chartWidget,
            bottomListWidget,
          ],
        ),
      ),
    );
  }
}

class ButtonGroup extends StatelessWidget {
  final selected;
  final Function onButtonOnePressed;
  final Function onButtonTwoPressed;
  ButtonGroup(
      {Key key,
      @required this.selected,
      @required this.onButtonOnePressed,
      @required this.onButtonTwoPressed})
      : super(key: key);

  final width = 300;
  final double buttonHeight = 30;
  final selectedColorText = Colors.white;
  Radius borderRadius = Radius.circular(5.0);

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    var localization = Localization.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 40,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(width: 30),
          Expanded(
            child: ButtonTheme(
              height: buttonHeight,
              child: RaisedButton(
                color: this.selected == 1 ? selectedColor : Colors.white,
                onPressed: this.onButtonOnePressed,
                child: Text(
                  localization.trans("INCOME"),
                  style: TextStyle(
                    color:
                        this.selected == 1 ? selectedColorText : Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: borderRadius, bottomLeft: borderRadius),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: ButtonTheme(
              height: buttonHeight,
              child: RaisedButton(
                color: this.selected == 2 ? selectedColor : Colors.white,
                onPressed: this.onButtonTwoPressed,
                child: Text(
                  localization.trans("CONSUME"),
                  style: TextStyle(
                    color:
                        this.selected == 2 ? selectedColorText : Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: borderRadius, bottomRight: borderRadius),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          Container(width: 30),
        ],
      ),
    );
  }
}
