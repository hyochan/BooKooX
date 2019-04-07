import 'package:flutter/material.dart';

import '../screens/home_calendar.dart' show HomeCalendar;
import '../screens/home_list.dart' show HomeList;
import '../screens/home_statistic.dart' show HomeStatistic;

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
              child: HomeStatistic(),
            ),
          ),
          Offstage(
            offstage: _index != 2,
            child: TickerMode(
              enabled: _index == 2,
              child: HomeList(),
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
            backgroundColor: Theme.Colors.mediumGray,
            icon: Icon(
              Icons.person,
              size: 32.0,
            ),
            title: Container(
              child: Text('Message'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32.0,
            ),
            title: Container(
              child: Text('Favorite'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32.0,
            ),
            title: Container(
              child: Text('Setting'),
            ),
          ),
        ],
      ),
    );
  }
}
