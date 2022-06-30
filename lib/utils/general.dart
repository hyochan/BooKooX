import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as i;
import 'package:image_picker/image_picker.dart';
import 'package:wecount/shared/dialog_spinner.dart';
import 'package:wecount/utils/localization.dart';

import 'logger.dart';

class General {
  static final General instance = General();

  TextSelection setCursorAtTheEnd(TextEditingController textController) {
    /// Flutter currently reset the cursor. Always place the cursor at the end.
    TextSelection cursorPos = textController.selection;
    cursorPos = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length),
    );
    textController.selection = cursorPos;

    return cursorPos;
  }

  Future<dynamic> navigateScreenNamed(BuildContext context, String routeName,
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

  void showSpinnerDialog({
    String? text,
    TextStyle? textStyle,
  }) {
    Get.dialog(
      DialogSpinner(
        textStyle: textStyle,
        text: text ?? t('LOADING'),
      ),
    );
  }

  void showSingleDialog(
    BuildContext context, {
    bool barrierDismissible = false,
    required Widget title,
    required Widget content,
    Function? onPress,
  }) {
    TextStyle btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.headline1!.color,
      fontSize: 16,
    );

    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                t('OK'),
                style: btnTextStyle,
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
    required Widget title,
    required Widget content,
    Function? okPressed,
    Function? cancelPressed,
  }) {
    TextStyle btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.headline1!.color,
      fontSize: 16,
    );
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: okPressed as void Function()?,
              child: Text(
                t('OK'),
                style: btnTextStyle,
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: cancelPressed as void Function()?,
              child: Text(
                t('CANCEL'),
                style: btnTextStyle,
              ),
            )
          ],
        );
      },
    );
  }

  void showMembershipDialog(
      BuildContext context, void Function(int?)? onChange, int value) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t('MEMBERSHIP_CHANGE')),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(t('MEMBER_OWNER')),
                      groupValue: value,
                      value: 0,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(t('MEMBER_ADMIN')),
                      groupValue: value,
                      value: 1,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(t('MEMBER_GUEST')),
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
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: btnStr,
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void showDatePicker(
      BuildContext context, List<DateTime> dates, Function callback) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            color: const Color.fromRGBO(240, 240, 240, 1.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var datum =
                    '${dates[index].year}/${dates[index].month}/${dates[index].day}';
                // ignore: deprecated_member_use
                return FlatButton(
                  onPressed: () {
                    // callback(datum);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 64.0,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Center(
                          child: Text(
                            datum,
                            style: const TextStyle(
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
                );
              },
              itemCount: dates.length,
            ),
          );
        });
  }

  Future<XFile?> chooseImage({
    required BuildContext context,
    String? type,
  }) async {
    General.instance.showSpinnerDialog(text: t('LOADING'));

    ImagePicker picker = ImagePicker();

    try {
      XFile? imgFile = type == 'camera'
          ? await picker.pickImage(source: ImageSource.camera)
          : await picker.pickImage(source: ImageSource.gallery);
      return imgFile;
    } catch (err) {
      logger.d('chooseImage err $err');
      return null;
    } finally {
      Navigator.pop(context);
    }
  }

  File compressImage(File img, {int size = 500}) {
    i.Image image = i.decodeImage(img.readAsBytesSync())!;
    i.Image smallerImage = i.copyResize(image, width: size, height: size);
    return smallerImage as File;
  }
}
