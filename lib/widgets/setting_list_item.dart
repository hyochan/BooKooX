import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

abstract class ListItem {}

class SettingItem implements ListItem {
  final Icon icon;
  final String? title;
  final Widget? optionalWidget;
  final Function? onPressed;

  SettingItem(
    this.icon,
    this.title, {
    this.optionalWidget,
    this.onPressed,
  });
}

class LogoutItem implements ListItem {
  final String? title;
  final VoidCallback? onPress;
  LogoutItem(
    this.title, {
    this.onPress,
  });
}

class SettingListItem extends StatelessWidget {
  const SettingListItem(this.item, {super.key});
  final SettingItem item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(0),
        ),
      ),
      onPressed: item.onPressed as void Function()?,
      child: SizedBox(
        height: 72,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 24),
              child: item.icon,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.title!,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.text.basic,
                    ),
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

class TileItem implements ListItem {
  final Widget? leading;
  final String? title;
  final Widget? trailing;
  final Widget? optionalWidget;
  final Function? onTap;

  TileItem({
    this.title,
    this.trailing,
    this.leading,
    this.optionalWidget,
    this.onTap,
  });
}

class SettingTileItem extends StatelessWidget {
  const SettingTileItem(this.item, {super.key});
  final TileItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap as void Function()?,
      child: ListTile(
        leading: item.leading,
        title: Text(
          item.title!,
          style: const TextStyle(color: Colors.black),
        ),
        trailing: item.trailing,
      ),
    );
  }
}
