import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bookoo2/shared/header.dart' show renderHeaderBack;
import 'package:bookoo2/shared/pin_keyboard.dart' show PinKeyboard;

import 'package:bookoo2/utils/general.dart' show General;
import 'package:bookoo2/utils/asset.dart' as Asset;
import 'package:bookoo2/utils/localization.dart' show Localization;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LockAuth extends StatefulWidget {
  @override
  _LockAuthState createState() => _LockAuthState();
}

class _LockAuthState extends State<LockAuth> {

  Size _screenSize;

  int _currentDigit;

  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  String _pin = '';
  String _inputPin = '';

  Localization _localization;

  readLockPinFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey('LOCK_PIN')) {
      _pin = prefs.getString('LOCK_PIN');
      print(_pin);
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    readLockPinFromSF();    
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

  }
  
  @override
  Widget build(BuildContext context) {
    _localization = Localization.of(context);
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: renderHeaderBack(
        context: context,
        iconColor: Theme.of(context).primaryColor,
        brightness: Brightness.light,
        actions: null,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 40 ,),
              Text(_localization.trans('LOCK_HINT'),
              style: TextStyle(
                fontSize: 24,
                color: Asset.Colors.dusk),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _pinTextField(_firstDigit),
                  _pinTextField(_secondDigit),
                  _pinTextField(_thirdDigit),
                  _pinTextField(_fourthDigit),
                ],),              
            ),
            OutlineButton(
              child: 
              Text(_localization.trans('FINGERPRINT_LOGIN')),
              onPressed: () {} ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: 50 ,),
            PinKeyboard(
              keyboardHeight: _screenSize.height / 3.0 ,
              onButtonPressed: _setCurrentDigit,
              onDeletePressed: _deleteCurrentDigit,
            ),
          ],
        ),
      ),
    );
  }

  void _setCurrentDigit(int i) {

    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        _inputPin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        print('INPUT PIN is $_inputPin');

      }
    });

    if (_inputPin.length == 4 ) {
        if (_inputPin == _pin) {
          Navigator.pop(context, false);
        } else {
          Fluttertoast.showToast(
            msg: _localization.trans('PIN_MISMATCH'),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            fontSize: 16.0,
          );

          _inputPin = '';
        }
    }
  }

  void _deleteCurrentDigit() {

    setState(() {
      if (_fourthDigit != null) {
        _fourthDigit = null;
      } else if (_thirdDigit != null) {
        _thirdDigit = null;
      } else if (_secondDigit != null) {
        _secondDigit = null;
      } else if (_firstDigit != null) {
        _firstDigit = null;
      }
    });
  }

  Widget _pinTextField(int digit) {
    return Container(
      width: 50,
      height: 45,
      alignment: Alignment.center,
      child: Text(
        digit != null ? digit.toString() : "",
        style: TextStyle(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Asset.Colors.dusk,
            width: 2,
            ),
          ),
        )
    );
  }
}