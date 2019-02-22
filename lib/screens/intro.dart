import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../utils/general.dart';

class Intro extends StatefulWidget {
  Intro({Key key}) : super(key: key);

  @override
  IntroState createState() => new IntroState();
}

class IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'dooboolab'
        ),
      ),
      body: Center(
        child: Text(localization.trans('INTRO')),
      ),
    );
  }

  _navigate(String path) {
    General.instance.navigateScreenNamed(context, path, reset: false);
  }
}
