import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;

import 'package:bookoox/shared/dialog_spinner.dart';
import 'package:bookoox/utils/localization.dart';

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

  Future<Object> navigateScreenNamed(BuildContext context, String routeName,
      {bool reset = false}) {
    if (reset) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
        ModalRoute.withName(routeName),
      );
    }
    return Navigator.of(context).pushNamed(routeName);
  }

  Future<dynamic> navigateScreen(
      BuildContext context, MaterialPageRoute pageRoute) {
    return Navigator.push(
      context,
      pageRoute,
    );
  }

  void showDialogSpinner(
    BuildContext context, {
    String text,
    TextStyle textStyle,
  }) {
    showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogSpinner(
            textStyle: textStyle,
            text:
                text != null ? text : Localization.of(context).trans('LOADING'),
          );
        });
  }

  void showSingleDialog(
    BuildContext context, {
    bool barrierDismissible = false,
    @required Widget title,
    @required Widget content,
    Function onPress,
  }) {
    TextStyle _btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.headline1.color,
      fontSize: 16,
    );

    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            FlatButton(
              child: Text(
                Localization.of(context).trans('OK'),
                style: _btnTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPress != null) onPress();
              },
            ),
          ],
        );
      },
    );
  }

  void showConfirmDialog(
    BuildContext context, {
    bool barrierDismissible = false,
    @required Widget title,
    @required Widget content,
    Function okPressed,
    Function cancelPressed,
  }) {
    TextStyle _btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.headline1.color,
      fontSize: 16,
    );
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            FlatButton(
              child: Text(
                Localization.of(context).trans('OK'),
                style: _btnTextStyle,
              ),
              onPressed: okPressed,
            ),
            FlatButton(
              onPressed: cancelPressed,
              child: Text(
                Localization.of(context).trans('CANCEL'),
                style: _btnTextStyle,
              ),
            )
          ],
        );
      },
    );
  }

  void showMembershipDialog(
      BuildContext context, Function onChange, int value) {
    var _localization = Localization.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_localization.trans('MEMBERSHIP_CHANGE')),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(_localization.trans('MEMBER_OWNER')),
                      groupValue: value,
                      value: 0,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(_localization.trans('MEMBER_ADMIN')),
                      groupValue: value,
                      value: 1,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(_localization.trans('MEMBER_GUEST')),
                      groupValue: value,
                      value: 2,
                      onChanged: onChange,
                    ),
                  ],
                ),
              );
            },
          ),
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

  void showDatePicker(
      BuildContext context, List<DateTime> dates, Function callback) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            color: Color.fromRGBO(240, 240, 240, 1.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var datum =
                    '${dates[index].year}/${dates[index].month}/${dates[index].day}';
                return Container(
                  child: FlatButton(
                    onPressed: () {
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
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: "AppleSDGothicNeo",
                                fontStyle: FontStyle.normal,
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
              itemCount: dates.length,
            ),
          );
        });
  }

  Future<XFile> chooseImage({
    @required BuildContext context,
    String type,
  }) async {
    General.instance.showDialogSpinner(context,
        text: Localization.of(context).trans('LOADING'));

    ImagePicker picker = ImagePicker();

    try {
      XFile imgFile = type == 'camera'
          ? await picker.pickImage(source: ImageSource.camera)
          : await picker.pickImage(source: ImageSource.gallery);
      return imgFile;
    } catch (err) {
      print('chooseImage err $err');
      return null;
    } finally {
      Navigator.pop(context);
    }
  }

  File compressImage(File img, {int size = 500}) {
    Im.Image image = Im.decodeImage(img.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(image, width: size, height: size);
    return smallerImage as File;
  }
}
