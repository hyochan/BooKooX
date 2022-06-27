import 'dart:ui';

import '../types/color.dart';

const lightColor = Color(0xffffffff);
const lightDimColor = Color.fromARGB(255, 250, 250, 250);
const darkColor = Color(0xff111111);
const darkDimColor = Color.fromARGB(255, 0, 0, 0);
const pinkColor = Color(0xffa750b9);
const greenBlueColor = Color(0xff24cd97);
const paleGrayColor = Color(0xffdde2ec);
const mediumGrayColor = Color(0xff869ab7);
const whiteGrayColor = Color(0xfff9fbfd);
const darkishPinkColor = Color(0xffe6677e);
const skyBlueBrightColor = Color(0xff00b0ff);
const warmGrayColor = Color(0xff979797);
const purpleLightColor = Color(0xffb669f9);
const goldenColor = Color(0xffeed100);
const squashColor = Color(0xfff6a623);
const carnationColor = Color(0xffff728d);
const cloudyBlueColor = Color(0xffafc2db);

const redColor = Color.fromARGB(255, 255, 114, 141);
const orangeColor = Color.fromARGB(255, 245, 166, 35);
const yellowColor = Color.fromARGB(255, 240, 192, 0);
const greenColor = Color.fromARGB(255, 29, 211, 168);
const blueColor = Color.fromARGB(255, 103, 157, 255);
const mainColor = Color.fromARGB(255, 13, 178, 147);
const purpleColor = Color.fromARGB(255, 182, 105, 249);

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
