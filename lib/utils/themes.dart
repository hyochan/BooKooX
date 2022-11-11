import 'package:flutter/material.dart';
import 'asset.dart' as Asset;

class Themes {
  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    hintColor: Asset.Colors.mediumGray,
    primaryColor: Asset.Colors.main,
    primaryColorLight: const Color(0xff6d7999),
    primaryColorDark: const Color(0xff172540),
    secondaryHeaderColor: Asset.Colors.mediumGray,
    appBarTheme: AppBarTheme(backgroundColor: Asset.Colors.light),
    bottomAppBarTheme: BottomAppBarTheme(color: Asset.Colors.lightDim),
    disabledColor: Asset.Colors.warmGray,
    dialogBackgroundColor: Asset.Colors.light,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Asset.Colors.dark),
      displayMedium: TextStyle(color: Asset.Colors.mediumGray),
      displaySmall: TextStyle(color: Asset.Colors.paleGray),
      bodySmall: TextStyle(color: Asset.Colors.light),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Asset.Colors.greenBlue,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    hintColor: Asset.Colors.warmGray,
    primaryColor: Asset.Colors.main,
    primaryColorLight: const Color(0xff6d7999),
    primaryColorDark: const Color(0xff172540),
    secondaryHeaderColor: Asset.Colors.mediumGray,
    appBarTheme: AppBarTheme(backgroundColor: Asset.Colors.darkDim),
    bottomAppBarTheme: BottomAppBarTheme(color: Asset.Colors.darkDim),
    disabledColor: Asset.Colors.warmGray,
    dialogBackgroundColor: Asset.Colors.dark,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Asset.Colors.light),
      displayMedium: TextStyle(color: Asset.Colors.paleGray),
      displaySmall: TextStyle(color: Asset.Colors.mediumGray),
      bodySmall: TextStyle(color: Asset.Colors.dark),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Asset.Colors.greenBlue,
      brightness: Brightness.dark,
    ),
  );
}
