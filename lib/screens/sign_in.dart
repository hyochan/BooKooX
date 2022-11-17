import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/validator.dart' show Validator;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignIn extends HookWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Localization? _localization;
    var _scrollController = useScrollController();

    var _email = useState<String>("");
    var _password = useState<String?>(null);

    var _isValidEmail = useState<bool>(false);
    var _isValidPassword = useState<bool>(false);

    var _errorEmail = useState<String?>('');
    var _errorPassword = useState<String?>('');

    var _isSigningIn = useState<bool>(false);
    var _isResendingEmail = useState<bool>(false);

    void _signIn() async {
      if (_auth.currentUser != null) {
        _auth.signOut();
      }

      if (!_isValidEmail.value) {
        _errorEmail.value = _localization!.trans('NO_VALID_EMAIL');
        return;
      }

      if (!_isValidPassword.value) {
        _errorPassword.value = _localization!.trans('PASSWORD_HINT');
        return;
      }

      _isSigningIn.value = true;

      UserCredential auth;
      try {
        auth = await _auth.signInWithEmailAndPassword(
            email: _email.value, password: _password.value!);

        /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
        if (auth.user != null && auth.user!.emailVerified) {
          var snapshots = await _firestore
              .collection('users')
              .doc(auth.user!.uid)
              .collection('ledgers')
              .get();

          var ledgers = snapshots.docs;

          if (ledgers.length == 0) {
            navigation.push(context, AppRoute.mainEmpty.path, reset: true);
            return;
          }

          navigation.push(context, AppRoute.homeTab.path, reset: true);
          return;
        }
      } catch (err) {
        _isSigningIn.value = false;
        switch (err) {
          // case 'ERROR_INVALID_EMAIL':
          //   setState(() => _errorEmail = _localization!.trans(err.currency));
          //   break;
          // case 'ERROR_WRONG_PASSWORD':
          //   setState(() => _errorPassword = _localization!.trans(err.currency));
          //   break;
          case 'ERROR_USER_NOT_FOUND':
          case 'ERROR_USER_DISABLED':
          case 'ERROR_TOO_MANY_REQUESTS':
          case 'ERROR_OPERATION_NOT_ALLOWED':
            // General.instance.showSingleDialog(
            //   context,
            //   title: Text(_localization!.trans('ERROR')!),
            //   content: Text(_localization!.trans(err.currency)!),
            // );
            break;
        }
        return;
      }

      if (auth.user != null && !auth.user!.emailVerified) {
        navigation.showSingleDialog(
          context,
          title: Text(_localization!.trans('ERROR')!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(_localization!.trans('EMAIL_NOT_VERIFIED')!),
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 24),
                child: Text(
                  _email.value,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              Button(
                height: 40,
                isLoading: _isResendingEmail.value,
                onPress: () async {
                  _isResendingEmail.value = true;
                  try {
                    await auth.user!.sendEmailVerification();
                  } catch (err) {
                    // print('unknown error occurred. ${err.message}');
                  } finally {
                    _isResendingEmail.value = false;
                  }
                },
                text: _localization!.trans('RESEND_EMAIL'),
                textStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          onPress: () => _auth.signOut(),
        );
      }
    }

    useEffect(() {
      return () {
        _scrollController.dispose();
      };
    }, []);

    _localization = Localization.of(context);
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );

    Widget renderSignInText() {
      return Text(
        _localization!.trans('SIGN_IN')!,
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.displayLarge!.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget renderEmailField() {
      return EditText(
        key: Key('email'),
        margin: EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization!.trans('EMAIL'),
        textHint: _localization!.trans('EMAIL_HINT'),
        hasChecked: _isValidEmail.value,
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            _isValidEmail.value = true;
            _errorEmail.value = null;
            _email.value = str;
          } else {
            _isValidEmail.value = false;
            _email.value = str;
          }
        },
        errorText: _errorEmail.value,
        onSubmitted: (String str) => _signIn(),
      );
    }

    Widget renderPasswordField() {
      bool isValidPassword = _password != null && _password.value!.length > 0;

      return EditText(
        key: Key('password'),
        margin: EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: _localization!.trans('PASSWORD'),
        textHint: _localization!.trans('PASSWORD_HINT'),
        isSecret: true,
        hasChecked: isValidPassword,
        onChanged: (String str) {
          if (isValidPassword) {
            _isValidPassword.value = true;
            _errorPassword.value = null;
            _password.value = str;
          } else {
            _isValidPassword.value = false;
            _password.value = str;
          }
        },
        errorText: _errorPassword.value,
        onSubmitted: (String str) => _signIn(),
      );
    }

    Widget renderSignInButton() {
      return Button(
        key: Key('sign-in-button'),
        onPress: _signIn,
        isLoading: _isSigningIn.value,
        margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        text: _localization!.trans('SIGN_IN'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    Widget renderFindPw() {
      return TextButton(
        onPressed: () => navigation.push(context, AppRoute.findPw.path),
        child: RichText(
          text: TextSpan(
            text: '${_localization!.trans('DID_YOU_FORGOT_PASSWORD')}?',
            style: TextStyle(
              fontSize: 12.0,
              color: const Color(0xff869ab7),
            ),
            children: <TextSpan>[
              TextSpan(
                text: '  ' + _localization!.trans('FIND_PASSWORD')!,
                style: TextStyle(
                    color: const Color(0xff1dd3a8),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.displayLarge!.color,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(
                  top: 44, left: 60, right: 60, bottom: 40),
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
