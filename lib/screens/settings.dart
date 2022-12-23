import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/setting_list_item.dart'
    show ListItem, LogoutItem, SettingItem, SettingListItem;
import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/localization.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Settings extends HookWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lockSwitch = useState<bool>(false);
    var pin = useState<String?>('');

    Future<void> readLockPinFromSF() async {
      SharedPreferences preference = await SharedPreferences.getInstance();

      if (context.mounted && preference.containsKey('LOCK_PIN')) {
        pin.value = preference.getString('LOCK_PIN');
        lockSwitch.value = true;

        logger.d(pin);
      }
    }

    Future<void> resetLockPinToSF() async {
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

      if (context.mounted && result != null) {
        if (lockSwitch.value == true && result == false) {
          lockSwitch.value = false;
          resetLockPinToSF();
        }
      }
    }

    void onChangeLock(bool value) {
      if (lockSwitch.value == false && value) {
        registerLockAsync(context);
      } else {
        lockAuthAsync(context);
      }
    }

    final List<ListItem> items = [
      SettingItem(
        Icon(
          Icons.announcement,
          color: AppColors.role.info,
          size: 24,
        ),
        localization(context).announcement,
        onPressed: () =>
            navigation.push(context, AppRoute.settingAnnouncement.path),
      ),
      SettingItem(
        Icon(
          Icons.message,
          color: AppColors.role.info,
          size: 24,
        ),
        localization(context).shareOpinion,
        onPressed: () => navigation.push(context, AppRoute.settingOpinion.path),
      ),
      SettingItem(
        Icon(
          Icons.question_answer,
          color: AppColors.role.info,
          size: 24,
        ),
        localization(context).faq,
        onPressed: () => navigation.push(context, AppRoute.settingFAQ.path),
      ),
      SettingItem(
        Icon(
          Icons.notifications,
          color: AppColors.role.info,
          size: 24,
        ),
        localization(context).notification,
        onPressed: () =>
            navigation.push(context, AppRoute.settingNotification.path),
      ),
      SettingItem(
        Icon(
          Icons.lock,
          color: AppColors.role.info,
          size: 24,
        ),
        localization(context).lock,
        optionalWidget: Switch(
          inactiveTrackColor: asset.Colors.main,
          value: lockSwitch.value,
          onChanged: onChangeLock,
          activeTrackColor: AppColors.role.primary,
          activeColor: AppColors.role.secondary,
        ),
      ),
      LogoutItem(
        localization(context).logout,
        onPress: () {
          General.instance.showConfirmDialog(
            context,
            title: Text(localization(context).notification),
            content: Text(localization(context).signOutAsk),
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
      backgroundColor: AppColors.bg.basic,
      appBar: renderHeaderBack(
        context: context,
        iconColor: AppColors.role.secondary,
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
                          onPressed: item.onPress,
                          child: Row(
                            children: <Widget>[
                              Text(
                                item.title!,
                                style: TextStyle(
                                  color: AppColors.role.danger,
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
                children: <Widget>[
                  Text(
                    'Version ',
                    style: TextStyle(
                      color: AppColors.role.info,
                    ),
                  ),
                  Text(
                    '17.13(1246)',
                    style: TextStyle(
                      color: AppColors.role.info,
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
