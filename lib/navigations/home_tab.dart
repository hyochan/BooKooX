import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/home_calendar.dart' show HomeCalendar;
import 'package:wecount/screens/home_list.dart' show HomeList;
import 'package:wecount/screens/home_statistic/home_statistic.dart'
    show HomeStatistic;
import 'package:wecount/screens/home_setting.dart' show HomeSetting;

class HomeTab extends StatefulWidget {
  static const String name = '/home_tab';

  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    String title = Provider.of<CurrentLedger>(context).title ?? '';

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _index != 0,
            child: TickerMode(
              enabled: _index == 0,
              child: HomeCalendar(
                title: title,
              ),
            ),
          ),
          Offstage(
            offstage: _index != 1,
            child: TickerMode(
              enabled: _index == 1,
              child: const HomeList(),
            ),
          ),
          Offstage(
            offstage: _index != 2,
            child: TickerMode(
              enabled: _index == 2,
              child: HomeStatistic(title: title),
            ),
          ),
          Offstage(
            offstage: _index != 3,
            child: TickerMode(
              enabled: _index == 3,
              child: HomeSetting(
                title: title,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
        selectedItemColor: Theme.of(context).textTheme.headline1!.color,
        unselectedItemColor: Theme.of(context).textTheme.headline1!.color,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: const Icon(
              Icons.calendar_today,
              size: 20.0,
            ),
            label: 'Monthly',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: const Icon(
              Icons.list,
              size: 20.0,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: const Icon(
              Icons.graphic_eq,
              size: 20.0,
            ),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            icon: const Icon(
              Icons.settings,
              size: 20.0,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
