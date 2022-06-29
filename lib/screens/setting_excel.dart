import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

import '../shared/button.dart' show Button;
import '../shared/header.dart' show renderHeaderBack;
import '../utils/localization.dart';
import '../utils/logger.dart';

class SettingExcel extends StatelessWidget {
  static const String name = '/setting_excel';

  const SettingExcel({Key? key}) : super(key: key);

  void onExportExcel() {
    logger.d('on send excel');
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
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                  maxLines: 10,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: t('EMAIL_HINT'),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Button(
              onPress: onExportExcel,
              text: t('SEND'),
              margin: const EdgeInsets.all(0),
              height: 56,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              backgroundColor: mainColor,
            )
          ],
        ),
      ),
    );
  }
}
