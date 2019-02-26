import 'package:flutter/material.dart';

class Data {
  Data._();
  static getTheme(BuildContext context) {
    return Theme.of(context);
  }
}

class Colors {
  Colors._(); // this basically makes it so you can instantiate this class
  static const Color whiteGray = Color.fromARGB(255, 249, 251, 253);
  static const Color dusk = Color.fromARGB(255, 65, 77, 107);
  static const Color darkGray = Color.fromARGB(255, 80, 100, 140);
  static const Color mediumGray = Color.fromARGB(255, 134, 154, 183);
  static const Color paleGrayLight = Color.fromARGB(255, 221, 226, 236);
  static const Color paleGray = Color.fromARGB(255, 220,226,235);
  static const Color red = Color.fromARGB(255, 255, 114, 141);
  static const Color orange = Color.fromARGB(255, 245, 166, 35);
  static const Color yellow = Color.fromARGB(255, 238, 208, 0);
  static const Color green = Color.fromARGB(255, 29, 211, 168);
  static const Color blue = Color.fromARGB(255, 175, 194, 219);
  static const Color purple = Color.fromARGB(255, 182, 105, 249);
  static const Color skyBlue = Color.fromARGB(255, 103, 157, 255);
  static const Color brightSkyBlue = Color.fromARGB(255, 0, 176, 255);
  static const Color greenBlue = Color.fromARGB(255, 36, 205, 151);
  static const Color warmGray = Color.fromARGB(255, 151, 151, 151);
  static const Color disabled = Color.fromARGB(255, 210, 210, 210);

  static const Color black34 = Color.fromARGB(255, 34, 34, 34);
  static const Color clearBlue = Color.fromARGB(255, 43,116, 252);
  static const Color cloudyBlue = Color.fromARGB(255, 175, 194, 219);
}

class Icons {
  Icons._();
  static AssetImage icBooKoo = AssetImage('res/icons/BooKoo.png');
  static AssetImage icFacebookW = AssetImage('res/icons/icFacebookW.png');
  static AssetImage icGoogleW = AssetImage('res/icons/icGoogleW.png');
}

