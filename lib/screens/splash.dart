import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible = false;
  Timer? _navigationTimer;
  Timer? _timer;

  Future<void> navigateRoute() async {
    String initialRoute = AppRoute.tutorial.path;

    _navigationTimer = Timer(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      navigation.push(context, initialRoute, reset: true);
    });
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(milliseconds: 1000), () {
      setState(() {
        this._visible = true;
      });
    });
    SystemChrome.setEnabledSystemUIOverlays([]);
    this.navigateRoute();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    if (_navigationTimer != null) {
      _navigationTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            AnimatedOpacity(
              opacity: !_visible ? 0.0 : 1.0,
              duration: Duration(milliseconds: 1000),
              child: Container(
                margin: EdgeInsets.only(bottom: 60.0),
                child: Center(
                  child: Image(
                      image: Asset.Icons.icWeCount, width: 200.0, height: 60.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
