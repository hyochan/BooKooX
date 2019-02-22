import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/localization.dart' show Localization;
import '../utils/general.dart';
import '../utils/theme.dart' as Theme;

import 'dart:async';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  bool _visible = false;

  Future<void> navigateRoute() async{
    String initialRoute = '/intro';

    Timer(Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      General.instance.navigateScreenNamed(context, initialRoute, reset: true);
    });
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 100), () {
      setState(() {
        this._visible = true;
      });
    });
    SystemChrome.setEnabledSystemUIOverlays([]);
    this.navigateRoute();
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    return Scaffold(
      primary: true,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.Colors.dodgerBlue,
          ),
          Text('Loading'),
          AnimatedOpacity(
            opacity: !_visible ? 0.0 : 1.0,
            duration: Duration(milliseconds: 2000),
            child: Container(
              child: Center(
                child: Text(
                  localization.trans('LOADING'),
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
