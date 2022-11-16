import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/pin_keyboard.dart' show PinKeyboard;
import 'package:wecount/utils/localization.dart' show Localization;

class LockRegister extends HookWidget {
  const LockRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Size _screenSize;

    var _currentDigit = useState<int?>(null);

    var _firstDigit = useState<int?>(null);
    var _secondDigit = useState<int?>(null);
    var _thirdDigit = useState<int?>(null);
    var _fourthDigit = useState<int?>(null);

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

    useEffect(() {
      resetLockPinToSF();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

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

    var _localization = Localization.of(context)!;
    _screenSize = MediaQuery.of(context).size;

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

        _pin = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        print(_pin);
      }
    }

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
                  _pinTextField(_firstDigit.value),
                  _pinTextField(_secondDigit.value),
                  _pinTextField(_thirdDigit.value),
                  _pinTextField(_fourthDigit.value),
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
}
