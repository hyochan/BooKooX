import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';

import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/widgets/edit_text.dart' show EditText;
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

    var isValidEmail = useState(false);
    var isValidPassword = useState(false);

    var errorEmail = useState('');
    var errorPassword = useState('');

    var isSigningIn = useState(false);
    var isResendingEmail = useState(false);

    void signIn() async {
      if (_auth.currentUser != null) {
        _auth.signOut();
      }

      if (!isValidEmail.value) {
        errorEmail.value = localization(context).noValidEmail;
        return;
      }

      if (!isValidPassword.value) {
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

          if (ledgers.isEmpty && context.mounted) {
            navigation.push(context, AppRoute.mainEmpty.path, reset: true);
            return;
          }
          if (context.mounted) {
            navigation.push(context, AppRoute.homeTab.path, reset: true);
          }
          return;
        }
      } catch (err) {
        isSigningIn.value = false;
        switch (err) {
          // case 'ERROR_INVALIDemail':
          //   setState(() => errorEmail = t(err.currency));
          //   break;
          // case 'ERROR_WRONGpassword':
          //   setState(() => errorPassword = t(err.currency));
          //   break;
          case 'errorUserNotFound':
          case 'errorUserDisabled':
          case 'errorManyRequests':
          case 'errorOperationNotAllowed':
            // General.instance.showSingleDialog(
            //   context,
            //   title: Text(t('error')),
            //   content: Text(t(err.currency)),
            // );
            break;
        }
        return;
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
        hasChecked: isValidEmail.value,
        hintStyle: TextStyle(color: AppColors.text.placeholder),
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            isValidEmail.value = true;
            errorEmail.value = '';
            email.value = str;
          } else {
            isValidEmail.value = false;
            email.value = str;
          }
        },
        errorText: errorEmail.value,
        onSubmitted: (String str) => signIn(),
      );
    }

    Widget renderPasswordField() {
      bool hasChecked = password.value.isNotEmpty && password.value.isNotEmpty;

      return EditText(
        key: const Key('password'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        label: localization(context).password,
        textHint: localization(context).passwordHint,
        isSecret: true,
        hasChecked: hasChecked,
        onChanged: (String str) {
          if (hasChecked) {
            isValidPassword.value = true;
            errorPassword.value = '';
            password.value = str;
          } else {
            isValidPassword.value = false;
            password.value = str;
          }
        },
        errorText: errorPassword.value,
        onSubmitted: (String str) => signIn(),
      );
    }

    Widget renderSignInButton() {
      return Button(
        key: const Key('sign-in-button'),
        onPress: signIn,
        disabled: !isValidEmail.value || !isValidPassword.value,
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
