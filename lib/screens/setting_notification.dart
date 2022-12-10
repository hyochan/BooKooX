import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    var localization = Localization.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          localization.trans('NOTIFICATION')!,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.displayLarge!.color,
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
                    localization.trans('ADDING_LEDGER_ITEM')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.displayLarge!.color,
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
                    inactiveTrackColor: asset.Colors.main,
                    value: addLedgerSwitch.value,
                    onChanged: changeAddingLedgerSwitch,
                    activeTrackColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 44),
                  child: Text(
                    localization.trans('UPDATING_LEDGER_ITEM')!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.displayLarge!.color,
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
                    inactiveTrackColor: asset.Colors.main,
                    value: updateLedgerSwitch.value,
                    onChanged: onChangeUpdateLedgerSwitch,
                    activeTrackColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).colorScheme.secondary,
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
