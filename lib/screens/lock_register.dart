import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/pin_keyboard.dart' show PinKeyboard;
import 'package:wecount/utils/localization.dart';

import '../utils/logger.dart';

class LockRegister extends StatefulWidget {
  static const String name = '/lock_register';

  const LockRegister({Key? key}) : super(key: key);

  @override
  State<LockRegister> createState() => _LockRegisterState();
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
      logger.d(_pin);
    }
  }

  addLockPinToSF() async {
    if (_pin!.length != 4) {
      return;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('LOCK_PIN', _pin!);
      Get.back();
      logger.d(_pin);
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
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        context: context,
        iconColor: Theme.of(context).textTheme.headline1!.color,
        brightness: Theme.of(context).brightness,
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: addLockPinToSF,
            shape: const CircleBorder(),
            child: Text(
              t('DONE'),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Text(
              t('LOCK_HINT'),
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.headline1!.color),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
            const SizedBox(
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

        logger.d(_pin);
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
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).textTheme.headline1!.color!,
              width: 2,
            ),
          ),
        ),
        child: Text(
          digit != null ? digit.toString() : "",
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ));
  }
}
