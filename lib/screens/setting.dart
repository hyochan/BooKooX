import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecount/screens/lock_auth.dart';
import 'package:wecount/screens/lock_register.dart';
import 'package:wecount/screens/setting_announcement.dart';
import 'package:wecount/screens/setting_faq.dart';
import 'package:wecount/screens/setting_notification.dart';
import 'package:wecount/screens/setting_opinion.dart';
import 'package:wecount/screens/tutorial.dart';
import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/setting_list_item.dart'
    show ListItem, LogoutItem, SettingItem, SettingListItem;
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart' show General;

import '../utils/localization.dart';
import '../utils/logger.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Setting extends StatefulWidget {
  static const String name = '/setting';

  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _lockSwitch = false;

  readLockPinFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('LOCK_PIN')) {
      logger.d(prefs.getString('LOCK_PIN'));

      setState(() {
        _lockSwitch = true;
      });
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
    await General.instance.navigateScreenNamed(context, LockRegister.name);

    setState(() {
      readLockPinFromSF();
    });
  }

  void _awaitLockAuth(BuildContext context) async {
    final result =
        await General.instance.navigateScreenNamed(context, LockAuth.name);

    setState(() {
      if (_lockSwitch == true && result == false) {
        _lockSwitch = false;
        resetLockPinToSF();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ListItem> items = [
      SettingItem(
        const Icon(
          Icons.announcement,
          color: cloudyBlueColor,
          size: 24,
        ),
        t('ANNOUNCEMENT'),
        onPressed: () => General.instance
            .navigateScreenNamed(context, SettingAnnouncement.name),
      ),
      SettingItem(
        const Icon(
          Icons.message,
          color: cloudyBlueColor,
          size: 24,
        ),
        t('SHARE_OPINION'),
        onPressed: () =>
            General.instance.navigateScreenNamed(context, SettingOpinion.name),
      ),
      SettingItem(
        const Icon(
          Icons.question_answer,
          color: cloudyBlueColor,
          size: 24,
        ),
        t('FAQ'),
        onPressed: () =>
            General.instance.navigateScreenNamed(context, SettingFAQ.name),
      ),
      SettingItem(
        const Icon(
          Icons.notifications,
          color: cloudyBlueColor,
          size: 24,
        ),
        t('NOTIFICATION'),
        onPressed: () => General.instance
            .navigateScreenNamed(context, SettingNotification.name),
      ),
      SettingItem(
        const Icon(
          Icons.lock,
          color: cloudyBlueColor,
          size: 24,
        ),
        t('LOCK'),
        optionalWidget: Switch(
          value: _lockSwitch,
          onChanged: _onChangeLock,
          activeTrackColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      LogoutItem(
        t('LOGOUT'),
        onPressed: () {
          _auth.signOut();

          /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
          General.instance
              .navigateScreenNamed(context, Tutorial.name, reset: true);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  if (item is LogoutItem) {
                    return Container(
                      height: 72,
                      margin: const EdgeInsets.only(bottom: 40),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: item.onPressed as void Function()?,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: <Widget>[
                            Text(
                              item.title!,
                              style: const TextStyle(
                                color: carnationColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Row(
                children: const <Widget>[
                  Text(
                    'Version ',
                    style: TextStyle(
                      color: cloudyBlueColor,
                    ),
                  ),
                  Text(
                    '17.13(1246)',
                    style: TextStyle(
                      color: cloudyBlueColor,
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
