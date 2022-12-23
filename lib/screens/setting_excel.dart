import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/logger.dart';

import '../utils/localization.dart';
import '../widgets/header.dart' show renderHeaderBack;
import '../widgets/common/button.dart' show Button;
import '../utils/asset.dart' as asset;

class SettingExcel extends StatelessWidget {
  const SettingExcel({Key? key}) : super(key: key);

  void onExportExcel() {
    logger.d('on send excel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg.basic,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: AppColors.role.secondary,
        brightness: Theme.of(context).brightness,
        title: Text(
          localization(context).exportExcel,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.text.basic,
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
                    hintText: localization(context).emailHint,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Button(
              onPress: onExportExcel,
              text: localization(context).send,
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
