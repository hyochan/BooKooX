import 'package:wecount/models/currency_model.dart';
import 'package:flutter/material.dart';

import '../shared/header.dart' show renderHeaderBack;
import '../shared/setting_list_item.dart'
    show ListItem, TileItem, SettingTileItem;
import '../utils/localization.dart';
import '../utils/logger.dart';

class SettingCurrency extends StatefulWidget {
  static const String name = '/setting_currency';

  const SettingCurrency({
    Key? key,
    this.title = '',
    this.selectedCurrency = '',
  }) : super(key: key);
  final String title;
  final String? selectedCurrency;

  @override
  State<SettingCurrency> createState() => _SettingCurrencyState();
}

class _SettingCurrencyState extends State<SettingCurrency> {
  void onSettingCurrency(CurrencyModel selectedCurrency) {
    logger.d('on setting currency ${selectedCurrency.toString()}');
    Navigator.pop(context, selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    final List<ListItem> items = currencies
        .map((el) => TileItem(
              title: '${el.currency} | ${el.symbol}',
              trailing: el.currency == widget.selectedCurrency
                  ? const Icon(Icons.check)
                  : const Text(''),
              onTap: () => onSettingCurrency(CurrencyModel(
                locale: el.locale,
                currency: el.currency,
                symbol: el.symbol,
              )),
            ))
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          t('CURRENCY'),
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 16.0),
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return SettingTileItem(item as TileItem);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
