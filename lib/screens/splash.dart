import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/screens/tutorial.dart';

import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

class Splash extends HookWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool visible = false;
    Timer? navigationTimer;
    Timer? timer;

    Future<void> navigateRoute() async {
      String initialRoute = AppRoute.tutorial.path;

      navigationTimer = Timer(const Duration(milliseconds: 1500), () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        navigation.push(context, initialRoute, reset: true);
      });
    }

    useEffect(() {
      timer = Timer(const Duration(milliseconds: 1000), () {
        visible = true;
      });
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

      navigateRoute();
      return () {
        if (timer != null) {
          timer!.cancel();
        }
        if (navigationTimer != null) {
          navigationTimer!.cancel();
        }
      };
    }, []);

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
              opacity: !visible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 1000),
              child: Container(
                margin: const EdgeInsets.only(bottom: 60.0),
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
