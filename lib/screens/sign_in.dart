import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';

import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/common/button.dart' show Button;
import 'package:wecount/widgets/common/edit_text.dart' show EditText;
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/validator.dart' show Validator;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class SignIn extends HookWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollController = useScrollController();
    var email = useState('');
    var password = useState('');
    var errorEmail = useState('');
    var errorPassword = useState('');
    var isSigningIn = useState(false);
    var isResendingEmail = useState(false);
    var isEmailValid = Validator.instance.validateEmail(email.value);
    var isPasswordValid = password.value.isNotEmpty;

    void signIn() async {
      if (_auth.currentUser != null) {
        _auth.signOut();
      }

      if (!isEmailValid) {
        errorEmail.value = localization(context).noValidEmail;
        return;
      }

      if (!isPasswordValid) {
        errorPassword.value = localization(context).passwordHint;
        return;
      }

      isSigningIn.value = true;

      UserCredential auth;

      try {
        auth = await _auth.signInWithEmailAndPassword(
            email: email.value, password: password.value);

        /// Below can be removed if `StreamBuilder` in  [AuthSwitch] works correctly.
        if (auth.user != null && auth.user!.emailVerified) {
          var snapshots = await fireStore
              .collection('users')
              .doc(auth.user!.uid)
              .collection('ledgers')
              .get();

          var ledgers = snapshots.docs;

          if (context.mounted) {
            if (ledgers.isEmpty) {
              navigation.push(context, AppRoute.mainEmpty.path, reset: true);
              return;
            }

            navigation.push(context, AppRoute.homeTab.path, reset: true);
          }

          return;
        }
      } on FirebaseAuthException catch (err) {
        switch (err.code) {
          case 'ERROR_EMAIL_ALREADY_IN_USE':
          case 'account-exists-with-different-credential':
          case 'email-already-in-use':
            errorEmail.value =
                localization(context).accountExistsWithDifferentCredential;
            break;
          case 'ERROR_WRONG_PASSWORD':
          case 'wrong-password':
            errorEmail.value = localization(context).passwordNotMatch;
            break;
          case 'ERROR_USER_NOT_FOUND':
          case 'user-not-found':
            errorEmail.value = localization(context).userNotFound;
            break;
          case 'ERROR_USER_DISABLED':
          case 'user-disabled':
            errorEmail.value = localization(context).errorUserDisabled;
            break;
          case 'ERROR_TOO_MANY_REQUESTS':
          case 'too-many-requests':
            errorEmail.value = localization(context).tooManyRequests;
            break;
          case 'ERROR_OPERATION_NOT_ALLOWED':
          case 'operation-not-allowed':
            errorEmail.value = localization(context).errorOperationNotAllowed;
            break;
          case 'ERROR_INVALID_EMAIL':
          case 'invalid-email':
            errorEmail.value = localization(context).invalidEmailAddress;
            break;
          default:
            errorEmail.value = localization(context).loginFailed;
            break;
        }

        return;
      } finally {
        isSigningIn.value = false;
      }

      if (auth.user != null && !auth.user!.emailVerified && context.mounted) {
        General.instance.showSingleDialog(
          context,
          title: Text(localization(context).error),
          onPress: () => _auth.signOut(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(localization(context).emailNotVerified),
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 24),
                child: Text(
                  email.value,
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.role.secondary,
                  ),
                ),
              ),
              Button(
                height: 40,
                loading: isResendingEmail.value,
                onPress: () async {
                  isResendingEmail.value = true;
                  try {
                    await auth.user!.sendEmailVerification();
                  } catch (err) {
                    // print('unknown error occurred. ${err.message}');
                  } finally {
                    isResendingEmail.value = false;
                  }
                },
                text: localization(context).resendEmail,
                textStyle: TextStyle(
                  color: AppColors.role.secondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }
    }

    useEffect(() {
      return () {
        scrollController.dispose();
      };
    }, []);

    scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );

    Widget renderSignInText() {
      return Text(
        localization(context).signIn,
        style: TextStyle(
          fontSize: 24.0,
          color: AppColors.text.basic,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget renderEmailField() {
      return EditText(
        key: const Key('email'),
        margin: const EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        label: localization(context).email,
        textHint: localization(context).emailHint,
        hasChecked: isEmailValid,
        hintStyle: TextStyle(color: AppColors.text.placeholder),
        onChanged: (String str) => email.value = str,
        validator: (e) {
          if (!isEmailValid) {
            return localization(context).invalidEmailAddress;
          }

          return null;
        },
        errorText: errorEmail.value.trim(),
        onSubmitted: (String str) => signIn(),
      );
    }

    Widget renderPasswordField() {
      return EditText(
        key: const Key('password'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        label: localization(context).password,
        textHint: localization(context).passwordHint,
        isSecret: true,
        hasChecked: isPasswordValid,
        onChanged: (String str) => password.value = str,
        validator: (e) {
          if (!isPasswordValid) {
            return localization(context).passwordNotValid;
          }

          return null;
        },
        errorText: errorPassword.value,
        onSubmitted: (String str) => signIn(),
      );
    }

    Widget renderSignInButton() {
      return Button(
        key: const Key('sign-in-button'),
        onPress: signIn,
        disabled: !isPasswordValid || !isEmailValid,
        loading: isSigningIn.value,
        margin: const EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: AppColors.role.primary,
        text: localization(context).signIn,
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    Widget renderFindPw() {
      return TextButton(
        onPressed: () => navigation.push(context, AppRoute.findPw.path),
        child: RichText(
          text: TextSpan(
            text: '${localization(context).forgotPassword}?',
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xff869ab7),
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' ${localization(context).findPassword}',
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
      backgroundColor: AppColors.bg.basic,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.bg.basic,
        iconTheme: IconThemeData(
          color: AppColors.text.basic,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScrollView(
          controller: scrollController,
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
