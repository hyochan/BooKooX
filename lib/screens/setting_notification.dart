import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/logger.dart';

import 'package:wecount/widgets/header.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as asset;

class SettingNotification extends HookWidget {
  const SettingNotification({super.key});

  @override
  Widget build(BuildContext context) {
    var addLedgerSwitch = useState<bool>(false);
    var updateLedgerSwitch = useState<bool>(false);

    void changeAddingLedgerSwitch(bool value) {
      addLedgerSwitch.value = value;
      logger.d('value: $value');
    }

    void onChangeUpdateLedgerSwitch(bool value) {
      updateLedgerSwitch.value = value;
      logger.d('value: $value');
    }

    return Scaffold(
      backgroundColor: AppColors.bg.basic,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: AppColors.role.secondary,
        brightness: Theme.of(context).brightness,
        title: Text(
          localization(context).notification,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.text.basic,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          cacheExtent: 120,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 44),
                  child: Text(
                    localization(context).addingLedgerItem,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.text.basic,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 40, top: 16),
                  child: Switch(
                    inactiveTrackColor: mainColor,
                    value: addLedgerSwitch.value,
                    onChanged: changeAddingLedgerSwitch,
                    activeTrackColor: AppColors.role.primary,
                    activeColor: AppColors.role.secondary,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 44),
                  child: Text(
                    localization(context).updatingLedgerItem,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.text.basic,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 40, top: 16),
                  child: Switch(
                    inactiveTrackColor: mainColor,
                    value: updateLedgerSwitch.value,
                    onChanged: onChangeUpdateLedgerSwitch,
                    activeTrackColor: AppColors.role.primary,
                    activeColor: AppColors.role.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
