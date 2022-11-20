import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/setting_list_item.dart'
    show ListItem, LogoutItem, SettingItem, SettingListItem;
import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/utils/localization.dart' show Localization;

FirebaseAuth _auth = FirebaseAuth.instance;

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _lockSwitch = false;
  String? _pin = '';

  readLockPinFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('LOCK_PIN')) {
      _pin = prefs.getString('LOCK_PIN');
      setState(() {
        _lockSwitch = true;
      });

      print(_pin);
    }
  }

  resetLockPinToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('LOCK_PIN');
  }

  @override
  void initState() {
    super.initState();
    readLockPinFromSF();
  }

  void _onChangeLock(bool value) {
    if (_lockSwitch == false && value) {
      _awaitLockRegister(context);
    } else {
      _awaitLockAuth(context);
    }
  }

  void _awaitLockRegister(BuildContext context) async {
    await navigation.push(context, AppRoute.lockRegister.fullPath);

    setState(() {
      readLockPinFromSF();
    });
  }

  void _awaitLockAuth(BuildContext context) async {
    final result = await navigation.push(context, AppRoute.lockAuth.fullPath);

    setState(() {
      if (_lockSwitch == true && result == false) {
        _lockSwitch = false;
        resetLockPinToSF();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;
    final List<ListItem> _items = [
      SettingItem(
        Icon(
          Icons.announcement,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('ANNOUNCEMENT'),
        onPressed: () =>
            navigation.push(context, AppRoute.settingAnnouncement.fullPath),
      ),
      SettingItem(
        Icon(
          Icons.message,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('SHARE_OPINION'),
        onPressed: () =>
            navigation.push(context, AppRoute.settingOpinion.fullPath),
      ),
      SettingItem(
        Icon(
          Icons.question_answer,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('FAQ'),
        onPressed: () => navigation.push(context, AppRoute.settingFAQ.fullPath),
      ),
      SettingItem(
        Icon(
          Icons.notifications,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('NOTIFICATION'),
        onPressed: () =>
            navigation.push(context, AppRoute.settingNotification.fullPath),
      ),
      SettingItem(
        Icon(
          Icons.lock,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('LOCK'),
        optionalWidget: Switch(
          value: _lockSwitch,
          onChanged: _onChangeLock,
          activeTrackColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).accentColor,
        ),
      ),
      LogoutItem(
        _localization.trans('LOGOUT'),
        onPressed: () {
          _auth.signOut();

          /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
          navigation.push(context, AppRoute.tutorial.fullPath, reset: true);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  if (item is LogoutItem) {
                    return Container(
                      height: 72,
                      margin: EdgeInsets.only(bottom: 40),
                      child: TextButton(
                        onPressed: item.onPressed as void Function()?,
                        child: Row(
                          children: <Widget>[
                            Text(
                              item.title!,
                              style: TextStyle(
                                color: Asset.Colors.carnation,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SettingListItem(item as SettingItem);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    'Version ',
                    style: TextStyle(
                      color: Asset.Colors.cloudyBlue,
                    ),
                  ),
                  Text(
                    '17.13(1246)',
                    style: TextStyle(
                      color: Asset.Colors.cloudyBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
