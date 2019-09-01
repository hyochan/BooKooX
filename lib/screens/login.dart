import 'package:flutter/material.dart';

import '../shared/edit_text.dart' show EditText;
import '../shared/button.dart' show Button;
import '../utils/general.dart' show General;
import '../utils/localization.dart' show Localization;
import '../utils/validator.dart' show Validator;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  BuildContext _context;
  Localization _localization;
  ScrollController _scrollController = ScrollController();
  FocusNode _emailFocus = FocusNode();
  FocusNode _pwFocus = FocusNode();
  String _email;
  String _password;
  bool _isEmail;

  @override
  void dispose() {
    _scrollController.dispose();
    _emailFocus.dispose();
    _pwFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _localization = Localization.of(context);
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    _emailFocus = FocusNode();
    _pwFocus = FocusNode();

//    double bottomInset = MediaQuery.of(context).viewInsets.bottom;
//    if (bottomInset != 0.0) {
//      print('jump scroll controller');
//      _scrollController.jumpTo(100.0);
//    } else {
//      print('has clients');
//    }

    Widget loginText() {
      return Text(_localization.trans('LOGIN'),
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
        focusNode: _emailFocus,
        margin: EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization.trans('EMAIL'),
        textHint: _localization.trans('EMAIL_HINT'),
        hasChecked: _isEmail ?? false,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            this.setState(() => _isEmail = true);
          } else {
            this.setState(() => _isEmail = false);
          }
          _email = str;
        },
        onSubmitted: (String str) => _onLogin(),
      );
    }

    Widget passwordField() {
      return EditText(
        key: Key('password'),
        obscureText: true,
        focusNode: _pwFocus,
        margin: EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization.trans('PASSWORD'),
        textHint: _localization.trans('PASSWORD_HINT'),
        isSecret: true,
        hasChecked: _password != null && _password.length > 0,
        onChanged: (String str) => this.setState(() => _password = str),
        onSubmitted: (String str) => _onLogin(),
      );
    }

    Widget loginButton() {
      return Button(
        key: Key('loginButton'),
        onPress: () => _onLogin(),
        margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        text: _localization.trans('LOGIN'),
        width: MediaQuery.of(context).size.width / 2- 64,
        height: 56.0,
      );
    }

    Widget findPwButton() {
      return FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
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
        brightness: Theme.of(context).brightness,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  loginText(),
                  emailField(),
                  passwordField(),
                  loginButton(),
                  findPwButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLogin() {
    if (_email == null || _password == null) {
      print('_email or _password is null.');
      return;
    }

    bool isEmail = Validator.instance.validateEmail(_email);

    if (!isEmail) {
      General.instance.showDialogYes(_context,
        title: _localization.trans('ERROR'),
        content: _localization.trans('NO_VALID_EMAIL'),
      );
      return;
    }

    if (_password == null || _password.length == 0) {
      General.instance.showDialogYes(_context,
        title: _localization.trans('ERROR'),
        content: _localization.trans('PASSWORD_HINT'),
      );
      return;
    }
  }
}