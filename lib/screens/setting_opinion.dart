import 'package:flutter/material.dart';

import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/button.dart' show Button;
import 'package:wecount/utils/colors.dart';

import '../utils/localization.dart';
import '../utils/logger.dart';

class SettingOpinion extends StatelessWidget {
  static const String name = '/setting_opinion';

  const SettingOpinion({Key? key}) : super(key: key);

  void onSendOpinion() {
    logger.d('on send opinion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        brightness: Theme.of(context).brightness,
        iconColor: Theme.of(context).iconTheme.color,
        title: Text(
          t('SHARE_OPINION'),
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
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  maxLines: 10,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: t('SHARE_OPINION_HINT'),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Button(
              onPress: onSendOpinion,
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
