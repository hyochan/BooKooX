import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/providers/current_ledger.dart';
import 'package:wecount/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import '../utils/asset.dart' as asset;
import '../utils/localization.dart' show localization;

import '../widgets/setting_list_item.dart'
    show ListItem, TileItem, SettingTileItem;
import '../widgets/home_header.dart' show renderHomeAppBar;

class HomeSetting extends HookWidget {
  const HomeSetting({
    Key? key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<CurrentLedger>(context).getLedger() != null
        ? Provider.of<CurrentLedger>(context).getLedger()!.color
        : ColorType.dusk;

    final List<ListItem> items = [
      TileItem(
        title: localization(context).currency,
        trailing: const Text('ARS | \$ '),
        leading: const Icon(
          Icons.account_balance,
          color: asset.Colors.cloudyBlue,
          size: 24.0,
        ),
        onTap: () => navigation.push(context, AppRoute.settingCurrency.path),
      ),
      TileItem(
        title: localization(context).exportExcel,
        trailing: const Icon(Icons.arrow_forward),
        leading: const Icon(
          Icons.import_export,
          color: asset.Colors.cloudyBlue,
          size: 24.0,
        ),
        onTap: () => navigation.push(context, AppRoute.settingExcel.path),
      ),
    ];

    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: title,
        color: asset.Colors.getColor(color),
        fontColor: Colors.white,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
