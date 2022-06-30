import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wecount/shared/edit_text.dart' show EditText;
import 'package:wecount/utils/general.dart' show General;
import 'package:wecount/shared/button.dart' show Button;
import 'package:wecount/utils/logger.dart';
import 'package:wecount/utils/validator.dart' show Validator;

import '../utils/localization.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FindPw extends StatefulWidget {
  static const String name = '/find_pw';

  const FindPw({Key? key}) : super(key: key);

  @override
  State<FindPw> createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  String _email = '';
  String? _errorEmail;

  bool _isValidEmail = false;
  bool _isSendingEmail = false;

  void _findPw() async {
    bool isEmail = Validator.instance.validateEmail(_email);

    if (!isEmail) {
      setState(() => _errorEmail = t('NO_VALID_EMAIL'));
      return;
    }

    setState(() => _isSendingEmail = true);

    try {
      await _auth.sendPasswordResetEmail(email: _email);
      // ignore: use_build_context_synchronously
      General.instance.showSingleDialog(
        context,
        title: Text(t('SUCCESS')),
        content: Text(t('PASSWORD_RESET_LINK_SENT')),
      );
    } catch (err) {
      logger.e('error occurred: ${err.toString()}');
    } finally {
      setState(() => _isSendingEmail = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget findPwText() {
      return Text(
        t('FIND_PASSWORD'),
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.headline1!.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget emailField() {
      return EditText(
        key: const Key('email'),
        errorText: _errorEmail,
        margin: const EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: t('EMAIL'),
        textHint: t('EMAIL_HINT'),
        hasChecked: _isValidEmail,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            setState(() {
              _isValidEmail = true;
              _errorEmail = null;
            });
          } else {
            setState(() => _isValidEmail = false);
          }
          _email = str;
        },
        onSubmitted: (String str) => _findPw(),
      );
    }

    Widget sendButton() {
      return Button(
        key: const Key('sendButton'),
        onPress: _findPw,
        margin: const EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        isLoading: _isSendingEmail,
        borderColor: Theme.of(context).primaryIconTheme.color,
        backgroundColor: Theme.of(context).primaryColor,
        text: t('SEND_EMAIL'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
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
