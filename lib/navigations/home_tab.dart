import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/controllers/ledger_controller.dart';
import 'package:wecount/screens/home_calendar.dart' show HomeCalendar;
import 'package:wecount/screens/home_list.dart' show HomeList;
import 'package:wecount/screens/home_setting.dart' show HomeSetting;
import 'package:wecount/screens/home_statistic/home_statistic.dart'
    show HomeStatistic;
import 'package:wecount/screens/main_empty.dart';
import 'package:wecount/shared/circle_loading_indicator.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class HomeTab extends StatefulWidget {
  static const String name = '/home_tab';

  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _index = 0;
  final UserController _userController = Get.put(UserController());
  final LedgerController _ledgerController = Get.put(LedgerController());
  bool _isSelectedLedgerLoading = true;

  @override
  void initState() {
    super.initState();
    _addUserListener();
  }

  void _addUserListener() {
    _userController.listenUser((DocumentSnapshot<UserModel> snapshot) async {
      setState(() => _isSelectedLedgerLoading = true);

      UserModel? user = snapshot.data();

      if (user != null) {
        _userController.user(user);
      }

      if (user?.selectedLedgerId != null &&
          user?.selectedLedgerId !=
              _ledgerController.selectedLedger.value?.id) {
        await _ledgerController.updateSelectedLedger(user!.selectedLedgerId!);
      }

      setState(() => _isSelectedLedgerLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isSelectedLedgerLoading
        ? const CircleLoadingIndicator()
        : Obx(
            () => _ledgerController.selectedLedger.value == null
                ? const MainEmpty()
                : Scaffold(
                    body: Stack(
                      children: <Widget>[
                        Offstage(
                          offstage: _index != 0,
                          child: TickerMode(
                            enabled: _index == 0,
                            child: const HomeCalendar(),
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
                            child: const HomeStatistic(title: ''),
                          ),
                        ),
                        Offstage(
                          offstage: _index != 3,
                          child: TickerMode(
                            enabled: _index == 3,
                            child: const HomeSetting(
                              title: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      type: BottomNavigationBarType.shifting,
                      currentIndex: _index,
                      onTap: (int index) => setState(() => _index = index),
                      selectedItemColor:
                          Theme.of(context).textTheme.headline1!.color,
                      unselectedItemColor:
                          Theme.of(context).textTheme.headline1!.color,
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
                  ),
          );
  }
}
