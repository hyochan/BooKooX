import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/home_calendar.dart' show HomeCalendar;
import 'package:wecount/screens/home_list.dart' show HomeList;
import 'package:wecount/screens/home_statistic/home_statistic.dart'
    show HomeStatistic;
import 'package:wecount/screens/home_setting.dart' show HomeSetting;

class HomeTab extends HookWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = useState<int>(0);

    String title = Provider.of<CurrentLedger>(context).getTitle() ?? '';
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: index.value != 0,
            child: TickerMode(
              enabled: index.value == 0,
              child: HomeCalendar(
                title: title,
              ),
            ),
          ),
          Offstage(
            offstage: index.value != 1,
            child: TickerMode(
              enabled: index.value == 1,
              child: const HomeList(),
            ),
          ),
          Offstage(
            offstage: index.value != 2,
            child: TickerMode(
              enabled: index.value == 2,
              child: HomeStatistic(title: title),
            ),
          ),
          Offstage(
            offstage: index.value != 3,
            child: TickerMode(
              enabled: index.value == 3,
              child: HomeSetting(
                title: title,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: index.value,
        onTap: (int tapIndex) => index.value = tapIndex,
        selectedItemColor: Theme.of(context).textTheme.displayLarge!.color,
        unselectedItemColor: Theme.of(context).textTheme.displayLarge!.color,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: const Icon(
              Icons.calendar_today,
              size: 20.0,
            ),
            label: 'Monthly',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: const Icon(
              Icons.list,
              size: 20.0,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            icon: const Icon(
              Icons.graphic_eq,
              size: 20.0,
            ),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
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
