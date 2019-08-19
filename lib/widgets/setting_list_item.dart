import 'package:flutter/material.dart';
import '../utils/asset.dart' as Asset;

abstract class ListItem {}

class SettingItem implements ListItem {
  final Icon icon;
  final String title;
  final Widget optionalWidget;

  SettingItem(
    this.icon, this.title,
    {
      this.optionalWidget,
    }
  );
}

class LogoutItem implements ListItem {
  final String title;
  LogoutItem(this.title);
}

class SettingListItem extends StatelessWidget {
  SettingListItem(this.item);
  final SettingItem item;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 72,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 24),
              child: item.icon,
            ),
            Expanded(
              child: Container(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}