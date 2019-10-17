import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/shared/home_list_item.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter/material.dart';

import 'package:bookoo2/utils/general.dart';
import 'package:bookoo2/shared/home_header.dart' show HomeHeaderExpanded;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomeCalendar extends StatefulWidget {
  HomeCalendar({
    Key key,
    this.title = '2017 Bookoo',
  }) : super(key: key);
  final String title;

  @override
  _HomeCalendarState createState() => new _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            HomeHeaderExpanded(title: widget.title, actions: [
              Container(
                width: 56.0,
                child: RawMaterialButton(
                  padding: EdgeInsets.all(0.0),
                  shape: CircleBorder(),
                  onPressed: () =>
                      General.instance.navigateScreenNamed(context, '/ledgers'),
                  child: Icon(
                    Icons.book,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 56.0,
                child: RawMaterialButton(
                  padding: EdgeInsets.all(0.0),
                  shape: CircleBorder(),
                  onPressed: () => General.instance
                      .navigateScreenNamed(context, '/ledger_item_add'),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ];
        },
        controller: _scrollController,
        body: Container(
          child: new MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime.now();
  String _currentMonth = '';

  EventList<Event> _markedDateMap = new EventList<Event>();

  CalendarCarousel _calendarCarouselNoHeader;

  /// ledgerList from parents
  List<LedgerItem> _ledgerList = new List<LedgerItem>();

  /// for bottom list UI
  List<LedgerItem> _ledgerListOfSelectedDate = new List<LedgerItem>();

  void selectDate(
    DateTime date,
  ) {
    setState(() {
      _currentDate = date;
      _ledgerListOfSelectedDate.clear();
      _ledgerList.forEach((item) {
        if (item.selectedDate == date) {
          _ledgerListOfSelectedDate.add(item);
        }
      });
    });
    print(_ledgerListOfSelectedDate.length);
    _currentMonth = DateFormat.yMMM().format(date);
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      var _localization = Localization.of(context);

      _ledgerList.add(new LedgerItem(
          price: -12000,
          category: Category(
              iconId: 8,
              label: _localization.trans('EXERCISE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: 300000,
          category: Category(
              iconId: 18,
              label: _localization.trans('WALLET_MONEY'),
              type: CategoryType.INCOME),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: -32000,
          category: Category(
              iconId: 4,
              label: _localization.trans('DATING'),
              type: CategoryType.CONSUME),
          memo: 'who1 gave me',
          writer: new User(uid: 'who1@gmail.com', displayName: 'hello'),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: -3100,
          category: Category(
              iconId: 0,
              label: _localization.trans('CAFE'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, _currentDate.month, 10)));
      _ledgerList.add(new LedgerItem(
          price: -12000,
          category: Category(
              iconId: 12,
              label: _localization.trans('PRESENT'),
              type: CategoryType.CONSUME),
          selectedDate: new DateTime(2019, _currentDate.month, 15)));

      _ledgerList.forEach((ledger) {
        _markedDateMap.add(ledger.selectedDate,
            new Event(date: ledger.selectedDate, title: ledger.category.label));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void onDatePressed() async {
      int year = this._currentDate.year;
      int prevDate = year - 100;
      int lastDate = year + 10;
      DateTime pickDate = await showDatePicker(
        context: context,
        initialDate: this._currentDate,
        firstDate: DateTime(prevDate),
        lastDate: DateTime(lastDate),
      );
      if (pickDate != null) {
        this.selectDate(pickDate);
      }
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
      onDayPressed: (DateTime date, List<Event> events) {
        this.selectDate(date);
        events.forEach((event) => print(event.title));
      },
      isScrollable: true,

      /// make calendar to be scrollable together with its screen
      customGridViewPhysics: NeverScrollableScrollPhysics(),

      /// marked Date
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateIconBuilder: (event) {
        return markedIcon(
            color: Theme.of(context).accentColor, context: context);
      },

      /// selected date
      selectedDayButtonColor: Theme.of(context).primaryColor,
      selectedDateTime: _currentDate,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),

      /// styles
      showOnlyCurrentMonthDate: false,
      weekFormat: false,
      showHeader: false,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? 350
          : 400,
      thisMonthDayBorderColor: Colors.grey,
      childAspectRatio:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? 1.0
              : 1.5,

      /// weekday
      weekdayTextStyle: TextStyle(color: Theme.of(context).primaryColorLight),
      weekendTextStyle: TextStyle(
        color: Theme.of(context).primaryColorLight,
      ),
      daysTextStyle: TextStyle(color: Theme.of(context).textTheme.title.color),
      todayBorderColor: Colors.green,
      todayTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      todayButtonColor: Theme.of(context).hintColor,
    );

    return SafeArea(
      top: false,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 12.0,
              right: 16.0,
            ),
            child: new Row(
              children: <Widget>[
                Text(
                  _currentMonth,
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
          ),
          Container(
            child: _calendarCarouselNoHeader,
          ),
          Divider(
            color: Colors.grey,
            indent: 10,
            endIndent: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: _ledgerListOfSelectedDate.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeListItem(ledgerItem: _ledgerListOfSelectedDate[index]);
            },
          ),
        ],
      ),
    );
  }
}

Widget markedIcon({Color color, BuildContext context}) {
  return new Container(
    child: Stack(
      children: <Widget>[
        Positioned(
          child: CustomPaint(painter: DrawCircle(color: color)),
          top: 7,
          right: MediaQuery.of(context).orientation == Orientation.portrait
              ? 0
              : 15,
          height: 5,
          width: 5,
        )
      ],
    ),
  );
}

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle({Color color}) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 3.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
