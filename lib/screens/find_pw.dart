import 'package:flutter/material.dart';

import '../shared/edit_text.dart' show EditText;
import '../shared/button.dart' show Button;
import '../utils/localization.dart' show Localization;
import '../utils/validator.dart' show Validator;

class FindPw extends StatefulWidget {
  FindPw({Key key}) : super(key: key);

  @override
  _FindPwState createState() => new _FindPwState();
}

class _FindPwState extends State<FindPw> {
  Localization _localization;
  String _email = '';
  String _emailError;
  bool _isEmail;

  @override
  Widget build(BuildContext context) {
    _localization = Localization.of(context);

    Widget findPwText() {
      return Text(_localization.trans('FIND_PASSWORD'),
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget emailField() {
      return EditText(
        key: Key('email'),
        errorText: _emailError,
        margin: EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization.trans('EMAIL'),
        textHint: _localization.trans('EMAIL_HINT'),
        hasChecked: _isEmail ?? false,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            setState(() {
              _isEmail = true;
              _emailError = null;
            });
          } else {
            setState(() => _isEmail = false);
          }
          _email = str;
        },
        onSubmitted: (String str) => _onFindPw(),
      );
    }

    Widget sendButton() {
      return Button(
        key: Key('sendButton'),
        onPress: () => _onFindPw(),
        margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Theme.of(context).primaryIconTheme.color,
        backgroundColor: Theme.of(context).primaryColor,
        text: _localization.trans('SEND_EMAIL'),
        width: MediaQuery.of(context).size.width / 2- 64,
        height: 56.0,
      );
    }


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
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
    );
  }

  void _onFindPw() {
    bool isEmail = Validator.instance.validateEmail(_email);

    if (!isEmail) {
      setState(() => _emailError = _localization.trans('NO_VALID_EMAIL'));
      return;
    }

    print('onFindPw');
  }
}
