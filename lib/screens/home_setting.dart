import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/screens/setting_currency.dart';
import 'package:wecount/screens/setting_excel.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/colors.dart';

import '../shared/home_header.dart' show renderHomeAppBar;
import '../shared/setting_list_item.dart'
    show ListItem, TileItem, SettingTileItem;
import '../utils/general.dart' show General;
import '../utils/localization.dart';

class HomeSetting extends StatefulWidget {
  const HomeSetting({
    Key? key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  State<HomeSetting> createState() => _HomeSettingState();
}

class _HomeSettingState extends State<HomeSetting> {
  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).ledger != null
        ? Provider.of<CurrentLedger>(context).ledger!.color
        : ColorType.dusk;

    final List<ListItem> items = [
      TileItem(
        title: t('CURRENCY'),
        trailing: const Text('ARS | \$ '),
        leading: const Icon(
          Icons.account_balance,
          color: cloudyBlueColor,
          size: 24.0,
        ),
        onTap: () =>
            General.instance.navigateScreenNamed(context, SettingCurrency.name),
      ),
      TileItem(
        title: t('EXPORT_EXCEL'),
        trailing: const Icon(Icons.arrow_forward),
        leading: const Icon(
          Icons.import_export,
          color: cloudyBlueColor,
          size: 24.0,
        ),
        onTap: () =>
            General.instance.navigateScreenNamed(context, SettingExcel.name),
      ),
    ];

    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: widget.title,
        color: getColor(color),
        fontColor: Colors.white,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return SettingTileItem(item as TileItem);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
