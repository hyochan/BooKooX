import 'package:flutter/material.dart';
import 'package:wecount/utils/colors.dart';

class DialogSpinner extends StatelessWidget {
  const DialogSpinner({
    super.key,
    this.textStyle,
    required this.text,
  });

  final TextStyle? textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              backgroundColor: AppColors.role.primaryLight,
              strokeWidth: 5.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.role.primary),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30.0),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
