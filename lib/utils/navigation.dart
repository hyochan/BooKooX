import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;

import 'package:wecount/widgets/dialog_spinner.dart';
import 'package:wecount/utils/localization.dart';

typedef NavigationArguments<T> = T;

class _Navigation {
  static final _Navigation _singleton = _Navigation._internal();

  factory _Navigation() {
    return _singleton;
  }

  _Navigation._internal();

  Future<dynamic> push(BuildContext context, String routeName,
      {bool reset = false, NavigationArguments? arguments}) {
    if (reset) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        '$routeName',
        ModalRoute.withName('$routeName'),
        arguments: arguments,
      );
    }

    return Navigator.of(context).pushNamed('$routeName', arguments: arguments);
  }

  Future navigate(
    BuildContext context,
    String routeName, {
    bool reset = false,
    NavigationArguments? arguments,
  }) {
    if (reset) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        '$routeName',
        (route) =>
            route.isCurrent && route.settings.name == routeName ? false : true,
        arguments: arguments,
      );
    }

    return Navigator.of(context).pushNamed('$routeName', arguments: arguments);
  }

  void pop<T extends String>(
    BuildContext context, {
    String params = '',
  }) {
    return Navigator.pop(context, params);
  }

  void popUtil(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.popUntil(
      context,
      (route) {
        return route.settings.name == '$routeName';
      },
    );
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
            text: text != null
                ? text
                : Localization.of(context)!.trans('LOADING'),
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
    TextStyle _btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.displayLarge!.color,
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
            TextButton(
              child: Text(
                Localization.of(context)!.trans('OK')!,
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
    required Widget title,
    required Widget content,
    Function? okPressed,
    Function? cancelPressed,
  }) {
    TextStyle _btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.displayLarge!.color,
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
            TextButton(
              child: Text(
                Localization.of(context)!.trans('OK')!,
                style: _btnTextStyle,
              ),
              onPressed: okPressed as void Function()?,
            ),
            TextButton(
              onPressed: cancelPressed as void Function()?,
              child: Text(
                Localization.of(context)!.trans('CANCEL')!,
                style: _btnTextStyle,
              ),
            )
          ],
        );
      },
    );
  }

  void showMembershipDialog(
      BuildContext context, void Function(int?)? onChange, int value) {
    var _localization = Localization.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_localization!.trans('MEMBERSHIP_CHANGE')!),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(_localization.trans('MEMBER_OWNER')!),
                      groupValue: value,
                      value: 0,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(_localization.trans('MEMBER_ADMIN')!),
                      groupValue: value,
                      value: 1,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: Text(_localization.trans('MEMBER_GUEST')!),
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
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  child: TextButton(
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

  Future<XFile?> chooseImage({
    required BuildContext context,
    String? type,
  }) async {
    _Navigation._singleton.showDialogSpinner(context,
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

var navigation = _Navigation();
