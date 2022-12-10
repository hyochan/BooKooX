import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'asset.dart' as asset;

class Themes {
  Themes._();

  static final light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: asset.Colors.light,
      brightness: Brightness.dark,
      hintColor: asset.Colors.mediumGray,
      primaryColor: asset.Colors.main,
      primaryColorLight: const Color(0xff6d7999),
      primaryColorDark: const Color(0xff172540),
      secondaryHeaderColor: asset.Colors.mediumGray,
      appBarTheme: const AppBarTheme(
          backgroundColor: asset.Colors.light,
          systemOverlayStyle: lightModeStatusBarColor),
      bottomAppBarTheme: const BottomAppBarTheme(color: asset.Colors.lightDim),
      disabledColor: asset.Colors.warmGray,
      dialogBackgroundColor: asset.Colors.light,
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: asset.Colors.dark),
        contentTextStyle: TextStyle(fontSize: 14, color: asset.Colors.dark),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: asset.Colors.dark),
        displayMedium: TextStyle(color: asset.Colors.mediumGray),
        displaySmall: TextStyle(color: asset.Colors.paleGray),
        bodySmall: TextStyle(color: asset.Colors.light),
        bodyLarge: TextStyle(color: asset.Colors.dark),
        bodyMedium: TextStyle(color: asset.Colors.dark),
        labelLarge: TextStyle(color: asset.Colors.dark),
        labelSmall: TextStyle(color: asset.Colors.dark),
        titleLarge: TextStyle(color: asset.Colors.dark),
        titleMedium: TextStyle(color: asset.Colors.dark),
        titleSmall: TextStyle(color: asset.Colors.dark),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: asset.Colors.greenBlue,
        background: asset.Colors.light,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: asset.Colors.dark),
      ));

  static final dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: asset.Colors.dark,
      brightness: Brightness.light,
      hintColor: asset.Colors.warmGray,
      primaryColor: asset.Colors.main,
      primaryColorLight: const Color(0xff6d7999),
      primaryColorDark: const Color(0xff172540),
      secondaryHeaderColor: asset.Colors.mediumGray,
      appBarTheme: const AppBarTheme(
          backgroundColor: asset.Colors.darkDim,
          systemOverlayStyle: darkModeStatusBarColor),
      bottomAppBarTheme: const BottomAppBarTheme(color: asset.Colors.darkDim),
      disabledColor: asset.Colors.warmGray,
      dialogBackgroundColor: asset.Colors.dark,
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: asset.Colors.light),
        contentTextStyle: TextStyle(fontSize: 14, color: asset.Colors.light),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: asset.Colors.light),
        displayMedium: TextStyle(color: asset.Colors.paleGray),
        displaySmall: TextStyle(color: asset.Colors.mediumGray),
        bodySmall: TextStyle(color: asset.Colors.dark),
        bodyLarge: TextStyle(color: asset.Colors.light),
        bodyMedium: TextStyle(color: asset.Colors.light),
        labelLarge: TextStyle(color: asset.Colors.light),
        labelSmall: TextStyle(color: asset.Colors.light),
        titleLarge: TextStyle(color: asset.Colors.light),
        titleMedium: TextStyle(color: asset.Colors.light),
        titleSmall: TextStyle(color: asset.Colors.light),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: asset.Colors.greenBlue,
        brightness: Brightness.dark,
        background: asset.Colors.darkDim,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: asset.Colors.light),
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
