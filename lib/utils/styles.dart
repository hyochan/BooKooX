import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

class TitleTextStyle extends TextStyle {
  TitleTextStyle()
      : super(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.text.basic,
        );
}

class NavigationTitleTextStyle extends TextStyle {
  NavigationTitleTextStyle()
      : super(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.text.basic,
        );
}

class SubTitleTextStyle extends TextStyle {
  SubTitleTextStyle()
      : super(
          fontSize: 14,
          color: AppColors.text.basic,
        );
}

class InputLabelTextStyle extends TextStyle {
  InputLabelTextStyle()
      : super(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.text.basic,
        );
}

class InputHintTextStyle extends TextStyle {
  InputHintTextStyle()
      : super(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.text.basic,
        );
}
