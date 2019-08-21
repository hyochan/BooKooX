import 'package:flutter/material.dart';

import '../utils/general.dart' show General;
import '../utils/asset.dart' as Asset;
import '../utils/localization.dart' show Localization;
import '../widgets/setting_list_item.dart' show ListItem, LogoutItem, SettingItem, SettingListItem;
import '../widgets/header.dart' show renderHeaderBack;


class Setting extends StatelessWidget {
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
      ),
      SettingItem(
        Icon(
          Icons.lock,
          color: Asset.Colors.cloudyBlue,
          size: 24,
        ),
        _localization.trans('LOCK'),
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
