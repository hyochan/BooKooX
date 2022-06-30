import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/localization.dart';

AppBar renderHeaderClose({
  Key? key,
  Widget? title,
  List<Widget>? actions,
  required BuildContext context,
  Brightness? brightness,
  bool? centerTitle,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    centerTitle: centerTitle,
    backgroundColor: Colors.transparent,
    leading: InkWell(
      onTap: () => Get.back(),
      child: Icon(
        Icons.close,
        semanticLabel: t('CLOSE'),
      ),
    ),
    elevation: 0.0,
    actions: actions,
    titleSpacing: 0,
    bottom: bottom,
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
    leading: InkWell(
      onTap: () => Get.back(),
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
