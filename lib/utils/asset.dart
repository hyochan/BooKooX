import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

class Icons {
  Icons._();
  static AssetImage icMask = const AssetImage('res/icons/icMask.png');
  static AssetImage icWeCount = const AssetImage('res/icons/wecount.png');
  static AssetImage icFacebook = const AssetImage('res/icons/icFacebook.png');
  static AssetImage icGoogle = const AssetImage('res/icons/icGoogle.png');
  static AssetImage icTab1 = const AssetImage('res/icons/icTab1.png');
  static AssetImage icTab2 = const AssetImage('res/icons/icTab2.png');
  static AssetImage icTab3 = const AssetImage('res/icons/icTab3.png');
  static AssetImage icTab4 = const AssetImage('res/icons/icTab4.png');
  static AssetImage icRed = const AssetImage('res/icons/icRed.png');
  static AssetImage icOrange = const AssetImage('res/icons/icOrange.png');
  static AssetImage icYellow = const AssetImage('res/icons/icYellow.png');
  static AssetImage icGreen = const AssetImage('res/icons/icGreen.png');
  static AssetImage icBlue = const AssetImage('res/icons/icBlue.png');
  static AssetImage icDusk = const AssetImage('res/icons/icDusk.png');
  static AssetImage icPurple = const AssetImage('res/icons/icPurple.png');
  static AssetImage tutorial1 = const AssetImage('res/icons/tutorial1.png');
  static AssetImage tutorial2 = const AssetImage('res/icons/tutorial2.png');
  static AssetImage tutorial3 = const AssetImage('res/icons/tutorial3.png');
  static AssetImage noLedger = const AssetImage('res/icons/noLedger.png');
  static AssetImage icCoins = const AssetImage('res/icons/icCoins.png');
  static AssetImage icOwner = const AssetImage('res/icons/picOwner.png');
}

class Images {
  Images._();
}

class Colors {
  Colors._();
  static const red = Color.fromARGB(255, 255, 114, 141);
  static const orange = Color.fromARGB(255, 245, 166, 35);
  static const yellow = Color.fromARGB(255, 240, 192, 0);
  static const green = Color.fromARGB(255, 29, 211, 168);
  static const blue = Color.fromARGB(255, 103, 157, 255);
  static const main = Color.fromARGB(255, 13, 178, 147);
  static const purple = Color.fromARGB(255, 182, 105, 249);
  static Color getColor(ColorType? color) {
    return color == ColorType.red
        ? Colors.red
        : color == ColorType.orange
            ? Colors.orange
            : color == ColorType.yellow
                ? Colors.yellow
                : color == ColorType.green
                    ? Colors.green
                    : color == ColorType.blue
                        ? Colors.blue
                        : color == ColorType.purple
                            ? Colors.purple
                            : Colors.main;
  }
}
