import 'package:flutter/material.dart';

import 'package:bookoox/screens/home_calendar.dart' show HomeCalendar;
import 'package:bookoox/screens/home_list.dart' show HomeList;
import 'package:bookoox/screens/home_statistic/home_statistic.dart' show HomeStatistic;
import 'package:bookoox/screens/home_setting.dart' show HomeSetting;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _index = 0;
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
        selectedItemColor: Theme.of(context).textTheme.headline.color,
        unselectedItemColor: Theme.of(context).textTheme.overline.color,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: Icon(
              Icons.calendar_today,
              size: 20.0,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Montly',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: Icon(
              Icons.list,
              size: 20.0,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'List',
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: Icon(
              Icons.graphic_eq,
              size: 20.0,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Statistic',
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: Icon(
              Icons.settings,
              size: 20.0,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Setting',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
