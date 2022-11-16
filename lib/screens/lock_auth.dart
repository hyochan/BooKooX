import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/pin_keyboard.dart' show PinKeyboard;

import 'package:wecount/utils/localization.dart' show Localization;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class LockAuth extends HookWidget {
  const LockAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mounted = useIsMounted();
    late Size _screenSize;
    var _currentDigit = useState<int?>(0);

    var _firstDigit = useState<int?>(null);
    var _secondDigit = useState<int?>(null);
    var _thirdDigit = useState<int?>(null);
    var _fourthDigit = useState<int?>(null);

    Localization? _localization;
    String? _pin = '';
    String _inputPin = '';

    void _setCurrentDigit(int i) {
      _currentDigit.value = i;
      if (_firstDigit.value == null) {
        _firstDigit.value = _currentDigit.value;
      } else if (_secondDigit.value == null) {
        _secondDigit.value = _currentDigit.value;
      } else if (_thirdDigit.value == null) {
        _thirdDigit.value = _currentDigit.value;
      } else if (_fourthDigit.value == null) {
        _fourthDigit.value = _currentDigit.value;

        _inputPin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        print('INPUT PIN is $_inputPin');
      }

      if (_inputPin.length == 4) {
        if (_inputPin == _pin) {
          Navigator.pop(context, false);
        } else {
          Fluttertoast.showToast(
            msg: _localization!.trans('PIN_MISMATCH')!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );

          _inputPin = '';
        }
      }
    }

    /// LocalAuthentication - Fingerprint
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    var _hasFingerPrintSupport = useState<bool>(false);

    Future<void> checkFingerprintSupport() async {
      bool isBiometricSupport = false;
      List<BiometricType> availableBiometricType = [];

      try {
        isBiometricSupport = await _localAuthentication.canCheckBiometrics;
        if (!isBiometricSupport) return;
      } catch (e) {
        print(e);
      }
      if (!mounted()) return;

      try {
        availableBiometricType =
            await _localAuthentication.getAvailableBiometrics();
      } catch (e) {
        print(e);
      }
      if (!mounted()) return;

      if (availableBiometricType.contains(BiometricType.fingerprint)) {
        _hasFingerPrintSupport.value = true;
      } else {
        _hasFingerPrintSupport.value = false;
      }
    }

    Future<void> _authenticateMe() async {
      // 8. this method opens a dialog for fingerprint authentication.
      //    we do not need to create a dialog nut it pop sup from device natively.
      bool authenticated = false;
      try {
        authenticated = await _localAuthentication.authenticate(
          localizedReason:
              _localization!.trans('FINGERPRINT_LOGIN')!, // message for dialog
          options: AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } catch (e) {
        print(e);
      }
      if (!mounted()) return;

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

    useEffect(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      checkFingerprintSupport();
      readLockPinFromSF();
      return () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
      };
    }, []);

    _localization = Localization.of(context);
    _screenSize = MediaQuery.of(context).size;

    void _deleteCurrentDigit() {
      if (_fourthDigit.value != null) {
        _fourthDigit.value = null;
      } else if (_thirdDigit.value != null) {
        _thirdDigit.value = null;
      } else if (_secondDigit.value != null) {
        _secondDigit.value = null;
      } else if (_firstDigit.value != null) {
        _firstDigit.value = null;
      }
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
              _localization!.trans('LOCK_HINT')!,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.displayMedium!.color),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _pinTextField(_firstDigit.value),
                  _pinTextField(_secondDigit.value),
                  _pinTextField(_thirdDigit.value),
                  _pinTextField(_fourthDigit.value),
                ],
              ),
            ),
            OutlinedButton(
              child: Text(
                _localization!.trans('FINGERPRINT_LOGIN')!,
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayMedium!.color),
              ),
              onPressed: _hasFingerPrintSupport.value ? _authenticateMe : null,
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
}
