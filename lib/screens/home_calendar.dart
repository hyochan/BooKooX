import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';
import 'package:wecount/controllers/ledger_controller.dart';
import 'package:wecount/mocks/home_calendar.mock.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/ledger_item_edit.dart';
import 'package:wecount/screens/ledgers.dart';
import 'package:wecount/shared/date_selector.dart' show DateSelector;
import 'package:wecount/shared/home_header.dart' show HomeHeaderExpanded;
import 'package:wecount/shared/home_list_item.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/colors.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  final LedgerController _ledgerController = Get.put(LedgerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Obx(
        () => CustomScrollView(
          slivers: <Widget>[
            HomeHeaderExpanded(
              title: _ledgerController.selectedLedger.value!.title,
              color: getColor(_ledgerController.selectedLedger.value!.color),
              actions: [
                SizedBox(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: const EdgeInsets.all(0.0),
                    shape: const CircleBorder(),
                    onPressed: () => Get.to(
                      () => const Ledgers(),
                    ),
                    child: const Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: const EdgeInsets.all(0.0),
                    shape: const CircleBorder(),
                    onPressed: () => Get.to(
                      () => const LedgerItemEdit(),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const MyHomePage(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _currentDate;
  DateTime? _targetDate;
  String _currentMonth = '';

  EventList<Event>? _markedDateMap;

  /// ledgerList from parents
  List<LedgerItemModel> _ledgerList = [];

  /// for bottom list UI
  final List<LedgerItemModel> _ledgerListOfSelectedDate = [];

  void selectDate(
    DateTime date,
  ) {
    _ledgerListOfSelectedDate.clear();
    for (var item in _ledgerList) {
      if (item.selectedDate == date) {
        _ledgerListOfSelectedDate.add(item);
      }
    }
    setState(() {
      _currentDate = date;
      _targetDate = DateTime(date.year, date.month);
      _currentMonth = DateFormat.yMMM().format(date);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _targetDate = DateTime.now();
    _currentMonth = DateFormat.yMMM().format(_currentDate!);

    Future.delayed(Duration.zero, () {
      List<LedgerItemModel> ledgerList = createCalendarLedgerItemMock();
      EventList<Event>? markedDateMap = EventList(events: {});

      for (var ledger in ledgerList) {
        markedDateMap.add(
          ledger.selectedDate!,
          Event(
            date: ledger.selectedDate!,
            title: ledger.category!.label,
          ),
        );
      }

      setState(() {
        _ledgerList = ledgerList;
        _markedDateMap = markedDateMap;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).ledger != null
        ? Provider.of<CurrentLedger>(context).ledger!.color
        : ColorType.dusk;

    void onDatePressed() async {
      int year = _currentDate!.year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: _currentDate!,
        firstDate: DateTime(prevDate),
        lastDate: DateTime(lastDate),
      );
      if (pickDate != null) {
        selectDate(pickDate);
      }
    }

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: <Widget>[
            DateSelector(
              date: _currentMonth,
              onDatePressed: onDatePressed,
            ),
            renderCalendar(
              context: context,
              onCalendarChanged: (DateTime date) {
                setState(() {
                  _currentMonth = DateFormat.yMMM().format(date);
                  _targetDate = date;
                });
              },
              onDayPressed: (DateTime date, List<Event> events) {
                selectDate(date);
              },
              markedDateMap: _markedDateMap,
              currentDate: _currentDate,
              targetDate: _targetDate,
              color: getColor(color),
            ),
            const Divider(
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: _ledgerListOfSelectedDate.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeListItem(
                    ledgerItem: _ledgerListOfSelectedDate[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget renderCalendar({
  required BuildContext context,
  Function? onCalendarChanged,
  Function? onDayPressed,
  EventList<Event>? markedDateMap,
  DateTime? currentDate,
  DateTime? targetDate,
  required Color color,
}) {
  return CalendarCarousel<Event>(
    onCalendarChanged: onCalendarChanged as dynamic Function(DateTime)?,
    onDayPressed: onDayPressed as dynamic Function(DateTime, List<Event>)?,

    /// make calendar to be scrollable together with its screen
    customGridViewPhysics: const NeverScrollableScrollPhysics(),

    /// marked Date
    markedDatesMap: markedDateMap,
    markedDateShowIcon: true,
    markedDateIconMaxShown: 1,
    markedDateIconBuilder: (event) {
      return renderMarkedIcon(
        color: Theme.of(context).colorScheme.secondary,
        context: context,
      );
    },

    /// selected date
    selectedDayButtonColor: color,
    selectedDateTime: currentDate,
    selectedDayTextStyle: const TextStyle(
      color: Colors.white,
    ),

    pageSnapping: true,
    weekFormat: false,
    showHeader: false,
    thisMonthDayBorderColor: Colors.grey,
    height:
        MediaQuery.of(context).orientation == Orientation.portrait ? 380 : 490,
    childAspectRatio:
        MediaQuery.of(context).orientation == Orientation.portrait ? 1.0 : 1.5,
    targetDateTime: targetDate,

    /// weekday
    weekdayTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
    weekendTextStyle: TextStyle(
      color: Theme.of(context).primaryColorLight,
    ),
    daysTextStyle:
        TextStyle(color: Theme.of(context).textTheme.headline1!.color),
    todayBorderColor: Colors.green,
    todayTextStyle: TextStyle(
      color: Theme.of(context).primaryColor,
    ),
    todayButtonColor: Theme.of(context).hintColor,
    minSelectedDate: DateTime(1970, 1, 1),
    maxSelectedDate: DateTime.now().add(const Duration(days: 3650)),
  );
}

Widget renderMarkedIcon({required Color color, required BuildContext context}) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: 7,
        right:
            MediaQuery.of(context).orientation == Orientation.portrait ? 0 : 15,
        height: 5,
        width: 5,
        child: CustomPaint(painter: DrawCircle(color: color)),
      )
    ],
  );
}

class DrawCircle extends CustomPainter {
  late Paint _paint;

  DrawCircle({required Color color}) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(0.0, 0.0), 3.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
