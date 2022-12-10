import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/mocks/home_statistic.mock.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/date_selector.dart' show DateSelector;
import 'package:wecount/screens/home_statistic/functions.dart';

import 'package:wecount/widgets/home_list_item.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:wecount/widgets/home_header.dart' show renderHomeAppBar;
import 'package:pie_chart/pie_chart.dart' show PieChart;
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:provider/provider.dart';

class HomeStatistic extends StatelessWidget {
  const HomeStatistic({
    Key? key,
    this.title = '대학 하계 MT',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : ColorType.dusk;

    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: title,
        color: asset.Colors.getColor(color),
        fontColor: Colors.white,
        actions: [
          SizedBox(
            width: 56.0,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: () =>
                  navigation.push(context, AppRoute.ledgerItemEdit.path),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: SizedBox(
          child: Center(
            child: Content(),
          ),
        ),
      ),
    );
  }
}

class Content extends HookWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// From parent
    late List<LedgerItem> ledgerItems;

    /// State
    DateTime date = DateTime.now();
    var dataMapIncome = useState<Map<String, double>?>({});
    var dataMapExpense = useState<Map<String, double>?>({});
    var condensedLedgerList = useState<List<LedgerItem>>([]);
    var selectedChart = useState<int>(0);

    List<Color> colorList = [
      asset.Colors.blue,
      asset.Colors.orange,
      asset.Colors.green,
      asset.Colors.yellow,
      asset.Colors.purple,
      asset.Colors.main,
      asset.Colors.red,
    ];

    void calculateAndRender(String month, List<LedgerItem> ledgerList) {
      var ledgerListOfSelectedMonth = ledgerListByMonth(month, ledgerList);

      /// sum up same category into one. but before that I can make ui first
      var condensedLedgerList = condense(ledgerListOfSelectedMonth);
      var result = splitLedgers(condensedLedgerList);
      // ledgerList.addAll(normalIncomeList(localization, 10));

      dataMapIncome.value = result['income'];
      dataMapExpense.value = result['expense'];
    }

    var localization = Localization.of(context);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        ledgerItems = createHomeStatisticMock(Localization.of(context)!);

        calculateAndRender(date.month.toString(), ledgerItems);
        selectedChart.value = 1;
      });
      return null;
    }, []);

    /// Month select Widget -> select month, set _date and calculate
    void onDatePressed() async {
      int year = date.year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      // DateTime? pickDate = await showMonthPicker(
      //   context: context,
      //   initialDate: this._date,
      //   firstDate: DateTime(prevDate),
      //   lastDate: DateTime(lastDate),
      // );
      // if (pickDate != null) {
      //   this.setState(() => this._date = pickDate);
      //   calculateAndRender(this._date.month.toString(), _ledgerList);
      // }
    }

    Map<String, double> dataMap =
        selectedChart.value == 1 ? dataMapIncome.value! : dataMapExpense.value!;

    /// PieChart throws error when `_dataMap` is empty
    var chartWidget = dataMap.isNotEmpty
        ? PieChart(
            dataMap: dataMap,
            centerTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            // showChartValuesInPercentage: true,
            // showChartValues: true,
            // showChartValuesOutside: false,
            // chartValueStyle: Theme.of(context).textTheme.displayLarge,
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
                localization!.trans('NO_DATA')!,
                style: const TextStyle(),
              ),
            ],
          );

    var bottomListWidget = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: condensedLedgerList.value.length,
      itemBuilder: (BuildContext context, int index) {
        return HomeListItem(ledgerItem: condensedLedgerList.value[index]);
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
              date: DateFormat.yMMM().format(date),
              onDatePressed: onDatePressed,
            ),
            ButtonGroup(
              onButtonOnePressed: () {
                selectedChart.value = 1;
              },
              onButtonTwoPressed: () {
                selectedChart.value = 2;
              },
              selectedIndex: selectedChart.value,
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
  final int selectedIndex;
  final Function onButtonOnePressed;
  final Function onButtonTwoPressed;

  const ButtonGroup(
      {Key? key,
      required this.selectedIndex,
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
    var localization = Localization.of(context)!;
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
              child: ElevatedButton(
                onPressed: onButtonOnePressed as void Function()?,
                child: Text(
                  localization.trans("INCOME")!,
                  style: TextStyle(
                    color:
                        selectedIndex == 1 ? selectedColorText : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ButtonTheme(
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: onButtonTwoPressed as void Function()?,
                child: Text(
                  localization.trans("CONSUME")!,
                  style: TextStyle(
                    color:
                        selectedIndex == 2 ? selectedColorText : Colors.black,
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
