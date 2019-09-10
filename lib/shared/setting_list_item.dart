import 'package:flutter/material.dart';
import 'package:bookoo2/utils/asset.dart' as Asset;

abstract class ListItem {}

class SettingItem implements ListItem {
  final Icon icon;
  final String title;
  final Widget optionalWidget;
  final Function onPressed;

  SettingItem(
    this.icon, this.title,
    {
      this.optionalWidget,
      this.onPressed,
    }
  );
}

class LogoutItem implements ListItem {
  final String title;
  final Function onPressed;
  LogoutItem(this.title, {
    this.onPressed,
  });
}

class SettingListItem extends StatelessWidget {
  SettingListItem(this.item);
  final SettingItem item;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: item.onPressed,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ),
                  item.optionalWidget ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}