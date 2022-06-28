import 'dart:ui';

import '../types/color.dart';

const lightColor = Color(0xFFFFFFFF);
const darkColor = Color(0xFF111111);
const pinkColor = Color(0xFFA750B9);
const greenBlueColor = Color(0xFF24CD97);
const paleGrayColor = Color(0xFFDDE2EC);
const mediumGrayColor = Color(0xFF869AB7);
const whiteGrayColor = Color(0xFFF9FBFD);
const darkishPinkColor = Color(0xFFE6677E);
const skyBlueBrightColor = Color(0xFF00B0FF);
const warmGrayColor = Color(0xFF979797);
const purpleLightColor = Color(0xFFB669F9);
const goldenColor = Color(0xFFEED100);
const squashColor = Color(0xFff6A623);
const carnationColor = Color(0xFFFF728D);
const cloudyBlueColor = Color(0xFFAFC2DB);

const lightDimColor = Color.fromARGB(255, 250, 250, 250);
const darkDimColor = Color.fromARGB(255, 0, 0, 0);
const redColor = Color.fromARGB(255, 255, 114, 141);
const orangeColor = Color.fromARGB(255, 245, 166, 35);
const yellowColor = Color.fromARGB(255, 240, 192, 0);
const greenColor = Color.fromARGB(255, 29, 211, 168);
const blueColor = Color.fromARGB(255, 103, 157, 255);
const mainColor = Color.fromARGB(255, 13, 178, 147);
const purpleColor = Color.fromARGB(255, 182, 105, 249);

const darkTransparent = Color.fromRGBO(255, 255, 255, 0.7);

Color getColor(ColorType? color) {
  return color == ColorType.RED
      ? redColor
      : color == ColorType.ORANGE
          ? orangeColor
          : color == ColorType.YELLOW
              ? yellowColor
              : color == ColorType.GREEN
                  ? greenColor
                  : color == ColorType.BLUE
                      ? blueColor
                      : color == ColorType.PURPLE
                          ? purpleColor
                          : mainColor;
}
