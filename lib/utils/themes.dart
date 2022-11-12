import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'asset.dart' as Asset;

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Asset.Colors.light,
      brightness: Brightness.dark,
      hintColor: Asset.Colors.mediumGray,
      primaryColor: Asset.Colors.main,
      primaryColorLight: const Color(0xff6d7999),
      primaryColorDark: const Color(0xff172540),
      secondaryHeaderColor: Asset.Colors.mediumGray,
      appBarTheme: AppBarTheme(
          backgroundColor: Asset.Colors.light,
          systemOverlayStyle: lightModeStatusBarColor),
      bottomAppBarTheme: BottomAppBarTheme(color: Asset.Colors.lightDim),
      disabledColor: Asset.Colors.warmGray,
      dialogBackgroundColor: Asset.Colors.light,
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Asset.Colors.dark),
        contentTextStyle: TextStyle(fontSize: 14, color: Asset.Colors.dark),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Asset.Colors.dark),
        displayMedium: TextStyle(color: Asset.Colors.mediumGray),
        displaySmall: TextStyle(color: Asset.Colors.paleGray),
        bodySmall: TextStyle(color: Asset.Colors.light),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Asset.Colors.greenBlue,
        background: Asset.Colors.light,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Asset.Colors.dark),
      ));

  static final dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Asset.Colors.dark,
      brightness: Brightness.light,
      hintColor: Asset.Colors.warmGray,
      primaryColor: Asset.Colors.main,
      primaryColorLight: const Color(0xff6d7999),
      primaryColorDark: const Color(0xff172540),
      secondaryHeaderColor: Asset.Colors.mediumGray,
      appBarTheme: AppBarTheme(
          backgroundColor: Asset.Colors.darkDim,
          systemOverlayStyle: darkModeStatusBarColor),
      bottomAppBarTheme: BottomAppBarTheme(color: Asset.Colors.darkDim),
      disabledColor: Asset.Colors.warmGray,
      dialogBackgroundColor: Asset.Colors.dark,
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Asset.Colors.light),
        contentTextStyle: TextStyle(fontSize: 14, color: Asset.Colors.light),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Asset.Colors.light),
        displayMedium: TextStyle(color: Asset.Colors.paleGray),
        displaySmall: TextStyle(color: Asset.Colors.mediumGray),
        bodySmall: TextStyle(color: Asset.Colors.dark),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Asset.Colors.greenBlue,
        brightness: Brightness.dark,
        background: Asset.Colors.darkDim,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Asset.Colors.light),
      ));
}

const lightModeStatusBarColor = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

const darkModeStatusBarColor = SystemUiOverlayStyle(
  statusBarColor: Colors.black,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);
