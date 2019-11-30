import 'package:flutter/material.dart';

import 'package:bookoo2/screens/home_calendar.dart' show HomeCalendar;
import 'package:bookoo2/screens/home_list.dart' show HomeList;
import 'package:bookoo2/screens/home_statistic/home_statistic.dart' show HomeStatistic;
import 'package:bookoo2/screens/home_setting.dart' show HomeSetting;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _index = 2;
  String _title = 'Dream Worker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _index != 0,
            child: TickerMode(
              enabled: _index == 0,
              child: HomeCalendar(
                title: _title,
              ),
            ),
          ),
          Offstage(
            offstage: _index != 1,
            child: TickerMode(
              enabled: _index == 1,
              child: HomeList(),
            ),
          ),
          Offstage(
            offstage: _index != 2,
            child: TickerMode(
              enabled: _index == 2,
              child: HomeStatistic(
                title: _title,
              ),
            ),
          ),
          Offstage(
            offstage: _index != 3,
            child: TickerMode(
              enabled: _index == 3,
              child: HomeSetting(
                title: _title,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (int index) { setState((){ this._index = index; }); },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(
              Icons.calendar_today,
              size: 20.0,
              color: Theme.of(context).textTheme.title.color,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Montly',
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              size: 20.0,
              color: Theme.of(context).textTheme.title.color,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'List',
                style: TextStyle(
                 color: Theme.of(context).textTheme.title.color,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.graphic_eq,
              size: 20.0,
              color: Theme.of(context).textTheme.title.color,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Statistic',
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20.0,
              color: Theme.of(context).textTheme.title.color,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Setting',
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
