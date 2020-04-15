import 'package:flutter/material.dart';

import 'package:bookoox/shared/button.dart' show Button;
import 'package:bookoox/utils/asset.dart' as Asset;
import 'package:bookoox/utils/general.dart';
import 'package:bookoox/utils/localization.dart' show Localization;

class MainEmpty extends StatefulWidget {
  MainEmpty({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  _MainEmptyState createState() => new _MainEmptyState();
}

class _MainEmptyState extends State<MainEmpty> {
  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: Asset.Icons.noLedger,
              height: 80,
              width: 80,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 40,
                right: 40,
                top: 22,
                bottom: 32,
              ),
              child: Text(
                _localization.trans('NO_LEDGER_DESCRIPTION'),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1.color,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Button(
              backgroundColor: Colors.white,
              width: 160,
              height: 56,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                  color: Asset.Colors.dusk,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              onPress: () => General.instance.navigateScreenNamed(context, '/ledger_add'),
              text: _localization.trans('ADD_LEDGER'),
              textStyle: TextStyle(
                fontSize: 20,
                color: Asset.Colors.dusk,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
