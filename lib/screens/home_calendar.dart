import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/mocks/home_calendar.mock.dart';
import 'package:wecount/models/ledger.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/repositories/ledger_repository.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/common/loading_indicator.dart';
import 'package:wecount/widgets/date_selector.dart' show DateSelector;
import 'package:wecount/widgets/home_list_item.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:flutter/material.dart';
import 'package:wecount/utils/asset.dart' as Asset;

import 'package:wecount/widgets/home_header.dart' show HomeHeaderExpanded;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';

class HomeCalendar extends HookWidget {
  const HomeCalendar({
    super.key,
    this.title = '2022 WeCount',
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : null;

    var ledgerId = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.id
        : null;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: <Widget>[
          HomeHeaderExpanded(
            title: title,
            color: Asset.Colors.getColor(color),
            actions: [
              SizedBox(
                width: 56.0,
                child: RawMaterialButton(
                  padding: const EdgeInsets.all(0.0),
                  shape: const CircleBorder(),
                  onPressed: () =>
                      navigation.push(context, AppRoute.ledgers.path),
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
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoute.ledgerItemEdit.fullPath),
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
              MyHomePage(ledgerId: ledgerId),
            ]),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, this.ledgerId});

  final String? ledgerId;

  @override
  Widget build(BuildContext context) {
    var currentDate = useState<DateTime?>(DateTime.now());
    var targetDate = useState<DateTime?>(DateTime.now());
    var currentMonth = useState<String>("");

    var markedDateMap0 = useState<EventList<Event>?>(null);

    /// ledgerList from parents
    var ledgerList0 = useState<List<LedgerItem>>([]);

    /// for bottom list UI
    var ledgerListOfSelectedDate = useState<List<LedgerItem>>([]);

    void selectDate(
      DateTime date,
    ) async {
      ledgerListOfSelectedDate.value = [];

      for (var item in ledgerList0.value) {
        if (item.selectedDate == date) {
          ledgerListOfSelectedDate.value = [
            ...ledgerListOfSelectedDate.value,
            item
          ];
        }
      }
      currentDate.value = date;
      targetDate.value = DateTime(date.year, date.month);
      currentMonth.value = DateFormat.yMMM().format(date);
    }

    useEffect(() {
      currentDate.value = DateTime.now();
      targetDate.value = DateTime.now();
      currentMonth.value = DateFormat.yMMM().format(currentDate.value!);

      Future.delayed(
        Duration.zero,
        () async {
          var localization = Localization.of(context)!;

          List<LedgerItem>? ledgerList =
              await LedgerRepository.instance.getLedgerItems();

          if (ledgerList == null) {
            return null;
          }

          EventList<Event>? markedDateMap = EventList(events: {});
          for (var ledger in ledgerList) {
            markedDateMap.add(
                ledger.selectedDate!,
                Event(
                    date: ledger.selectedDate!, title: ledger.category!.label));
          }

          ledgerList0.value = ledgerList;
          markedDateMap0.value = markedDateMap;
          ledgerListOfSelectedDate.value = [];
          for (var item in ledgerList) {
            if (item.selectedDate?.day == DateTime.now().day) {
              ledgerListOfSelectedDate.value = [
                ...ledgerListOfSelectedDate.value,
                item
              ];
            }
          }
        },
      );
      return null;
    }, [ledgerId]);

    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : ColorType.DUSK;

    void onDatePressed() async {
      int year = currentDate.value!.year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: currentDate.value!,
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
              date: currentMonth.value,
              onDatePressed: onDatePressed,
            ),
            renderCalendar(
              context: context,
              onCalendarChanged: (DateTime date) {
                currentMonth.value = DateFormat.yMMM().format(date);
                targetDate.value = date;
              },
              onDayPressed: (DateTime date, List<Event> events) {
                selectDate(date);
              },
              markedDateMap: markedDateMap0.value,
              currentDate: currentDate.value,
              targetDate: targetDate.value,
              color: Asset.Colors.getColor(color),
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
              itemCount: ledgerListOfSelectedDate.value.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeListItem(
                    ledgerItem: ledgerListOfSelectedDate.value[index]);
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
          color: Theme.of(context).colorScheme.secondary, context: context);
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
        TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
    todayBorderColor: Colors.green,
    todayTextStyle: TextStyle(
      color: color,
    ),
    todayButtonColor: Theme.of(context).highlightColor,
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
