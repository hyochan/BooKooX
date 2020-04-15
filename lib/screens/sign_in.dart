import 'package:flutter/material.dart';

import 'package:bookoox/shared/edit_text.dart' show EditText;
import 'package:bookoox/shared/button.dart' show Button;
import 'package:bookoox/utils/general.dart' show General;
import 'package:bookoox/utils/localization.dart' show Localization;
import 'package:bookoox/utils/validator.dart' show Validator;

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  BuildContext _context;
  Localization _localization;
  ScrollController _scrollController = ScrollController();
  String _email;
  String _password;
  bool _isEmail;

 void _signIn() {
    if (_email == null || _password == null) {
      print('_email or _password is null.');
      return;
    }

    bool isEmail = Validator.instance.validateEmail(_email);

    if (!isEmail) {
      General.instance.showSingleDialog(_context,
        title: _localization.trans('ERROR'),
        content: _localization.trans('NO_VALID_EMAIL'),
      );
      return;
    }

    if (_password == null || _password.length == 0) {
      General.instance.showSingleDialog(_context,
        title: _localization.trans('ERROR'),
        content: _localization.trans('PASSWORD_HINT'),
      );
      return;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _localization = Localization.of(context);
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );

    Widget renderSignInText() {
      return Text(_localization.trans('SIGN_IN'),
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.headline1.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget renderEmailField() {
      return EditText(
        key: Key('email'),
        margin: EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization.trans('EMAIL'),
        textHint: _localization.trans('EMAIL_HINT'),
        hasChecked: _isEmail ?? false,
        hintStyle: TextStyle(
          color: Theme.of(context).hintColor
        ),
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            this.setState(() => _isEmail = true);
          } else {
            this.setState(() => _isEmail = false);
          }
          _email = str;
        },
        onSubmitted: (String str) => _signIn(),
      );
    }

    Widget renderPasswordField() {
      return EditText(
        key: Key('password'),
        obscureText: true,
        margin: EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization.trans('PASSWORD'),
        textHint: _localization.trans('PASSWORD_HINT'),
        isSecret: true,
        hasChecked: _password != null && _password.length > 0,
        onChanged: (String str) => this.setState(() => _password = str),
        onSubmitted: (String str) => _signIn(),
      );
    }

    Widget renderSignInButton() {
      return Button(
        key: Key('signInButton'),
        onPress: () => _signIn(),
        margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        text: _localization.trans('SIGN_IN'),
        width: MediaQuery.of(context).size.width / 2- 64,
        height: 56.0,
      );
    }

    Widget findPwButton() {
      return FlatButton(
        padding: EdgeInsets.all(8),
        onPressed: () => General.instance.navigateScreenNamed(context, '/find_pw'),
        child: RichText(
          text: TextSpan(
            text: '${_localization.trans('DID_YOU_FORGOT_PASSWORD')}?',
            style: TextStyle(
              fontSize: 12.0,
              color: const Color(0xff869ab7),
            ),
            children: <TextSpan>[
              TextSpan(
                text: '  ' + _localization.trans('FIND_PASSWORD'),
                style: TextStyle(
                    color: const Color(0xff1dd3a8),
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.headline1.color,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(top: 44, left: 60, right: 60, bottom: 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    renderSignInText(),
                    renderEmailField(),
                    renderPasswordField(),
                    renderSignInButton(),
                    findPwButton(),
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