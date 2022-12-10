import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecount/utils/exceptions.dart';
import 'package:wecount/utils/localization.dart';
import 'package:wecount/widgets/dialog_spinner.dart';
import 'package:image/image.dart' as Im;

class General {
  static final General instance = General();
  User checkAuth() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw UserNotSignedInException();
    }

    return user;
  }

  void showDialogSpinner(
    BuildContext context, {
    String? text,
    TextStyle? textStyle,
  }) {
    showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogSpinner(
            textStyle: textStyle,
            text: text ?? Localization.of(context)!.trans('LOADING'),
          );
        });
  }

  void showSingleDialog(
    BuildContext context, {
    bool barrierDismissible = false,
    required Widget title,
    required Widget content,
    Function? onPress,
  }) {
    TextStyle btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.displayLarge!.color,
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
            TextButton(
              child: Text(
                Localization.of(context)!.trans('OK')!,
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
      color: Theme.of(context).textTheme.displayLarge!.color,
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
            TextButton(
              onPressed: okPressed as void Function()?,
              child: Text(
                Localization.of(context)!.trans('OK')!,
                style: btnTextStyle,
              ),
            ),
            TextButton(
              onPressed: cancelPressed as void Function()?,
              child: Text(
                Localization.of(context)!.trans('CANCEL')!,
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
    var localization = Localization.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization!.trans('MEMBERSHIP_CHANGE')!),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(localization.trans('MEMBER_OWNER')!),
                      groupValue: value,
                      value: 0,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(localization.trans('MEMBER_ADMIN')!),
                      groupValue: value,
                      value: 1,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(localization.trans('MEMBER_GUEST')!),
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
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                return TextButton(
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
    General.instance.showDialogSpinner(context,
        text: Localization.of(context)!.trans('LOADING'));

    ImagePicker picker = ImagePicker();

    try {
      XFile? imgFile = type == 'camera'
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
    Im.Image image = Im.decodeImage(img.readAsBytesSync())!;
    Im.Image smallerImage = Im.copyResize(image, width: size, height: size);
    return smallerImage as File;
  }
}
