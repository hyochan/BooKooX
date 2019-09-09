import 'package:flutter/material.dart';

import '../utils/general.dart' show General;

import '../utils/localization.dart' show Localization;
import '../shared/header.dart' show renderHeaderBack;
import '../shared/button.dart' show Button;
import '../utils/asset.dart' as Asset;

import '../shared/setting_list_item.dart' show ListItem, TileItem, SettingTileItem;

class SettingCurrency extends StatefulWidget {

  SettingCurrency({
    Key key,
    this.title = '',
    this.selectedCurrency = '',
  }) : super(key: key);
  final String title;
  final String selectedCurrency;

  @override
  _SettingCurrencyState createState() => _SettingCurrencyState();
}

class _SettingCurrencyState extends State<SettingCurrency> {
  void onSettingCurrency(String selectedCurrency) {
    print('on setting currency $selectedCurrency');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    final List<ListItem> _items = [
      TileItem(
        title: 'ARS | \$ ',
        trailing: Text(''),
        onTap: () => onSettingCurrency('ARS'),
      ),
      TileItem(
        title: 'AUD | \$ ',
        trailing: Text(''),
        onTap: () => onSettingCurrency('AUD'),
      ),
      TileItem(
        title: 'CNY | \¥ ',
        trailing: Text(''),
        onTap: () => onSettingCurrency('CNY'),
      ),
      TileItem(
        title: 'KRW | \￦ ',
        trailing: Icon(Icons.check),
        onTap: () => onSettingCurrency('KRW'),
      ),

    ];

    return Scaffold(
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).primaryColor,
        brightness: Brightness.light,
        title: Text(
          _localization.trans('CURRENCY'),
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
                itemCount : _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return SettingTileItem(item);                                
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}