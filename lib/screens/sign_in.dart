import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/utils/routes.dart';

import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/validator.dart' show Validator;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class SignIn extends HookWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Localization? localization;
    var scrollController = useScrollController();

    var email = useState<String>("");
    var password = useState<String?>(null);

    var isValidEmail = useState<bool>(false);
    var isValidPassword = useState<bool>(false);

    var errorEmail = useState<String?>('');
    var errorPassword = useState<String?>('');

    var isSigningIn = useState<bool>(false);
    var isResendingEmail = useState<bool>(false);

    void signIn() async {
      if (_auth.currentUser != null) {
        _auth.signOut();
      }

      if (!isValidEmail.value) {
        errorEmail.value = localization!.trans('NO_VALIDemail');
        return;
      }

      if (!isValidPassword.value) {
        errorPassword.value = localization!.trans('PASSWORD_HINT');
        return;
      }

      isSigningIn.value = true;

      UserCredential auth;
      try {
        auth = await _auth.signInWithEmailAndPassword(
            email: email.value, password: password.value!);

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
          //   setState(() => errorEmail = localization!.trans(err.currency));
          //   break;
          // case 'ERROR_WRONGpassword':
          //   setState(() => errorPassword = localization!.trans(err.currency));
          //   break;
          case 'ERROR_USER_NOT_FOUND':
          case 'ERROR_USER_DISABLED':
          case 'ERROR_TOO_MANY_REQUESTS':
          case 'ERROR_OPERATION_NOT_ALLOWED':
            // General.instance.showSingleDialog(
            //   context,
            //   title: Text(localization!.trans('ERROR')!),
            //   content: Text(localization!.trans(err.currency)!),
            // );
            break;
        }
        return;
      }

      if (auth.user != null && !auth.user!.emailVerified && context.mounted) {
        General.instance.showSingleDialog(
          context,
          title: Text(localization!.trans('ERROR')!),
          onPress: () => _auth.signOut(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(localization.trans('EMAIL_NOT_VERIFIED')!),
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 24),
                child: Text(
                  email.value,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              Button(
                height: 40,
                isLoading: isResendingEmail.value,
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
                text: localization.trans('RESENDemail'),
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
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

    localization = Localization.of(context);
    scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );

    Widget renderSignInText() {
      return Text(
        localization!.trans('SIGN_IN')!,
        style: TextStyle(
          fontSize: 24.0,
          color: Theme.of(context).textTheme.displayLarge!.color,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget renderEmailField() {
      return EditText(
        key: const Key('email'),
        margin: const EdgeInsets.only(top: 68.0),
        textInputAction: TextInputAction.next,
        textLabel: localization!.trans('EMAIL'),
        textHint: localization.trans('EMAIL_HINT'),
        hasChecked: isValidEmail.value,
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            isValidEmail.value = true;
            errorEmail.value = null;
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
      bool hasChecked = password.value != null && password.value!.isNotEmpty;

      return EditText(
        key: const Key('password'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: localization!.trans('PASSWORD'),
        textHint: localization.trans('PASSWORD_HINT'),
        isSecret: true,
        hasChecked: hasChecked,
        onChanged: (String str) {
          if (hasChecked) {
            isValidPassword.value = true;
            errorPassword.value = null;
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
        isLoading: isSigningIn.value,
        margin: const EdgeInsets.only(top: 28.0, bottom: 8.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        text: localization!.trans('SIGN_IN'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    Widget renderFindPw() {
      return TextButton(
        onPressed: () => navigation.push(context, AppRoute.findPw.path),
        child: RichText(
          text: TextSpan(
            text: '${localization!.trans('DID_YOU_FORGOTpassword')}?',
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xff869ab7),
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' ${localization.trans('FINDpassword')!}',
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
