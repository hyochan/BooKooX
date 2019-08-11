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
    backgroundColor: Colors.white,
    brightness: brightness,
    leading: IconButton(
      icon: Icon(Icons.close),
      onPressed: () => Navigator.of(context).pop(),
    ),
    elevation: 1.0,
    actions: actions,
    titleSpacing: 0.0,
    title: title,
  );
}
