import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const darkModeStatusBarColor = SystemUiOverlayStyle(
  statusBarColor: Colors.black,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

const lightModeStatusBarColor = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

class Themes {
  Themes._();

  static void setStatusBarColors() {
    final schedulerBinding = SchedulerBinding.instance;

    Brightness brightness = schedulerBinding.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode ? darkModeStatusBarColor : lightModeStatusBarColor,
    );
  }

  static final light = ThemeData(
    brightness: Brightness.light,
    hintColor: mediumGrayColor,
    primaryColor: mainColor,
    primaryColorLight: const Color(0xFF6D7999),
    primaryColorDark: const Color(0xFF172540),
    secondaryHeaderColor: mediumGrayColor,
    backgroundColor: lightColor,
    bottomAppBarColor: lightDimColor,
    disabledColor: warmGrayColor,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: mainColor,
      systemOverlayStyle: lightModeStatusBarColor,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    dialogBackgroundColor: lightColor,
    textTheme: const TextTheme(
      headline1: TextStyle(color: darkColor),
      headline2: TextStyle(color: mediumGrayColor),
      headline3: TextStyle(color: paleGrayColor),
      caption: TextStyle(color: lightColor),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: greenBlueColor,
    ),
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    hintColor: warmGrayColor,
    primaryColor: mainColor,
    primaryColorLight: const Color(0xFF6D7999),
    primaryColorDark: const Color(0xFF172540),
    secondaryHeaderColor: mediumGrayColor,
    backgroundColor: darkDimColor,
    bottomAppBarColor: darkDimColor,
    disabledColor: warmGrayColor,
    dialogBackgroundColor: darkColor,
    textTheme: const TextTheme(
      headline1: TextStyle(color: lightColor),
      headline2: TextStyle(color: paleGrayColor),
      headline3: TextStyle(color: mediumGrayColor),
      caption: TextStyle(color: darkColor),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: greenBlueColor,
      brightness: Brightness.dark,
    ),
  );
}
