import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/navigation.dart';

import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:wecount/utils/validator.dart' show Validator;
import 'package:wecount/utils/asset.dart' as Asset;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignUp extends HookWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Localization? localization;

    String? email;
    String? password;
    String? passwordConfirm;
    String? displayName;
    String? name;

    var errorEmail = useState<String?>(null);
    var errorPassword = useState<String?>(null);
    var errorPasswordConfirm = useState<String?>(null);
    var errorDisplayName = useState<String?>(null);
    var errorName = useState<String?>(null);

    var isValidEmail = useState<bool>(false);
    var isValidPassword = useState<bool>(false);
    var isValidDisplayName = useState<bool>(false);
    var isValidName = useState<bool>(false);
    var isRegistering = useState<bool>(false);

    void _signUp() async {
      if (email == null ||
          password == null ||
          passwordConfirm == null ||
          displayName == null ||
          name == null) {
        return;
      }

      if (!isValidEmail.value) {
        errorEmail.value = localization!.trans('NO_VALID_EMAIL');
        return;
      }

      if (!isValidPassword.value) {
        errorPassword.value = localization!.trans('PASSWORD_HINT');
        return;
      }

      if (passwordConfirm != password) {
        errorPasswordConfirm.value =
            localization!.trans('PASSWORD_CONFIRM_HINT');
        return;
      }

      if (!isValidDisplayName.value) {
        errorDisplayName.value = localization!.trans('DISPLAY_NAME_HINT');
        return;
      }

      if (!isValidName.value) {
        errorName.value = localization!.trans('NAME_HINT');
        return;
      }

      isRegistering.value = true;

      try {
        final User? user = (await _auth.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        ))
            .user;

        if (user != null) {
          await user.sendEmailVerification();
          await firestore.collection('users').doc(user.uid).set({
            'email': email,
            'displayName': displayName,
            'name': name,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
            'deletedAt': null,
          });

          user.updateDisplayName(displayName);

          return navigation.showSingleDialog(
            context,
            title: Text(
              localization!.trans('SIGN_UP_SUCCESS_TITLE')!,
              style: TextStyle(
                  color: Theme.of(context).dialogTheme.titleTextStyle!.color),
            ),
            content: Text(
              localization.trans('SIGN_UP_SUCCESS_CONTENT')!,
              style: TextStyle(
                  color: Theme.of(context).dialogTheme.contentTextStyle!.color),
            ),
            onPress: () {
              _auth.signOut();
              Navigator.of(context).pop();
            },
          );
        }

        throw Error();
      } catch (err) {
        navigation.showSingleDialog(
          context,
          title: Text(
            localization!.trans('SIGN_UP_ERROR_TITLE')!,
            style: TextStyle(
                color: Theme.of(context).dialogTheme.titleTextStyle!.color),
          ),
          content: Text(
            localization.trans('SIGN_UP_ERROR_CONTENT')!,
            style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle!.color),
          ),
        );
      } finally {
        isRegistering.value = false;
      }
    }

    localization = Localization.of(context);

    Widget renderSignUpText() {
      return Text(
        localization!.trans('SIGN_UP')!,
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
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: isValidEmail.value,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            isValidEmail.value = true;
            errorEmail.value = null;
          } else {
            isValidEmail.value = false;
          }
          email = str;
        },
        errorText: errorEmail.value,
        onSubmitted: (String str) => _signUp(),
      );
    }

    Widget renderPasswordField() {
      return EditText(
        key: const Key('password'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: localization!.trans('PASSWORD'),
        textHint: localization.trans('PASSWORD_HINT'),
        isSecret: true,
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: isValidPassword.value,
        onChanged: (String str) {
          if (Validator.instance.validatePassword(str)) {
            isValidPassword.value = true;
            errorPassword.value = null;
          } else {
            isValidPassword.value = false;
          }
          password = str;
        },
        errorText: errorPassword.value,
        onSubmitted: (String str) => _signUp(),
      );
    }

    Widget renderPasswordConfirmField() {
      return EditText(
        key: const Key('password-confirm'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: localization!.trans('PASSWORD_CONFIRM'),
        textHint: localization.trans('PASSWORD_CONFIRM_HINT'),
        isSecret: true,
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: passwordConfirm != null &&
            passwordConfirm != '' &&
            passwordConfirm == password,
        onChanged: (String str) {
          passwordConfirm = str;
          if (str == password) {
            errorPasswordConfirm.value = null;
          }
        },
        errorText: errorPasswordConfirm.value,
        onSubmitted: (String str) => _signUp(),
      );
    }

    Widget renderDisplayNameField() {
      return EditText(
        key: const Key('display-name'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: localization!.trans('DISPLAY_NAME'),
        textHint: localization.trans('DISPLAY_NAME_HINT'),
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: isValidDisplayName.value,
        onChanged: (String str) {
          if (Validator.instance.validateNicknameOrName(str)) {
            isValidDisplayName.value = true;
            errorDisplayName.value = null;
          } else {
            isValidDisplayName.value = false;
          }
          displayName = str;
        },
        errorText: errorDisplayName.value,
        onSubmitted: (String str) => _signUp(),
      );
    }

    Widget renderNameField() {
      return EditText(
        key: const Key('name'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        textLabel: localization!.trans('NAME'),
        textHint: localization.trans('NAME_HINT'),
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: isValidName.value,
        onChanged: (String str) {
          if (Validator.instance.validateNicknameOrName(str)) {
            isValidName.value = true;
            errorName.value = null;
          } else {
            isValidName.value = false;
          }
          name = str;
        },
        errorText: errorName.value,
        onSubmitted: (String str) => _signUp(),
      );
    }

    Widget renderSignUpButton() {
      return Button(
        key: const Key('button-sign-up'),
        isLoading: isRegistering.value,
        onPress: () => _signUp(),
        margin: const EdgeInsets.only(top: 36.0, bottom: 48.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: Asset.Colors.main,
        text: localization!.trans('SIGN_UP'),
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        elevation: 0.0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.displayLarge!.color,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding:
                  const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    renderSignUpText(),
                    renderEmailField(),
                    renderPasswordField(),
                    renderPasswordConfirmField(),
                    renderDisplayNameField(),
                    renderNameField(),
                    renderSignUpButton(),
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
