import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wecount/navigations/auth_switch.dart';
import 'package:wecount/screens/sign_in.dart';
import 'package:wecount/screens/sign_up.dart';
import 'package:wecount/services/database.dart';
import 'package:wecount/shared/button.dart' show Button;
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/general.dart' show General;
import 'package:wecount/utils/localization.dart';

class Intro extends StatelessWidget {
  static const String name = '/intro';

  const Intro({Key? key}) : super(key: key);

  Future<void> _googleLogin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
    );
    General.instance.showSpinnerDialog(
      text: t('SIGNING_IN_WITH_GOOGLE'),
    );

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      await storeUser(googleUser);
      googleSignIn.signOut();

      Get.offAll(() => const AuthSwitch());
    } else {
      Get.back();
    }
  }

  Future<void> storeUser(GoogleSignInAccount googleUser) async {
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    UserCredential auth =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User user = auth.user!;

    DatabaseService().createUser(user, googleAuth.idToken);
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle signInWithTextStyle = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.7),
      fontSize: 16.0,
    );

    Widget renderSignInBtn() {
      return Button(
        onPress: () => Get.to(() => const SignIn()),
        margin: const EdgeInsets.only(top: 198.0),
        textStyle: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        text: t('SIGN_IN'),
        width: 240.0,
        height: 56.0,
      );
    }

    Widget renderDoNotHaveAccount() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: TextButton(
          onPressed: () =>
              General.instance.navigateScreenNamed(context, SignUp.name),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: t('DO_NOT_HAVE_ACCOUNT'),
                ),
                TextSpan(
                  text: '  ${t('SIGN_UP')}',
                  style: const TextStyle(
                    color: greenColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    Widget renderOrSignInWith() {
      return Container(
        margin: const EdgeInsets.only(top: 12.0),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: const <Widget>[
            Expanded(
              child: Text(
                '----------------------',
                style: signInWithTextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            Text(
              ' or sign in with ',
              style: signInWithTextStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            Expanded(
              child: Text(
                '----------------------',
                style: signInWithTextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
    }

    Widget renderGoogleSignInButton() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Button(
            margin: const EdgeInsets.only(top: 20.0),
            imageMarginLeft: 8,
            textStyle: signInWithTextStyle,
            borderColor: Colors.white,
            backgroundColor: Colors.transparent,
            text: 'Google',
            width: MediaQuery.of(context).size.width >
                    MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.width - 224
                : MediaQuery.of(context).size.width - 128,
            height: 52.0,
            image: Image(
              image: asset.Icons.icGoogle,
              width: 24.0,
              height: 24.0,
            ),
            onPress: () => _googleLogin(context),
          ),
        ],
      );
    }

    Widget renderTermsAndAgreement() {
      var clickableTextStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 13,
      );

      return Container(
        margin: const EdgeInsets.only(top: 16.0, bottom: 40.0),
        child: RichText(
          text: TextSpan(
            text: t('TERMS_1'),
            style: signInWithTextStyle.merge(
              const TextStyle(fontSize: 12, height: 1.3),
            ),
            children: [
              TextSpan(
                text: t('TERMS_OF_USE'),
                style: clickableTextStyle,
                semanticsLabel: t('TERMS_OF_USE'),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(
                      Uri.parse('https://dooboolab.com/termsofservice'),
                    );
                  },
              ),
              TextSpan(
                text: t('TERMS_2'),
                semanticsLabel: t('TERMS_2'),
              ),
              TextSpan(
                text: t('PRIVACY_POLICY'),
                style: clickableTextStyle,
                semanticsLabel: t('PRIVACY_POLICY'),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(
                      Uri.parse('https://dooboolab.com/privacyandpolicy'),
                    );
                  },
              ),
              TextSpan(
                text: t('TERMS_3'),
                semanticsLabel: t('TERMS_3'),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(
          height: double.infinity,
          width: double.infinity,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding:
                    const EdgeInsets.only(top: 148.0, left: 60.0, right: 60.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Image(
                        image: asset.Icons.icWeCount,
                        width: 200.0,
                        height: 60.0,
                      ),
                      renderSignInBtn(),
                      renderDoNotHaveAccount(),
                      renderOrSignInWith(),
                      renderGoogleSignInButton(),
                      renderTermsAndAgreement(),
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
