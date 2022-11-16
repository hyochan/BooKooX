import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/models/currency.dart';
import 'package:flutter/material.dart';

import '../utils/localization.dart' show Localization;
import '../widgets/header.dart' show renderHeaderBack;
import '../widgets/setting_list_item.dart'
    show ListItem, TileItem, SettingTileItem;

class SettingCurrencyArguments {
  final String title;
  final String? selectedCurrency;

  SettingCurrencyArguments({this.title = '', this.selectedCurrency});
}

class SettingCurrency extends HookWidget {
  const SettingCurrency({
    Key? key,
    this.title = '',
    this.selectedCurrency = '',
  }) : super(key: key);
  final String title;
  final String? selectedCurrency;

  @override
  Widget build(BuildContext context) {
    void onSettingCurrency(Currency selectedCurrency) {
      print('on setting currency ${selectedCurrency.toString()}');
      Navigator.pop(context, selectedCurrency);
    }

    var _localization = Localization.of(context)!;

    final List<ListItem> _items = currencies
        .map((el) => TileItem(
              title: '${el.currency} | ${el.symbol}',
              trailing: el.currency == selectedCurrency
                  ? Icon(Icons.check)
                  : Text(''),
              onTap: () => onSettingCurrency(Currency(
                locale: el.locale,
                currency: el.currency,
                symbol: el.symbol,
              )),
            ))
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          _localization.trans('CURRENCY')!,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return SettingTileItem(item as TileItem);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
