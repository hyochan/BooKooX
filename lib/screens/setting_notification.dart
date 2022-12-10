import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/widgets/header.dart';
import 'package:wecount/utils/localization.dart';

class SettingNotification extends HookWidget {
  const SettingNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addLedgerSwitch = useState<bool>(false);
    var updateLedgerSwitch = useState<bool>(false);

    void _onChangeAddingLedgerSwitch(bool value) {
      addLedgerSwitch.value = value;
      print('value: $value');
    }

    void _onChangeUpdateLedgerSwitch(bool value) {
      updateLedgerSwitch.value = value;
      print('value: $value');
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
                    value: addLedgerSwitch.value,
                    onChanged: _onChangeAddingLedgerSwitch,
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
                    value: updateLedgerSwitch.value,
                    onChanged: _onChangeUpdateLedgerSwitch,
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
