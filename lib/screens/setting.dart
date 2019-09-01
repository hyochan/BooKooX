import 'package:flutter/material.dart';

import '../utils/general.dart' show General;
import '../utils/asset.dart' as Asset;
import '../utils/localization.dart' show Localization;
import '../shared/setting_list_item.dart' show ListItem, LogoutItem, SettingItem, SettingListItem;
import '../shared/header.dart' show renderHeaderBack;

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _lockSwitch = false;
  void _onChangeLock(bool value) {
    setState(() => _lockSwitch = value);
    print('value: $value');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    final List<ListItem> _items = [
      SettingItem(
        Icon(
          Icons.announcement,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('ANNOUNCEMENT'),
        onPressed: () => General.instance.navigateScreenNamed(context, '/setting_announcement'),
      ),
      SettingItem(
        Icon(
          Icons.message,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('SHARE_OPINION'),
        onPressed: () => General.instance.navigateScreenNamed(context, '/setting_opinion'),
      ),
      SettingItem(
        Icon(
          Icons.question_answer,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('FAQ'),
        onPressed: () => General.instance.navigateScreenNamed(context, '/setting_faq'),
      ),
      SettingItem(
        Icon(
          Icons.notifications,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('NOTIFICATION'),
        onPressed: () => General.instance.navigateScreenNamed(context, '/setting_notification'),
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
          print('logout');
        }
      ),
    ];

    return Scaffold(
      appBar: renderHeaderBack(
        context: context,
        iconColor: Theme.of(context).primaryColor,
        brightness: Brightness.light,
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
                      child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: <Widget>[
                            Text(
                              item.title,
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
                  return SettingListItem(item);
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
