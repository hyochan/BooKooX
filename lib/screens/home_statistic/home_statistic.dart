import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pie_chart/pie_chart.dart' show PieChart;
import 'package:provider/provider.dart';
import 'package:wecount/mocks/home_statistic.mock.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/home_statistic/functions.dart';
import 'package:wecount/shared/date_selector.dart' show DateSelector;
import 'package:wecount/shared/home_header.dart' show renderHomeAppBar;
import 'package:wecount/shared/home_list_item.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/general.dart' show General;
import 'package:wecount/utils/localization.dart';

import '../../utils/colors.dart';

class HomeStatistic extends StatelessWidget {
  const HomeStatistic({
    Key? key,
    this.title = '대학 하계 MT',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).ledger != null
        ? Provider.of<CurrentLedger>(context).ledger!.color
        : ColorType.dusk;

    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: title,
        color: getColor(color),
        fontColor: Colors.white,
        actions: [
          SizedBox(
            width: 56.0,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: () => General.instance
                  .navigateScreenNamed(context, '/ledger_item_edit'),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: const SafeArea(
        child: Center(
          child: Content(),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  /// From parent
  late List<LedgerItemModel> _ledgerList;

  /// State
  DateTime _date = DateTime.now();
  List<LedgerItemModel> _condensedLedgerList = [];
  Map<String, double>? _dataMapIncome = {};
  Map<String, double>? _dataMapExpense = {};
  int? _selectedChart;

  List<Color> colorList = [
    blueColor,
    orangeColor,
    greenColor,
    yellowColor,
    purpleColor,
    mainColor,
    redColor,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _ledgerList = createHomeStatisticMock();

      calculateAndRender(_date.month.toString(), _ledgerList);
      setState(() => _selectedChart = 1);
    });
  }

  void calculateAndRender(String month, List<LedgerItemModel> ledgerList) {
    var ledgerListOfSelectedMonth = ledgerListByMonth(month, ledgerList);

    /// sum up same category into one. but before that I can make ui first
    var condensedLedgerList = condense(ledgerListOfSelectedMonth);
    var result = splitLedgers(condensedLedgerList);
    // ledgerList.addAll(normalIncomeList(localization, 10));

    setState(() {
      _condensedLedgerList = condensedLedgerList;
      _dataMapIncome = result['income'];
      _dataMapExpense = result['expense'];
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Month select Widget -> select month, set _date and calculate
    void onDatePressed() async {
      int year = _date.year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime? pickDate = await showMonthPicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(prevDate),
        lastDate: DateTime(lastDate),
      );
      if (pickDate != null) {
        setState(() => _date = pickDate);
        calculateAndRender(_date.month.toString(), _ledgerList);
      }
    }

    Map<String, double> dataMap =
        _selectedChart == 1 ? _dataMapIncome! : _dataMapExpense!;

    /// PieChart throws error when `_dataMap` is empty
    var chartWidget = dataMap.isNotEmpty
        ? PieChart(
            dataMap: dataMap,
            centerTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            // showChartValuesInPercentage: true,
            // showChartValues: true,
            // showChartValuesOutside: false,
            // chartValueStyle: Theme.of(context).textTheme.headline1,
            colorList: colorList,
            // showLegends: true,
            // decimalPlaces: 1,
          )
        : Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
              ),
              Text(
                t('NO_DATA'),
                style: const TextStyle(),
              ),
            ],
          );

    var bottomListWidget = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: _condensedLedgerList.length,
      itemBuilder: (BuildContext context, int index) {
        return HomeListItem(ledgerItem: _condensedLedgerList[index]);
      },
    );

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.only(
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
                setState(() {
                  _selectedChart = 1;
                });
              },
              onButtonTwoPressed: () {
                setState(() {
                  _selectedChart = 2;
                });
              },
              selected: _selectedChart,
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
  final int? selected;
  final Function onButtonOnePressed;
  final Function onButtonTwoPressed;

  const ButtonGroup(
      {Key? key,
      required this.selected,
      required this.onButtonOnePressed,
      required this.onButtonTwoPressed})
      : super(key: key);

  final width = 300;
  final double buttonHeight = 30;
  final selectedColorText = Colors.white;
  final Radius borderRadius = const Radius.circular(5.0);

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 40,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(width: 30),
          Expanded(
            child: ButtonTheme(
              height: buttonHeight,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: selected == 1 ? selectedColor : Colors.white,
                onPressed: onButtonOnePressed as void Function()?,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: borderRadius, bottomLeft: borderRadius),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  t("INCOME"),
                  style: TextStyle(
                    color: selected == 1 ? selectedColorText : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ButtonTheme(
              height: buttonHeight,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: selected == 2 ? selectedColor : Colors.white,
                onPressed: onButtonTwoPressed as void Function()?,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: borderRadius, bottomRight: borderRadius),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  t("CONSUME"),
                  style: TextStyle(
                    color: selected == 2 ? selectedColorText : Colors.black,
                  ),
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
