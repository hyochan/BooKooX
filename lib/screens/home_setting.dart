import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/types/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import '../utils/asset.dart' as Asset;
import '../utils/localization.dart' show Localization;

import '../widgets/setting_list_item.dart'
    show ListItem, TileItem, SettingTileItem;
import '../widgets/home_header.dart' show renderHomeAppBar;

class HomeSetting extends HookWidget {
  HomeSetting({
    Key? key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;
    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : ColorType.DUSK;

    final List<ListItem> _items = [
      TileItem(
        title: _localization.trans('CURRENCY'),
        trailing: Text('ARS | \$ '),
        leading: Icon(
          Icons.account_balance,
          color: Asset.Colors.cloudyBlue,
          size: 24.0,
        ),
        onTap: () => navigation.push(context, AppRoute.settingCurrency.path),
      ),
      TileItem(
        title: _localization.trans('EXPORT_EXCEL'),
        trailing: Icon(Icons.arrow_forward),
        leading: Icon(
          Icons.import_export,
          color: Asset.Colors.cloudyBlue,
          size: 24.0,
        ),
        onTap: () => navigation.push(context, AppRoute.settingExcel.path),
      ),
    ];

    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: title,
        color: Asset.Colors.getColor(color),
        fontColor: Colors.white,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return SettingTileItem(item as TileItem);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
