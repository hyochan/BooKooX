import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/setting_list_item.dart'
    show ListItem, LogoutItem, SettingItem, SettingListItem;
import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/localization.dart' show Localization;

FirebaseAuth _auth = FirebaseAuth.instance;

class Setting extends HookWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lockSwitch = useState<bool>(false);
    var pin = useState<String?>('');

    readLockPinFromSF() async {
      SharedPreferences preference = await SharedPreferences.getInstance();

      if (preference.containsKey('LOCK_PIN')) {
        pin.value = preference.getString('LOCK_PIN');
        lockSwitch.value = true;

        logger.d(pin);
      }
    }

    resetLockPinToSF() async {
      SharedPreferences preference = await SharedPreferences.getInstance();
      preference.remove('LOCK_PIN');
    }

    void registerLockAsync(BuildContext context) async {
      await navigation.push(context, AppRoute.lockRegister.path);
    }

    useEffect(() {
      readLockPinFromSF();
      return null;
    }, []);

    void lockAuthAsync(BuildContext context) async {
      final result = await navigation.push(context, AppRoute.lockAuth.path);

      if (lockSwitch.value == true && result == false) {
        lockSwitch.value = false;
        resetLockPinToSF();
      }
    }

    void onChangeLock(bool value) {
      if (lockSwitch.value == false && value) {
        registerLockAsync(context);
      } else {
        lockAuthAsync(context);
      }
    }

    var localization = Localization.of(context)!;
    final List<ListItem> items = [
      SettingItem(
        const Icon(
          Icons.announcement,
          color: asset.Colors.cloudyBlue,
          size: 24,
        ),
        localization.trans('ANNOUNCEMENT'),
        onPressed: () =>
            navigation.push(context, AppRoute.settingAnnouncement.path),
      ),
      SettingItem(
        const Icon(
          Icons.message,
          color: asset.Colors.cloudyBlue,
          size: 24,
        ),
        localization.trans('SHARE_OPINION'),
        onPressed: () => navigation.push(context, AppRoute.settingOpinion.path),
      ),
      SettingItem(
        const Icon(
          Icons.question_answer,
          color: asset.Colors.cloudyBlue,
          size: 24,
        ),
        localization.trans('FAQ'),
        onPressed: () => navigation.push(context, AppRoute.settingFAQ.path),
      ),
      SettingItem(
        const Icon(
          Icons.notifications,
          color: asset.Colors.cloudyBlue,
          size: 24,
        ),
        localization.trans('NOTIFICATION'),
        onPressed: () =>
            navigation.push(context, AppRoute.settingNotification.path),
      ),
      SettingItem(
        const Icon(
          Icons.lock,
          color: asset.Colors.cloudyBlue,
          size: 24,
        ),
        localization.trans('LOCK'),
        optionalWidget: Switch(
          inactiveTrackColor: asset.Colors.main,
          value: lockSwitch.value,
          onChanged: onChangeLock,
          activeTrackColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      LogoutItem(
        localization.trans('LOGOUT'),
        onPressed: () {
          General.instance.showConfirmDialog(
            context,
            title: Text(localization.trans('NOTIFICATION')!),
            content: Text(localization.trans('SIGN_OUT_ASK')!),
            cancelPressed: () => Navigator.of(context).pop(),
            okPressed: () {
              _auth.signOut();

              /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
              navigation.push(context, AppRoute.tutorial.path, reset: true);
            },
          );
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    if (item is LogoutItem) {
                      return Container(
                        height: 72,
                        margin: const EdgeInsets.only(bottom: 40),
                        child: TextButton(
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.all(0),
                            ),
                          ),
                          onPressed: item.onPressed as void Function()?,
                          child: Row(
                            children: <Widget>[
                              Text(
                                item.title!,
                                style: const TextStyle(
                                  color: asset.Colors.carnation,
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Row(
                children: const <Widget>[
                  Text(
                    'Version ',
                    style: TextStyle(
                      color: asset.Colors.cloudyBlue,
                    ),
                  ),
                  Text(
                    '17.13(1246)',
                    style: TextStyle(
                      color: asset.Colors.cloudyBlue,
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
