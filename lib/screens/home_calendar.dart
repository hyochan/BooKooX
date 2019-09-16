import 'package:bookoo2/models/Category.dart';
import 'package:bookoo2/models/LedgerItem.dart';
import 'package:bookoo2/models/User.dart';
import 'package:bookoo2/shared/home_list_item.dart';
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
    this.title = '',
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
                Container(
                  width: 56.0,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(0.0),
                    shape: CircleBorder(),
                    onPressed: () => General.instance.navigateScreenNamed(context, '/ledger_item_add'),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ];
        },
        controller: _scrollController,
        body: Center(
          child: new MyHomePage(title: '2017 국문학과'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = '';

  EventList<Event> _markedDateMap = new EventList<Event>();

  CalendarCarousel _calendarCarouselNoHeader;

  /// ledgerList from parents
  List<LedgerItem> _ledgerList = new List<LedgerItem>();

  /// for bottom list UI
  List<LedgerItem> _ledgerListOfSelectedDate = new List<LedgerItem>();

  void selectDate(
    DateTime date,
    List<Event> events,
  ) {
    setState(() {
      _currentDate2 = date;
      _ledgerListOfSelectedDate.clear();
      _ledgerList.forEach((item) {
        if (item.selectedDate == date) {
          _ledgerListOfSelectedDate.add(item);
        }
      });
    });
    events.forEach((event) => print(event.title));
    print(_ledgerListOfSelectedDate.length);
  }

  @override
  void initState() {
    _ledgerList.add(new LedgerItem(
        price: -12000,
        category: Category(iconId: 8, label: '운동', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: 300000,
        category: Category(iconId: 18, label: '용돈', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: -32000,
        category: Category(iconId: 4, label: '데이트', type: CategoryType.CONSUME),
        memo: 'who1 gave me',
        writer: new User(uid: 'who1@gmail.com'),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: -3100,
        category: Category(iconId: 0, label: '커피', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: -3100,
        category: Category(iconId: 0, label: '커피', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: -3100,
        category: Category(iconId: 0, label: '커피', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: -3100,
        category: Category(iconId: 0, label: '커피', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 10)));
    _ledgerList.add(new LedgerItem(
        price: -12000,
        category: Category(iconId: 12, label: '선물', type: CategoryType.CONSUME),
        selectedDate: new DateTime(2019, 2, 15)));

    _ledgerList.forEach((ledger) {
      _markedDateMap.add(ledger.selectedDate,
          new Event(date: ledger.selectedDate, title: ledger.category.label));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      weekdayTextStyle: TextStyle(color: Colors.grey),
      showOnlyCurrentMonthDate: true,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      // markedDateMoreShowTotal:
      //     false, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return markedIcon(color: Theme.of(context).primaryColor);
      },
      // selectedDayBorderColor: Theme.of(context).primaryColor,
      selectedDayButtonColor: Theme.of(context).primaryColor,
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.selectDate(date, events);
      },
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: 300.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ),
              Divider(
                color: Colors.grey,
                // thickness: 10,
                indent: 10,
                endIndent: 10,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: _ledgerListOfSelectedDate.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeListItem(ledgerItem: _ledgerListOfSelectedDate[index]);
                  },
                ),
              )
            ],
          ),
        ));
  }
}

Widget markedIcon({Color color}) {
  return new Container(
      child: Stack(
    children: <Widget>[
      Positioned(
        child: CustomPaint(painter: DrawCircle(color: color)),
        top: 7,
        right: 0,
        height: 5,
        width: 5,
      )
    ],
  ));
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
