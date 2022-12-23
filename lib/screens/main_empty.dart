import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/widgets/home_header.dart' show renderHomeAppBar;

class MainEmpty extends HookWidget {
  const MainEmpty({
    Key? key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg.basic,
      appBar: renderHomeAppBar(
        context: context,
        title: '',
        color: AppColors.role.primary,
        actions: [
          SizedBox(
            width: 56.0,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(0.0),
              shape: const CircleBorder(),
              onPressed: () => navigation.push(context, AppRoute.settings.path),
              child: Icon(
                Icons.settings,
                color: AppColors.text.contrast,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.bg.basic,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_dissatisfied,
              color: AppColors.role.primaryLight,
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
                localization(context).noLedgerDescription,
                style: TextStyle(
                  color: AppColors.text.basic,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Button(
              backgroundColor: AppColors.button.primary.bg,
              width: 160,
              height: 56,
              onPress: () =>
                  Navigator.of(context).pushNamed(AppRoute.ledgerEdit.fullPath),
              text: localization(context).addLedger,
              textStyle: TextStyle(
                fontSize: 18,
                color: AppColors.button.primary.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
