import 'package:flutter/material.dart';

typedef NavigationArguments<T> = T;

class _Navigation {
  static final _Navigation _singleton = _Navigation._internal();

  factory _Navigation() {
    return _singleton;
  }

  _Navigation._internal();

  Future<dynamic> push(BuildContext context, String routeName,
      {bool reset = false, NavigationArguments? arguments}) {
    if (reset) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        '/$routeName',
        ModalRoute.withName('/$routeName'),
        arguments: arguments,
      );
    }

    return Navigator.of(context).pushNamed('/$routeName', arguments: arguments);
  }

  Future navigate(
    BuildContext context,
    String routeName, {
    bool reset = false,
    NavigationArguments? arguments,
  }) {
    if (reset) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        '/$routeName',
        (route) =>
            route.isCurrent && route.settings.name == routeName ? false : true,
        arguments: arguments,
      );
    }
    return Navigator.of(context).pushNamed('/$routeName', arguments: arguments);
  }

  void pop<T extends String>(
    BuildContext context, {
    String params = '',
  }) {
    return Navigator.pop(context, params);
  }

  void popUtil(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.popUntil(
      context,
      (route) {
        return route.settings.name == '/$routeName';
      },
    );
  }
}

var navigation = _Navigation();
