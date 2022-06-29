import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wecount/screens/tutorial.dart';

import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/asset.dart' as asset;

class Splash extends StatefulWidget {
  static const String name = '/splash';

  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible = false;
  Timer? _navigationTimer;
  Timer? _timer;

  Future<void> navigateRoute() async {
    String initialRoute = Tutorial.name;

    _navigationTimer = Timer(const Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      General.instance.navigateScreenNamed(context, initialRoute, reset: true);
    });
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _visible = true;
      });
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    navigateRoute();
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
              duration: const Duration(milliseconds: 1000),
              child: Container(
                margin: const EdgeInsets.only(bottom: 60.0),
                child: Center(
                  child: Image(
                      image: asset.Icons.icWeCount, width: 200.0, height: 60.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
