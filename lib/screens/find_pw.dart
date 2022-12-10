import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/navigation.dart';

import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/validator.dart' show Validator;

final FirebaseAuth _auth = FirebaseAuth.instance;

class FindPw extends HookWidget {
  const FindPw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Localization? localization;
    var email = useState('');
    var errorEmail = useState('');

    var isValidEmail = useState(false);
    var isSendingEmail = useState(false);

    void findPw() async {
      bool isEmail = Validator.instance.validateEmail(email.value);

      if (!isEmail) {
        errorEmail.value = localization!.trans('NO_VALID_EMAIL') as String;
        return;
      }

      isSendingEmail.value = true;

      try {
        await _auth.sendPasswordResetEmail(email: email.value);
        if (context.mounted) {
          General.instance.showSingleDialog(
            context,
            title: Text(localization!.trans('SUCCESS')!),
            content: Text(localization.trans('PASSWORD_RESET_LINK_SENT')!),
          );
        }
      } catch (err) {
        logger.d('error occured: ${err.toString()}');
      } finally {
        isSendingEmail.value = false;
      }
    }

    localization = Localization.of(context);

    Widget findPwText() {
      return Text(
        localization!.trans('FIND_PASSWORD')!,
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
        textLabel: localization!.trans('EMAIL'),
        textHint: localization.trans('EMAIL_HINT'),
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
        isLoading: isSendingEmail.value,
        borderColor: Theme.of(context).primaryIconTheme.color,
        backgroundColor: Theme.of(context).primaryColor,
        text: localization!.trans('SEND_EMAIL'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        elevation: 0.0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
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
