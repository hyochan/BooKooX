import 'package:flutter/material.dart';

import '../shared/header.dart' show renderHeaderBack;
import '../shared/button.dart' show Button;
import '../utils/asset.dart' as Asset;
import '../utils/localization.dart';

class SettingExcel extends StatelessWidget {
  static const String name = '/setting_excel';

  void onExportExcel() {
    print('on send excel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          t('EXPORT_EXCEL'),
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
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  maxLines: 10,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: t('EMAIL_HINT'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Container(
              child: Button(
                onPress: onExportExcel,
                text: t('SEND'),
                margin: EdgeInsets.all(0),
                height: 56,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                backgroundColor: Asset.Colors.main,
              ),
            )
          ],
        ),
      ),
    );
  }
}
