import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;

import 'package:bookoo2/shared/dialog_spinner.dart';
import 'package:bookoo2/utils/localization.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

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

  Future<dynamic> navigateScreen(BuildContext context, MaterialPageRoute pageRoute) {
    return Navigator.push(
      context,
      pageRoute,
    );
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

  void showSingleDialog(BuildContext context, {
    bool barrierDismissible = false,
    String title = '',
    String content = '',
  }) {
    TextStyle _btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.title.color,
      fontSize: 16,
    );

    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(
                Localization.of(context).trans('OK'),
                style: _btnTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showConfirmDialog(BuildContext context, {
    bool barrierDismissible = false,
    String title = '',
    String content = '',
    Function okPressed,
    Function cancelPressed,
  }) {
    TextStyle _btnTextStyle = TextStyle(
      color: Theme.of(context).textTheme.title.color,
      fontSize: 16,
    );
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

  void showDatePicker(BuildContext context, data, Function callback) {
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

  Future<File> chooseImage({
    @required BuildContext context,
    String type,
  }) async {
    General.instance.showDialogSpinner(context, text: Localization.of(context).trans('LOADING'));

    try {
      File imgFile = type == 'camera'
        ? await ImagePicker.pickImage(source: ImageSource.camera)
        : await ImagePicker.pickImage(source: ImageSource.gallery);
      return imgFile;
    } catch (err) {
      print('chooseImage err $err');
      return null;
    } finally {
      Navigator.pop(context);
    }
  }

  File compressImage(File img, { int size = 500 }) {
    Im.Image image = Im.decodeImage(img.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(image, width: size, height: size);
    return smallerImage as File;
  }
}

class GooglePlaceService {
  static GooglePlaceService _instance = GooglePlaceService();
  static GooglePlaceService get instance => _instance;

  String kGoogleApiKey = '[PLACE_API_KEY]';

  Future<Map<String, dynamic>> showGooglePlaceSearch(BuildContext context, {
    String locale = 'en',
    String country = 'us',
  }) async {
    Map<String, dynamic> location = Map();

    final homeScaffoldKey = new GlobalKey<ScaffoldState>();

    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      language: "kr",
      mode: Mode.fullscreen,
      components: [Component(Component.country, "kr")],
    );
    await _displayPrediction(p, homeScaffoldKey.currentState, (lat, lng) {
      location['lat'] = lat;
      location['lng'] = lng;
      print('list: $lat, $lng');
    });
    /// Get city from p string
    if (p != null) {
      List<String> list = p.description.split(', ');
      if (list.length > 1) {
        location['country'] = list[list.length - 1]; /// country
        location['city'] = list[list.length - 2]; /// city
      }
    }
    return location;
  }

  Future<Null> _displayPrediction(Prediction p, ScaffoldState scaffold, Function(double, double) callback) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces();

    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      print('detail: ${detail.result}');
      if (detail.result != null) {
        callback(detail.result.geometry.location.lat, detail.result.geometry.location.lng);
      }
    }
  }
}
