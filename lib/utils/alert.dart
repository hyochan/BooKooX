import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecount/utils/constants.dart';

import 'localization.dart';

void alert(String message, {Color? colorText}) => Get.snackbar(
      appName,
      message,
      colorText: colorText,
    );

void alertWarning(String message) => Get.snackbar('WARNING', message);

void alertError(String message) => Get.snackbar(t('ERROR'), message);
