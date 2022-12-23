import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/logger.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/asset.dart' as asset;

class SettingOpinion extends StatelessWidget {
  const SettingOpinion({Key? key}) : super(key: key);

  void onSendOpinion() {
    logger.d('on send opinion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg.basic,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        brightness: Theme.of(context).brightness,
        iconColor: AppColors.role.secondary,
        title: Text(
          localization(context).shareOpinion,
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
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  maxLines: 10,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localization(context).shareOpinionHint,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Button(
              onPress: onSendOpinion,
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
