import 'package:flutter/material.dart';

import '../screens/home_calendar.dart' show HomeCalendar;
import '../screens/home_list.dart' show HomeList;
import '../screens/home_statistic.dart' show HomeStatistic;
import '../screens/home_setting.dart' show HomeSetting;

import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TabController _tabController;
  int _index = 0;
  var _localization;

  @override
  Widget build(BuildContext context) {
    _localization = Localization.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _index != 0,
            child: TickerMode(
              enabled: _index == 0,
              child: HomeCalendar(),
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
              child: HomeStatistic(),
            ),
          ),
          Offstage(
            offstage: _index != 3,
            child: TickerMode(
              enabled: _index == 3,
              child: HomeSetting(),
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
            backgroundColor: Theme.Colors.whiteGray,
            icon: Icon(
              Icons.calendar_today,
              size: 20.0,
              color: Theme.Colors.dusk,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Montly',
                style: TextStyle(
                  color: Theme.Colors.dusk,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              size: 20.0,
              color: Theme.Colors.dusk,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'List',
                style: TextStyle(
                  color: Theme.Colors.dusk,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.graphic_eq,
              size: 20.0,
              color: Theme.Colors.dusk,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Statistic',
                style: TextStyle(
                  color: Theme.Colors.dusk,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20.0,
              color: Theme.Colors.dusk,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                'Setting',
                style: TextStyle(
                  color: Theme.Colors.dusk,
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
