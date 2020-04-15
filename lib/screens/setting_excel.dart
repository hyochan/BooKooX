import 'package:flutter/material.dart';

import '../utils/localization.dart' show Localization;
import '../shared/header.dart' show renderHeaderBack;
import '../shared/button.dart' show Button;
import '../utils/asset.dart' as Asset;

class SettingExcel extends StatelessWidget {

  void onExportExcel() {
    print('on send excel');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          _localization.trans('EXPORT_EXCEL'),
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.headline1.color,
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
                    hintText: _localization.trans('EMAIL_HINT'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  ),
                  
                ),
              ),
            ),
            Container(
              child: Button(
                onPress: onExportExcel,
                text: _localization.trans('SEND'),
                margin: EdgeInsets.all(0),
                height: 56,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                backgroundColor: Asset.Colors.dusk,
              ),
            )
          ],
        ),
      ),
    );
  }
}