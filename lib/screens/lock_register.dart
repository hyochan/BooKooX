import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/pin_keyboard.dart' show PinKeyboard;
import 'package:wecount/utils/localization.dart' show Localization;

class LockRegister extends StatefulWidget {
  static const String name = '/lock_register';

  @override
  _LockRegisterState createState() => _LockRegisterState();
}

class _LockRegisterState extends State<LockRegister> {
  late Size _screenSize;

  int? _currentDigit;

  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;

  String? _pin = '';

  readLockPinFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('LOCK_PIN')) {
      _pin = prefs.getString('LOCK_PIN');
      print(_pin);
    }
  }

  addLockPinToSF() async {
    if (_pin!.length != 4) {
      return;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('LOCK_PIN', _pin!);
      Navigator.of(context).pop();
      print(_pin);
    }
  }

  resetLockPinToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('LOCK_PIN');
  }

  @override
  void initState() {
    super.initState();
    resetLockPinToSF();

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
    var _localization = Localization.of(context)!;
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        context: context,
        iconColor: Theme.of(context).textTheme.displayLarge!.color,
        brightness: Theme.of(context).brightness,
        actions: <Widget>[
          TextButton(
            child: Text(
              _localization.trans('DONE')!,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
            onPressed: addLockPinToSF,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              _localization.trans('LOCK_HINT')!,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.displayLarge!.color),
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
                ],
              ),
            ),
            // OutlineButton(
            //   child:
            //   Text(_localization.trans('FINGERPRINT_SET')),
            //   onPressed: () {} ,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            // ),
            SizedBox(
              height: 50,
            ),
            PinKeyboard(
              keyboardHeight: _screenSize.height / 3.0,
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

        _pin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        print(_pin);
      }
    });
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

  Widget _pinTextField(int? digit) {
    return Container(
        width: 50,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          digit != null ? digit.toString() : "",
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).textTheme.displayLarge!.color!,
              width: 2,
            ),
          ),
        ));
  }
}
