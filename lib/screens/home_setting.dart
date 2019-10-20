import 'package:flutter/material.dart';

import '../utils/general.dart' show General;
import '../utils/asset.dart' as Asset;
import '../utils/localization.dart' show Localization;

import '../shared/setting_list_item.dart' show ListItem, TileItem, SettingTileItem;
import '../shared/home_header.dart' show renderHomeAppBar;

class HomeSetting extends StatefulWidget {
  HomeSetting({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  _HomeSettingState createState() => new _HomeSettingState();
}

class _HomeSettingState extends State<HomeSetting> {

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    final List<ListItem> _items = [
      TileItem(
        title: _localization.trans('CURRENCY'),
        trailing: Text('ARS | \$ '),
        leading: Icon(
          Icons.account_balance,
          color: Asset.Colors.cloudyBlue,
          size: 24.0,
        ),
        onTap: () => General.instance.navigateScreenNamed(context, '/setting_currency'),
      ),
      TileItem(
        title: _localization.trans('EXPORT_EXCEL'),
        trailing: Icon( Icons.arrow_forward),
        leading: Icon(
          Icons.import_export,
          color: Asset.Colors.cloudyBlue,
          size: 24.0,
        ),
        onTap: () => General.instance.navigateScreenNamed(context, '/setting_excel'),                            
      ),
    ];

    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: widget.title,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                  height: 1.0,
                ),
                itemCount : _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return SettingTileItem(item);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
