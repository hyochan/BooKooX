import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wecount/screens/find_pw.dart';
import 'package:wecount/screens/main_empty.dart';

import 'package:wecount/shared/button.dart' show Button;
import 'package:wecount/shared/edit_text.dart' show EditText;
import 'package:wecount/utils/general.dart' show General;
import 'package:wecount/utils/validator.dart' show Validator;

import '../utils/localization.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignIn extends StatefulWidget {
  static const String name = '/sign_in';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ScrollController _scrollController = ScrollController();

  late String _email;
  String? _password;

  bool _isValidEmail = false;
  bool _isValidPassword = false;

  String? _errorEmail;
  String? _errorPassword;

  bool _isSigningIn = false;
  bool _isResendingEmail = false;

  void _signIn() async {
    if (_auth.currentUser != null) {
      _auth.signOut();
    }

    if (!_isValidEmail) {
      setState(() => _errorEmail = t('NO_VALID_EMAIL'));
      return;
    }

    if (!_isValidPassword) {
      setState(() => _errorPassword = t('PASSWORD_HINT'));
      return;
    }

    setState(() => _isSigningIn = true);

    UserCredential auth;
    try {
      auth = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password!);

      /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
      if (auth.user != null && auth.user!.emailVerified) {
        await _firestore
            .collection('users')
            .doc(auth.user!.uid)
            .collection('ledgers')
            .get();

        Get.offAll(() => const MainEmpty());
        return;
      }
    } catch (err) {
      setState(() => _isSigningIn = false);
      switch (err) {
        // case 'ERROR_INVALID_EMAIL':
        //   setState(() => _errorEmail = t(err.currency));
        //   break;
        // case 'ERROR_WRONG_PASSWORD':
        //   setState(() => _errorPassword = t(err.currency));
        //   break;
        case 'ERROR_USER_NOT_FOUND':
        case 'ERROR_USER_DISABLED':
        case 'ERROR_TOO_MANY_REQUESTS':
        case 'ERROR_OPERATION_NOT_ALLOWED':
          // General.instance.showSingleDialog(
          //   context,
          //   title: Text(t('ERROR')!),
          //   content: Text(t(err.currency)!),
          // );
          break;
      }
      return;
    }

    if (auth.user != null && !auth.user!.emailVerified) {
      // ignore: use_build_context_synchronously
      General.instance.showSingleDialog(
        context,
        title: Text(t('ERROR')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(t('EMAIL_NOT_VERIFIED')),
            Container(
              margin: const EdgeInsets.only(top: 32, bottom: 24),
              child: Text(
                _email,
                style: TextStyle(
                  fontSize: 24,
                  // ignore: use_build_context_synchronously
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
                  await auth.user!.sendEmailVerification();
                } catch (err) {
                  // logger.d('unknown error occurred. ${err.message}');
                } finally {
                  setState(() => _isResendingEmail = false);
                }
              },
              text: t('RESEND_EMAIL'),
              textStyle: TextStyle(
                // ignore: use_build_context_synchronously
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onPress: () => _auth.signOut(),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );

    Widget renderSignInText() {
      return Text(
        t('SIGN_IN'),
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.headline1!.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget renderEmailField() {
      return EditText(
        key: const Key('email'),
        margin: const EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: t('EMAIL'),
        textHint: t('EMAIL_HINT'),
        hasChecked: _isValidEmail,
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            setState(() {
              _isValidEmail = true;
              _errorEmail = null;
              _email = str;
            });
          } else {
            setState(() {
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
      bool isValidPassword = _password != null && _password!.isNotEmpty;

      return EditText(
        key: const Key('password'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: t('PASSWORD'),
        textHint: t('PASSWORD_HINT'),
        isSecret: true,
        hasChecked: isValidPassword,
        onChanged: (String str) {
          if (isValidPassword) {
            setState(() {
              _isValidPassword = true;
              _errorPassword = null;
              _password = str;
            });
          } else {
            setState(() {
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
        key: const Key('sign-in-button'),
        onPress: _signIn,
        isLoading: _isSigningIn,
        margin: const EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        text: t('SIGN_IN'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    Widget renderFindPw() {
      // ignore: deprecated_member_use
      return FlatButton(
        padding: const EdgeInsets.all(8),
        onPressed: () =>
            General.instance.navigateScreenNamed(context, FindPw.name),
        child: RichText(
          text: TextSpan(
            text: '${t('DID_YOU_FORGOT_PASSWORD')}?',
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xff869ab7),
            ),
            children: <TextSpan>[
              TextSpan(
                text: '  ${t('FIND_PASSWORD')}',
                style: const TextStyle(
                    color: Color(0xff1dd3a8), fontWeight: FontWeight.bold),
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
          color: Theme.of(context).textTheme.headline1!.color,
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
