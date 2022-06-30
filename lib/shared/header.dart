import 'package:flutter/material.dart';

import '../utils/localization.dart';

AppBar renderHeaderClose({
  Key? key,
  Widget? title,
  List<Widget>? actions,
  required BuildContext context,
  Brightness? brightness,
  bool? centerTitle,
  Widget? bottom,
}) {
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    // ignore: deprecated_member_use
    brightness: brightness,
    leading: SizedBox(
      width: 56.0,
      child: RawMaterialButton(
        padding: const EdgeInsets.all(0.0),
        shape: const CircleBorder(),
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.close,
          color: Theme.of(context).textTheme.headline1!.color,
          semanticLabel: t('CLOSE'),
        ),
      ),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    bottom: bottom as PreferredSizeWidget?,
    // title: title,
  );
}

AppBar renderHeaderBack({
  Key? key,
  Widget? title,
  List<Widget>? actions,
  required BuildContext context,
  Brightness? brightness,
  Color? iconColor,
  bool? centerTitle,
}) {
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    leading: RawMaterialButton(
      padding: const EdgeInsets.all(0.0),
      shape: const CircleBorder(),
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(
        Icons.arrow_back,
        color: iconColor,
        semanticLabel: t('BACK'),
      ),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0.0,
    title: title,
  );
}
