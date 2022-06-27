import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/shared/pin_keyboard.dart' show PinKeyboard;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

import '../utils/localization.dart';

class LockAuth extends StatefulWidget {
  static const String name = '/lock_auth';

  @override
  _LockAuthState createState() => _LockAuthState();
}

class _LockAuthState extends State<LockAuth> {
  late Size _screenSize;
  int? _currentDigit;

  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;

  String? _pin = '';
  String _inputPin = '';

  /// LocalAuthentication - Fingerprint
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _hasFingerPrintSupport = false;

  Future<void> checkFingerprintSupport() async {
    bool isBiometricSupport = false;
    List<BiometricType> availableBiometricType = [];

    try {
      isBiometricSupport = await _localAuthentication.canCheckBiometrics;
      if (!isBiometricSupport) return;
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    try {
      availableBiometricType =
          await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      if (availableBiometricType.contains(BiometricType.fingerprint)) {
        _hasFingerPrintSupport = true;
      } else {
        _hasFingerPrintSupport = false;
      }
    });
  }

  Future<void> _authenticateMe() async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it pop sup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason: t('FINGERPRINT_LOGIN'), // message for dialog
        options: AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    if (authenticated) {
      Navigator.pop(context, false);
    } else {
      return;
    }
  }

  readLockPinFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('LOCK_PIN')) {
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

    checkFingerprintSupport();
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
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        actions: null,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              t('LOCK_HINT'),
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.headline2!.color),
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
            OutlinedButton(
              child: Text(
                t('FINGERPRINT_LOGIN'),
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2!.color),
              ),
              onPressed: _hasFingerPrintSupport ? _authenticateMe : null,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(30),
              // ),
            ),
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

        _inputPin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        print('INPUT PIN is $_inputPin');
      }
    });

    if (_inputPin.length == 4) {
      if (_inputPin == _pin) {
        Navigator.pop(context, false);
      } else {
        Fluttertoast.showToast(
          msg: t('PIN_MISMATCH'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
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

  Widget _pinTextField(int? digit) {
    return Container(
        width: 50,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          digit != null ? digit.toString() : "",
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).textTheme.headline1!.color!,
              width: 2,
            ),
          ),
        ));
  }
}
