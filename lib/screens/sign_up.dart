import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';

import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/navigation.dart';
import 'package:wecount/widgets/common/edit_text.dart' show EditText;
import 'package:wecount/widgets/common/button.dart' show Button;
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

    var isRegistering = useState(false);

    void signUp() async {
      if (email.value.isEmpty ||
          password.value.isEmpty ||
          passwordConfirm.value.isEmpty ||
          displayName.value.isEmpty ||
          name.value.isEmpty) {
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
                style: TextStyle(color: AppColors.text.disabled),
              ),
              content: Text(
                localization(context).signUpSuccessContent,
                style: TextStyle(color: AppColors.text.disabled),
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
            style: TextStyle(color: AppColors.text.primary),
          ),
          content: Text(
            localization(context).signUpErrorContent,
            style: TextStyle(color: AppColors.text.basic),
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
        textStyle: TextStyle(color: AppColors.text.basic),
        hasChecked: Validator.instance.validateEmail(email.value),
        onChanged: (str) => email.value = str,
        validator: (_) {
          if (Validator.instance.validateEmail(email.value)) {
            return localization(context).noValidEmail;
          }

          return null;
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
          color: AppColors.text.basic,
        ),
        hasChecked: Validator.instance.validatePassword(password.value),
        onChanged: (str) => password.value = str,
        validator: (_) {
          if (Validator.instance.validatePassword(password.value)) {
            return localization(context).noValidEmail;
          }

          return null;
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
        onChanged: (str) => passwordConfirm.value = str,
        validator: (_) {
          if (_ == password.value) {
            errorPasswordConfirm.value = localization(context).passwordNotMatch;
          }

          return null;
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
        hasChecked:
            Validator.instance.validateNicknameOrName(displayName.value),
        validator: (str) {
          if (!Validator.instance.validateNicknameOrName(displayName.value)) {
            return localization(context).displayNameNotValid;
          }

          return null;
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
        hasChecked: Validator.instance.validateNicknameOrName(name.value),
        validator: (_) {
          if (_ is String && Validator.instance.validateNicknameOrName(_)) {
            return localization(context).passwordNotMatch;
          }

          return null;
        },
        onChanged: (String str) => name.value = str,
        errorText: errorName.value,
        onSubmitted: (String str) => signUp(),
      );
    }

    Widget renderSignUpButton() {
      return Button(
        text: localization(context).signUp,
        loading: isRegistering.value,
        disabled: !Validator.instance.validateEmail(email.value) ||
            !Validator.instance.validatePassword(password.value) ||
            password.value != passwordConfirm.value ||
            !Validator.instance.validateNicknameOrName(displayName.value) ||
            !Validator.instance.validateNicknameOrName(name.value),
        onPress: () => signUp(),
        margin: const EdgeInsets.only(top: 36.0, bottom: 48.0),
        textStyle: TextStyle(
          color: AppColors.text.contrast,
          fontSize: 16.0,
        ),
        borderColor: AppColors.text.contrast,
        backgroundColor: AppColors.role.primary,
        width: MediaQuery.of(context).size.width / 2 - 64,
        height: 56.0,
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.bg.basic,
        iconTheme: IconThemeData(color: AppColors.text.basic),
      ),
      body: Container(
        color: AppColors.bg.basic,
        child: GestureDetector(
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
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
