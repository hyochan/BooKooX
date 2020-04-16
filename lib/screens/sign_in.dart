import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bookoox/shared/button.dart' show Button;
import 'package:bookoox/shared/edit_text.dart' show EditText;
import 'package:bookoox/utils/general.dart' show General;
import 'package:bookoox/utils/localization.dart' show Localization;
import 'package:bookoox/utils/validator.dart' show Validator;

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  Localization _localization;
  ScrollController _scrollController = ScrollController();

  String _email;
  String _password;

  bool _isValidEmail = false;
  bool _isValidPassword = false;

  String _errorEmail;
  String _errorPassword;

  bool _isSigningIn = false;
  bool _isResendingEmail = false;

 void _signIn() async {
    if (_auth.currentUser() != null) {
      _auth.signOut();
    }

    if (!_isValidEmail) {
      setState(() => _errorEmail = _localization.trans('NO_VALID_EMAIL'));
      return;
    }

    if (!_isValidPassword) {
      setState(() => _errorPassword = _localization.trans('PASSWORD_HINT'));
      return;
    }

    setState(() => _isSigningIn = true);

    AuthResult auth;
    try {
      auth = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    } catch (err) {
        switch (err.code) {
          case 'ERROR_INVALID_EMAIL':
            setState(() => _errorEmail = _localization.trans(err.code));
            break;
          case 'ERROR_WRONG_PASSWORD':
            setState(() => _errorPassword = _localization.trans(err.code));
            break;
          case 'ERROR_USER_NOT_FOUND':
          case 'ERROR_USER_DISABLED':
          case 'ERROR_TOO_MANY_REQUESTS':
          case 'ERROR_OPERATION_NOT_ALLOWED':
            General.instance.showSingleDialog(
              context,
              title: Text(_localization.trans('ERROR')),
              content: Text(_localization.trans(err.code)),
            );
            break;
        }
        return;
    } finally {
      setState(() => _isSigningIn = false);
    }

    if (auth.user != null && !auth.user.isEmailVerified) {
      General.instance.showSingleDialog(
        context,
        title: Text(_localization.trans('ERROR')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(_localization.trans('EMAIL_NOT_VERIFIED')),
            Container(
              margin: EdgeInsets.only(top: 32, bottom: 24),
              child: Text(
                _email,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
            Button(
              height: 40,
              isLoading: _isResendingEmail,
              onPress: () async {
                setState(() => _isResendingEmail = true);
                try {
                  await auth.user.sendEmailVerification();
                } catch (err) {
                  print('unknown error occured. ${err.message}');
                } finally {
                  setState(() => _isResendingEmail = false);
                }
              },
              text: _localization.trans('RESEND_EMAIL'),
              textStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onPress: () => _auth.signOut(),
      );
      return;
    }

    /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
    General.instance.navigateScreenNamed(context, '/home', reset: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        hasChecked: _isValidEmail ?? false,
        hintStyle: TextStyle(
          color: Theme.of(context).hintColor
        ),
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            this.setState(() {
              _isValidEmail = true;
              _errorEmail = null;
              _email = str;
            });
          } else {
            this.setState(() {
              _isValidEmail = false;
              _email = str;
            });
          }
        },
        errorText: _errorEmail,
        onSubmitted: (String str) => _signIn(),
      );
    }

    Widget renderPasswordField() {
      bool isValidPassword = _password != null && _password.length > 0;

      return EditText(
        key: Key('password'),
        margin: EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization.trans('PASSWORD'),
        textHint: _localization.trans('PASSWORD_HINT'),
        isSecret: true,
        hasChecked: isValidPassword ?? false,
        onChanged: (String str) {
          if (isValidPassword) {
            this.setState(() {
              _isValidPassword = true;
              _errorPassword = null;
              _password = str;
            });
          } else {
            this.setState(() {
              _isValidPassword = false;
              _password = str;
            });
          }
        },
        errorText: _errorPassword,
        onSubmitted: (String str) => _signIn(),
      );
    }

    Widget renderSignInButton() {
      return Button(
        key: Key('signInButton'),
        onPress: _signIn,
        isLoading: _isSigningIn,
        margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        text: _localization.trans('SIGN_IN'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    Widget renderFindPw() {
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
                    renderFindPw(),
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