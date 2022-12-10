import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/logger.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/pin_keyboard.dart' show PinKeyboard;

import 'package:wecount/utils/localization.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class LockAuth extends HookWidget {
  const LockAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mounted = useIsMounted();
    late Size screenSize;
    var currentDigit = useState<int?>(0);

    var firstDigit = useState<int?>(null);
    var secondDigit = useState<int?>(null);
    var thirdDigit = useState<int?>(null);
    var fourthDigit = useState<int?>(null);

    String? pin = '';
    String inputPin = '';

    void setCurrentDigit(int i) {
      currentDigit.value = i;
      if (firstDigit.value == null) {
        firstDigit.value = currentDigit.value;
      } else if (secondDigit.value == null) {
        secondDigit.value = currentDigit.value;
      } else if (thirdDigit.value == null) {
        thirdDigit.value = currentDigit.value;
      } else if (fourthDigit.value == null) {
        fourthDigit.value = currentDigit.value;

        inputPin = firstDigit.toString() +
            secondDigit.toString() +
            thirdDigit.toString() +
            fourthDigit.toString();

        logger.d('INPUT PIN is $inputPin');
      }

      if (inputPin.length == 4) {
        if (inputPin == pin) {
          Navigator.pop(context, false);
        } else {
          Fluttertoast.showToast(
            msg: localization(context).pinMismatch,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );

          inputPin = '';
        }
      }
    }

    /// LocalAuthentication - Fingerprint
    final LocalAuthentication localAuthentication = LocalAuthentication();
    var hasFingerPrintSupport = useState<bool>(false);

    Future<void> checkFingerprintSupport() async {
      bool isBiometricSupport = false;
      List<BiometricType> availableBiometricType = [];

      try {
        isBiometricSupport = await localAuthentication.canCheckBiometrics;
        if (!isBiometricSupport) return;
      } catch (e) {
        logger.e(e);
      }
      if (!mounted()) return;

      try {
        availableBiometricType =
            await localAuthentication.getAvailableBiometrics();
      } catch (e) {
        logger.e(e);
      }
      if (!mounted()) return;

      if (availableBiometricType.contains(BiometricType.fingerprint)) {
        hasFingerPrintSupport.value = true;
      } else {
        hasFingerPrintSupport.value = false;
      }
    }

    Future<void> authenticateMe() async {
      // 8. this method opens a dialog for fingerprint authentication.
      //    we do not need to create a dialog nut it pop sup from device natively.
      bool authenticated = false;
      try {
        authenticated = await localAuthentication.authenticate(
          localizedReason:
              localization(context).fingerprintLogin, // message for dialog
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } catch (e) {
        logger.e(e);
      }
      if (!mounted()) return;

      if (context.mounted && authenticated) {
        Navigator.pop(context, false);
      } else {
        return;
      }
    }

    Future<void> readLockPinFromSF() async {
      SharedPreferences preference = await SharedPreferences.getInstance();

      if (preference.containsKey('LOCK_PIN')) {
        pin = preference.getString('LOCK_PIN');
        logger.d(pin);
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

    screenSize = MediaQuery.of(context).size;

    void deleteCurrentDigit() {
      if (fourthDigit.value != null) {
        fourthDigit.value = null;
      } else if (thirdDigit.value != null) {
        thirdDigit.value = null;
      } else if (secondDigit.value != null) {
        secondDigit.value = null;
      } else if (firstDigit.value != null) {
        firstDigit.value = null;
      }
    }

    Widget pinTextField(int? digit) {
      return Container(
          width: 50,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).textTheme.displayLarge!.color!,
                width: 2,
              ),
            ),
          ),
          child: Text(
            digit != null ? digit.toString() : '',
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).textTheme.displayLarge!.color,
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
            const SizedBox(height: 40),
            Text(
              localization(context).lockHint,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.displayMedium!.color),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  pinTextField(firstDigit.value),
                  pinTextField(secondDigit.value),
                  pinTextField(thirdDigit.value),
                  pinTextField(fourthDigit.value),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: hasFingerPrintSupport.value ? authenticateMe : null,
              child: Text(
                localization(context).fingerprintLogin,
                style: TextStyle(
                    color: Theme.of(context).textTheme.displayMedium!.color),
              ),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(30),
              // ),
            ),
            const SizedBox(height: 50),
            PinKeyboard(
              keyboardHeight: screenSize.height / 3.0,
              onButtonPressed: setCurrentDigit,
              onDeletePressed: deleteCurrentDigit,
            ),
          ],
        ),
      ),
    );
  }
}
