import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bookoo2/utils/localization.dart' show Localization;

AppBar renderHeaderClose({
  Key key,
  Widget title,
  List<Widget> actions,
  @required BuildContext context,
  Brightness brightness,
  bool centerTitle,
  Widget bottom,
}) {
  var _localization = Localization.of(context);
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    brightness: brightness,
    leading: Container(
      width: 56.0,
      child: RawMaterialButton(
        padding: EdgeInsets.all(0.0),
        shape: CircleBorder(),
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.close,
          color: Theme.of(context).textTheme.title.color,
          semanticLabel: _localization.trans('CLOSE'),
        ),
      ),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    bottom: bottom,
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
    leading: RawMaterialButton(
      padding: EdgeInsets.all(0.0),
      shape: CircleBorder(),
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(
        Icons.arrow_back,
        color: iconColor,
        semanticLabel: _localization.trans('BACK'),
      ),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    title: title,
  );
}
