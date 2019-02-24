import 'package:flutter/material.dart';

class Data {
  Data._();
  static getTheme(BuildContext context) {
    return Theme.of(context);
  }
}

class Colors {
  Colors._(); // this basically makes it so you can instantiate this class
  static const whiteGray = Color.fromARGB(255, 249, 251, 253);
  static const dusk = Color.fromARGB(255, 65, 77, 107);
  static const darkGray = Color.fromARGB(255, 80, 100, 140);
  static const mediumGray = Color.fromARGB(255, 134, 154, 183);
  static const paleGrayLight = Color.fromARGB(255, 221, 226, 236);
  static const paleGray = Color.fromARGB(255, 220,226,235);
  static const red = Color.fromARGB(255, 255, 114, 141);
  static const orange = Color.fromARGB(255, 245, 166, 35);
  static const yellow = Color.fromARGB(255, 238, 208, 0);
  static const green = Color.fromARGB(255, 29, 211, 168);
  static const blue = Color.fromARGB(255, 175, 194, 219);
  static const purple = Color.fromARGB(255, 182, 105, 249);
  static const skyBlue = Color.fromARGB(255, 103, 157, 255);
  static const brightSkyBlue = Color.fromARGB(255, 0, 176, 255);
  static const greenBlue = Color.fromARGB(255, 36, 205, 151);
  static const warmGray = Color.fromARGB(255, 151, 151, 151);
  static const disabled = Color.fromARGB(255, 210, 210, 210);

  static const black34 = Color.fromARGB(255, 34, 34, 34);
  static const clearBlue = Color.fromARGB(255, 43,116,252);
}

class Icons {
  Icons._();
// static var icAppTitle = AssetImage('res/icons/appTitle.png');
}

