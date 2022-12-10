import 'package:flutter/material.dart';
import 'package:wecount/utils/logger.dart';

import '../utils/localization.dart' show Localization;
import '../widgets/header.dart' show renderHeaderBack;
import '../widgets/button.dart' show Button;
import '../utils/asset.dart' as asset;

class SettingExcel extends StatelessWidget {
  const SettingExcel({Key? key}) : super(key: key);

  void onExportExcel() {
    logger.d('on send excel');
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          localization.trans('EXPORT_EXCEL')!,
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
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                  maxLines: 10,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localization.trans('EMAIL_HINT'),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Button(
              onPress: onExportExcel,
              text: localization.trans('SEND'),
              margin: const EdgeInsets.all(0),
              height: 56,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              backgroundColor: asset.Colors.main,
            )
          ],
        ),
      ),
    );
  }
}
