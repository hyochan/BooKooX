import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/widgets/edit_text.dart' show EditText;
import 'package:wecount/widgets/button.dart' show Button;
import 'package:wecount/utils/localization.dart';
import 'package:wecount/utils/validator.dart' show Validator;
import 'package:wecount/utils/asset.dart' as asset;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignUp extends HookWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = useState('');
    var password = useState('');
    var passwordConfirm = useState('');
    var displayName = useState('');
    var name = useState('');

    var errorEmail = useState('');
    var errorPassword = useState('');
    var errorPasswordConfirm = useState('');
    var errorDisplayName = useState('');
    var errorName = useState('');

    var isValidEmail = useState(false);
    var isValidPassword = useState(false);
    var isValidDisplayName = useState(false);
    var isValidName = useState(false);
    var isRegistering = useState(false);

    void signUp() async {
      if (email.value.isEmpty ||
          password.value.isEmpty ||
          passwordConfirm.value.isEmpty ||
          displayName.value.isEmpty ||
          name.value.isEmpty) {
        return;
      }

      if (!isValidEmail.value) {
        errorEmail.value = localization(context).noValidEmail;
        return;
      }

      if (!isValidPassword.value) {
        errorPassword.value = localization(context).passwordHint;
        return;
      }

      if (passwordConfirm != password) {
        errorPasswordConfirm.value = localization(context).passwordConfirmHint;
        return;
      }

      if (!isValidDisplayName.value) {
        errorDisplayName.value = localization(context).displayNameHint;
        return;
      }

      if (!isValidName.value) {
        errorName.value = localization(context).nameHint;
        return;
      }

      isRegistering.value = true;

      try {
        final User? user = (await _auth.createUserWithEmailAndPassword(
          email: email.value,
          password: password.value,
        ))
            .user;

        if (user != null) {
          await user.sendEmailVerification();
          await firestore.collection('users').doc(user.uid).set({
            'email': email.value,
            'displayName': displayName.value,
            'name': name.value,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
            'deletedAt': null,
          });

          user.updateDisplayName(displayName.value);

          if (context.mounted) {
            return General.instance.showSingleDialog(
              context,
              title: Text(
                localization(context).signUpSuccessTitle,
                style: TextStyle(
                    color: Theme.of(context).dialogTheme.titleTextStyle!.color),
              ),
              content: Text(
                localization(context).signUpSuccessContent,
                style: TextStyle(
                    color:
                        Theme.of(context).dialogTheme.contentTextStyle!.color),
              ),
              onPress: () {
                _auth.signOut();
                Navigator.of(context).pop();
              },
            );
          }
        }

        throw Error();
      } catch (err) {
        General.instance.showSingleDialog(
          context,
          title: Text(
            localization(context).signUpErrorTitle,
            style: TextStyle(
                color: Theme.of(context).dialogTheme.titleTextStyle!.color),
          ),
          content: Text(
            localization(context).signUpErrorContent,
            style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle!.color),
          ),
        );
      } finally {
        isRegistering.value = false;
      }
    }

    Widget renderSignUpText() {
      return Text(
        localization(context).signUp,
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
        label: localization(context).email,
        textHint: localization(context).emailHint,
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: isValidEmail.value,
        onChanged: (String str) {
          if (Validator.instance.validateEmail(str)) {
            isValidEmail.value = true;
            errorEmail.value = '';
          } else {
            isValidEmail.value = false;
          }

          email.value = str;
        },
        errorText: errorEmail.value,
        onSubmitted: (String str) => signUp(),
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
        textStyle: TextStyle(
            color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
        hasChecked: isValidPassword.value,
        onChanged: (String str) {
          if (Validator.instance.validatePassword(str)) {
            isValidPassword.value = true;
            errorPassword.value = '';
          } else {
            isValidPassword.value = false;
          }
          password.value = '';
        },
        errorText: errorPassword.value,
        onSubmitted: (String str) => signUp(),
      );
    }

    Widget renderPasswordConfirmField() {
      return EditText(
        key: const Key('password-confirm'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        label: localization(context).passwordConfirm,
        textHint: localization(context).passwordConfirmHint,
        isSecret: true,
        hasChecked: passwordConfirm.value.isNotEmpty &&
            passwordConfirm.value.isNotEmpty &&
            passwordConfirm.value == password.value,
        onChanged: (String str) {
          passwordConfirm.value = str;
          if (str == password.value) {
            errorPasswordConfirm.value = '';
          }
        },
        errorText: errorPasswordConfirm.value,
        onSubmitted: (String str) => signUp(),
      );
    }

    Widget renderDisplayNameField() {
      return EditText(
        key: const Key('display-name'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        label: localization(context).displayName,
        textHint: localization(context).displayNameHint,
        hasChecked: isValidDisplayName.value,
        onChanged: (String str) {
          if (Validator.instance.validateNicknameOrName(str)) {
            isValidDisplayName.value = true;
            errorDisplayName.value = '';
          } else {
            isValidDisplayName.value = false;
          }
          displayName.value = str;
        },
        errorText: errorDisplayName.value,
        onSubmitted: (String str) => signUp(),
      );
    }

    Widget renderNameField() {
      return EditText(
        key: const Key('name'),
        margin: const EdgeInsets.only(top: 24.0),
        textInputAction: TextInputAction.next,
        label: localization(context).name,
        textHint: localization(context).nameHint,
        hasChecked: isValidName.value,
        onChanged: (String str) {
          if (Validator.instance.validateNicknameOrName(str)) {
            isValidName.value = true;
            errorName.value = '';
          } else {
            isValidName.value = false;
          }
          name.value = str;
        },
        errorText: errorName.value,
        onSubmitted: (String str) => signUp(),
      );
    }

    Widget renderSignUpButton() {
      return Button(
        text: localization(context).signUp,
        loading: isRegistering.value,
        disabled: !isValidEmail.value ||
            !isValidPassword.value ||
            password.value != passwordConfirm.value ||
            !isValidDisplayName.value ||
            !isValidName.value,
        onPress: () => signUp(),
        margin: const EdgeInsets.only(top: 36.0, bottom: 48.0),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        borderColor: Colors.white,
        backgroundColor: asset.Colors.main,
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
