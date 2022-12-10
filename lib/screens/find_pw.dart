import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/validator.dart' show Validator;
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/localization.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FindPw extends HookWidget {
  const FindPw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = useState('');
    var errorEmail = useState('');

    var isValidEmail = useState(false);
    var isSendingEmail = useState(false);

    void findPw() async {
      bool isEmail = Validator.instance.validateEmail(email.value);

      if (!isEmail) {
        errorEmail.value = localization(context).noValidEmail;
        return;
      }

      isSendingEmail.value = true;

      try {
        await _auth.sendPasswordResetEmail(email: email.value);

        if (context.mounted) {
          General.instance.showSingleDialog(
            context,
            title: Text(localization(context).success),
            content: Text(localization(context).passwordResetLinkSent),
          );
        }
      } catch (err) {
        logger.d('error occurred: ${err.toString()}');
      } finally {
        isSendingEmail.value = false;
      }
    }

    Widget findPwText() {
      return Text(
        localization(context).findPassword,
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.displayLarge!.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget emailField() {
      return EditText(
        key: const Key('email'),
        errorText: errorEmail.value,
        margin: const EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        label: localization(context).email,
        textHint: localization(context).emailHint,
        hasChecked: isValidEmail.value,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            isValidEmail.value = true;
            errorEmail.value = '';
          } else {
            isValidEmail.value = false;
          }
          email.value = str;
        },
        onSubmitted: (String str) => findPw(),
      );
    }

    Widget sendButton() {
      return Button(
        key: const Key('sendButton'),
        onPress: findPw,
        margin: const EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        loading: isSendingEmail.value,
        borderColor:
            Theme.of(context).primaryIconTheme.color ?? Colors.blueGrey,
        backgroundColor: Theme.of(context).primaryColor,
        text: localization(context).sendEmail,
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bg.defaultColor,
      appBar: AppBar(elevation: 0.0),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding:
                  const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    findPwText(),
                    emailField(),
                    sendButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
