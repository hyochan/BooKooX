import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

class AppIcons {
  AppIcons._();
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

Color getLedgerColor({
  ColorType? color = ColorType.green,
  double opacity = 1.0,
}) {
  return color == ColorType.red
      ? Color.fromRGBO(255, 114, 141, opacity)
      : color == ColorType.orange
          ? Color.fromRGBO(245, 166, 35, opacity)
          : color == ColorType.yellow
              ? Color.fromRGBO(240, 192, 0, opacity)
              : color == ColorType.green
                  ? Color.fromRGBO(29, 211, 168, opacity)
                  : color == ColorType.blue
                      ? Color.fromRGBO(103, 157, 255, opacity)
                      : color == ColorType.purple
                          ? Color.fromRGBO(182, 105, 249, opacity)
                          : Color.fromRGBO(13, 178, 147, opacity);
}
