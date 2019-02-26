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
    String text,
    TextStyle textStyle,
  }) {
    showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogSpinner(
            textStyle: textStyle,
            text: text != null ? text : Localization.of(context).trans('LOADING'),
          );
        }
    );
  }

  void showDialogYes(BuildContext context, {
    bool barrierDismissible = false,
    String title = '',
    String content = '',
  }) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(Localization.of(context).trans('OK')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogYesNo(BuildContext context, {
    bool barrierDismissible = false,
    String title = '',
    String content = '',
    Function okPressed,
    Function cancelPressed,
  }) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(Localization.of(context).trans('OK')),
              onPressed: okPressed,
            ),
            FlatButton(
              onPressed: cancelPressed,
              child: Text(Localization.of(context).trans('CANCEL')),
            )
          ],
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String str, String btnStr) {
    var snackBar = SnackBar(
      content: Text(str),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: btnStr,
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _selectDate(BuildContext context, data, Function callback) {
//    List<DateTime> data = [
//      DateTime(2018, 8, 16),
//      DateTime(2018, 8, 18),
//      DateTime(2018, 8, 20),
//      DateTime(2018, 8, 23),
//      DateTime(2018, 8, 26),
//      DateTime(2018, 8, 30),
//    ];

    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Container(
            color: Color.fromRGBO(240, 240, 240, 1.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var datum = '${data[index].year}/${data[index].month}/${data[index].day}';
                return Container(
                  child: FlatButton(
                    onPressed: () {
                      print('select: ${data[index].toString()}');
                      // callback(datum);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 64.0,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              datum,
                              style: TextStyle(
                                color:  Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: "AppleSDGothicNeo",
                                fontStyle:  FontStyle.normal,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: data.length,
            ),
          );
        }
    );
  }
}
