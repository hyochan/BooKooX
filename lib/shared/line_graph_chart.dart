import 'package:wecount/models/ledger_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart' show NumberFormat;

/// typing callback function
typedef SelectMonthToShow = void Function(
    {required int month, required double sumOfPrice});

/// to reduce performance issue,
/// if I don't scale down the price values from parent,
/// chart will have performance issue
const chartScale = 10000;

class LineGraphChart extends StatefulWidget {
  final List<LedgerItemModel> items;
  final SelectMonthToShow? onSelectMonth;
  const LineGraphChart({
    Key? key,
    required this.items,
    this.onSelectMonth,
  }) : super(key: key);

  @override
  State<LineGraphChart> createState() => _LineGraphChartState();
}

class _LineGraphChartState extends State<LineGraphChart> {
  late ChartValues chartValues;
  double? _minY, _maxY;
  late List<FlSpot>? _spots;

  @override
  void initState() {
    super.initState();

    /// make min, max values and spots(tuple values) for chart
    chartValues = ChartValues(mapValues(widget.items));
    _minY = 0;
    _maxY = chartValues.maxPrice / chartScale;

    _spots = chartValues.tupleValues.map((Tuple tuple) {
      return FlSpot(tuple.month.toDouble(), tuple.price / chartScale);
    }).toList();
  }

  List<Color> gradientColors = [
    Colors.blue,
    const Color(0xff02d39a),
  ];

  final double _minX = 1;
  final double _maxX = 12;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      minX: _minX,
      maxX: _maxX,
      minY: _minY,
      maxY: _maxY,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            // color: Color(0xff37434d),
            color: const Color(0xd5d5d5ff),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            // color: Color(0xff37434d),
            color: const Color(0xd5d5d5ff),

            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          // sideTitles: true,
          // reservedSize: 22,
          // textStyle: TextStyle(
          //     color: const Color(0xff68737d),
          //     fontWeight: FontWeight.bold,
          //     fontSize: 13),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            // getTitlesWidget: (value) {
            //   if (value % 2 == 1)
            //     return DateFormat('MMM').format(DateTime(0, value.toInt()));
            //   return null;
            // },
          ),
        ),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 0,
        )
            // textStyle: TextStyle(
            //   color: const Color(0xff67727d),
            //   fontWeight: FontWeight.bold,
            //   fontSize: 15,
            // ),
            // getTitles: (value) {
            //   // return '${value.toInt()}';
            //   return null;
            // },
            // reservedSize: 0,
            // margin: 12,
            ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueAccent,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              return LineTooltipItem(
                NumberFormat.simpleCurrency().format((flSpot.y * chartScale)),
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
        touchCallback: (FlTouchEvent te, LineTouchResponse? res) {
          for (var spot in res!.lineBarSpots!) {
            widget.onSelectMonth!(
                month: spot.x.toInt(), sumOfPrice: spot.y * chartScale);
          }
        },
      ),
      lineBarsData: [
        LineChartBarData(
          spots: _spots,
          isCurved: false,
          // colors: gradientColors,
          color: gradientColors.single,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            // colors:
            //     gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            color: gradientColors.single,
          ),
        ),
      ],
    );
  }
}

class Tuple {
  final double price;
  final int month;
  const Tuple({required this.price, required this.month});
}

class ChartValues {
  late double minPrice;
  late double maxPrice;
  List<Tuple> tupleValues = [];

  ChartValues(Map<String, double> items) {
    List<double> priceList = [];
    items.forEach((String month, double price) {
      priceList.add(price);
      tupleValues.add(Tuple(price: price, month: int.parse(month)));
    });
    minPrice = priceList.reduce(min);
    maxPrice = priceList.reduce(max);
  }
}

Map<String, double> mapValues(List<LedgerItemModel> items) {
  /// shape of { 'month': price, 'month': price, ... }
  Map<String, double> returnVal = {
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
    '6': 0,
    '7': 0,
    '8': 0,
    '9': 0,
    '10': 0,
    '11': 0,
    '12': 0,
  };

  for (LedgerItemModel item in items) {
    returnVal[item.selectedDate!.month.toString()] =
        item.price!.abs() + returnVal[item.selectedDate!.month.toString()]!;
  }

  return returnVal;
}
