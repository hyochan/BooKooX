import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecount/utils/logger.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/widgets/pin_keyboard.dart' show PinKeyboard;
import 'package:wecount/utils/localization.dart';

class LockRegister extends HookWidget {
  const LockRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Size screenSize;

    var currentDigit = useState<int?>(null);

    var firstDigit = useState<int?>(null);
    var secondDigit = useState<int?>(null);
    var thirdDigit = useState<int?>(null);
    var fourthDigit = useState<int?>(null);

    String? pin = '';

    Future<void> readLockPinFromSF() async {
      SharedPreferences preference = await SharedPreferences.getInstance();

      if (preference.containsKey('LOCK_PIN')) {
        pin = preference.getString('LOCK_PIN');
        logger.d(pin);
      }
    }

    Future<void> addLockPinToSF() async {
      if (pin!.length != 4) {
        return;
      } else {
        SharedPreferences preference = await SharedPreferences.getInstance();
        preference.setString('LOCK_PIN', pin!);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }

    Future<void> resetLockPinToSF() async {
      SharedPreferences preference = await SharedPreferences.getInstance();
      preference.remove('LOCK_PIN');
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

    screenSize = MediaQuery.of(context).size;

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

        pin = firstDigit.toString() +
            secondDigit.toString() +
            thirdDigit.toString() +
            fourthDigit.toString();

        logger.d(pin);
      }
    }

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
        iconColor: Theme.of(context).textTheme.displayLarge!.color,
        brightness: Theme.of(context).brightness,
        actions: <Widget>[
          TextButton(
            onPressed: addLockPinToSF,
            child: Text(
              localization(context).done,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color,
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
              localization(context).lockHint,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.displayLarge!.color),
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
            // OutlineButton(
            //   child:
            //   Text(_t('fingerprintSetup')),
            //   onPressed: () {} ,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
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
