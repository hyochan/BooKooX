import 'package:flutter/material.dart';
import '../utils/theme.dart' as Theme;

class DialogSpinner extends StatelessWidget {
  const DialogSpinner({
    this.textStyle,
    @required this.text,
  });

  final textStyle;
  final text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              backgroundColor: Theme.Colors.dusk,
              strokeWidth: 5.0,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.Colors.dusk),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0),
              child: Text(
                text,
                style: this.textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
