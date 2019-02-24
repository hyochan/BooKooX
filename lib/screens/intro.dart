import 'package:flutter/material.dart';
import '../utils/theme.dart' as Theme;
import '../utils/localization.dart';
import '../widgets/button.dart' show Button;

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    var icBooKoo = AssetImage("res/icons/BooKoo.png");

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.only(top: 168.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Image(image: icBooKoo, width: 200.0, height: 60.0),
                      Button(
                        margin: EdgeInsets.only(top: 200.0, left: 60.0, right: 60.0),
                        fontSize: 18.0,
                        text: localization.trans('LOGIN'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        constraints: BoxConstraints.expand(
          height: double.infinity,
          width: double.infinity,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.Colors.dusk, Theme.Colors.darkGray],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}
