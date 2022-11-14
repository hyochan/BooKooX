import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wecount/widgets/header.dart';
import 'package:wecount/utils/localization.dart';

class SettingNotification extends StatefulWidget {
  static const String name = '/setting_notification';

  @override
  _SettingNotificationState createState() => _SettingNotificationState();
}

class _SettingNotificationState extends State<SettingNotification> {
  bool _addLedgerSwitch = false;
  bool _updateLedgerSwitch = false;

  void _onChangeAddingLedgerSwitch(bool value) {
    setState(() => _addLedgerSwitch = value);
    print('value: $value');
  }

  void _onChangeUpdateLedgerSwitch(bool value) {
    setState(() => _updateLedgerSwitch = value);
    print('value: $value');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          _localization.trans('NOTIFICATION')!,
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
                  padding: EdgeInsets.only(left: 40, right: 40, top: 44),
                  child: Text(
                    _localization.trans('ADDING_LEDGER_ITEM')!,
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
                  padding: EdgeInsets.only(left: 40, top: 16),
                  child: Switch(
                    value: _addLedgerSwitch,
                    onChanged: _onChangeAddingLedgerSwitch,
                    activeTrackColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 40, right: 40, top: 44),
                  child: Text(
                    _localization.trans('UPDATING_LEDGER_ITEM')!,
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
                  padding: EdgeInsets.only(left: 40, top: 16),
                  child: Switch(
                    value: _updateLedgerSwitch,
                    onChanged: _onChangeUpdateLedgerSwitch,
                    activeTrackColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).accentColor,
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
