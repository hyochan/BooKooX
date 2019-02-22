import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/dialog_spinner.dart';
import '../utils/localization.dart';

class General {
  static final General instance = new General();

  TextSelection setCursorAtTheEnd(TextEditingController textController) {
    /// Flutter currently reset the cursor. Always place the cursor at the end.
    TextSelection cursorPos = textController.selection;
    cursorPos = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length),
    );
    textController.selection = cursorPos;

    return cursorPos;
  }

  Future<Object> navigateScreenNamed(BuildContext context, String routeName, { bool reset = false }) {
    if (reset) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
        ModalRoute.withName(routeName),
      );
    }
    return Navigator.of(context).pushNamed(routeName);
  }

  void showDialogSpinner(BuildContext context, {
    String str,
    TextStyle textStyle,
  }) {
    showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogSpinner(
            textStyle: textStyle,
            text: str != null ? str : Localization.of(context).trans('LOADING'),
          );
        }
    );
  }
}
