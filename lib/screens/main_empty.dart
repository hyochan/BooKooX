import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/setting.dart';
import 'package:wecount/shared/button.dart' show Button;

import '../shared/home_header.dart' show renderHomeAppBar;
import '../utils/localization.dart';

class MainEmpty extends StatefulWidget {
  static const String name = '/main_empty';

  const MainEmpty({
    Key? key,
  }) : super(key: key);

  @override
  State<MainEmpty> createState() => _MainEmptyState();
}

class _MainEmptyState extends State<MainEmpty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHomeAppBar(
        context: context,
        actions: [
          SizedBox(
            width: 56.0,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: () => Get.to(() => const Setting()),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_dissatisfied,
              color: Theme.of(context).primaryColorLight,
              size: 80,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 22,
                bottom: 32,
              ),
              child: Text(
                t('NO_LEDGER_DESCRIPTION'),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Button(
              backgroundColor: Colors.transparent,
              width: 160,
              height: 56,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                  color: Theme.of(context).textTheme.headline2!.color!,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              onPress: () => Get.to(() => const LedgerEdit()),
              text: t('ADD_LEDGER'),
              textStyle: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.headline2!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
