import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/localization.dart' show Localization;

AppBar renderHeaderClose({
  Key key,
  Widget title,
  List<Widget> actions,
  BuildContext context,
  Brightness brightness,
  bool centerTitle,
}) {
  var _localization = Localization.of(context);
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    brightness: brightness,
    leading: IconButton(
      color: Theme.of(context).primaryColor,
      icon: Icon(
        Icons.close,
        semanticLabel: _localization.trans('CLOSE'),
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    // title: title,
  );
}

AppBar renderHeaderBack({
  Key key,
  Widget title,
  List<Widget> actions,
  BuildContext context,
  Brightness brightness,
  Color iconColor,
  bool centerTitle,
}) {
  var _localization = Localization.of(context);
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    brightness: brightness,
    leading: IconButton(
      color: Theme.of(context).primaryColor,
      icon: Icon(
        Icons.arrow_back,
        color: iconColor,
        semanticLabel: _localization.trans('BACK'),
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    title: title,
  );
}
