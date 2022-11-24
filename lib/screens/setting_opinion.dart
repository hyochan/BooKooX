import 'package:flutter/material.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/asset.dart' as Asset;

class SettingOpinion extends StatelessWidget {
  const SettingOpinion({Key? key}) : super(key: key);

  void onSendOpinion() {
    print('on send opinion');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        brightness: Theme.of(context).brightness,
        iconColor: Theme.of(context).iconTheme.color,
        title: Text(
          _localization.trans('SHARE_OPINION')!,
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
                padding: EdgeInsets.only(top: 20),
                child: TextField(
                  maxLines: 10,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _localization.trans('SHARE_OPINION_HINT'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
            ),
            Container(
              child: Button(
                onPress: onSendOpinion,
                text: _localization.trans('SEND'),
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
