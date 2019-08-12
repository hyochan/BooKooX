import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar renderHeaderClose({
  Key key,
  Widget title,
  List<Widget> actions,
  BuildContext context,
  Brightness brightness,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    brightness: brightness,
    leading: IconButton(
      color: Theme.of(context).primaryColor,
      icon: Icon(
        Icons.close,
        semanticLabel: 'close',
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    // title: title,
  );
}
