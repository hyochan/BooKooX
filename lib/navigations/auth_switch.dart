import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/controllers/user_controller.dart';
import 'package:wecount/navigations/home_tab.dart' show HomeTab;
import 'package:wecount/screens/tutorial.dart' show Tutorial;
import 'package:wecount/shared/circle_loading_indicator.dart';

class AuthSwitch extends StatefulWidget {
  static const String name = '/auth_switch';

  const AuthSwitch({Key? key}) : super(key: key);

  @override
  State<AuthSwitch> createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!UserController().isSignIn()) {
        Get.offAll(() => const Tutorial());
      } else {
        Get.offAll(() => const HomeTab());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CircleLoadingIndicator();
  }
}
