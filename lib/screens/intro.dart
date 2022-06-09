import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wecount/shared/button.dart' show Button;
import 'package:wecount/utils/asset.dart' as Asset;
import 'package:wecount/utils/general.dart' show General;
import 'package:wecount/utils/localization.dart' show Localization;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class Intro extends StatelessWidget {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
    // clientId: "",
  );

  Future<Null> _googleLogin(BuildContext context) async {
    General.instance.showDialogSpinner(
      context,
      text: Localization.of(context).trans('SIGNING_IN_WITH_GOOGLE'),
    );

    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential auth = await _auth.signInWithCredential(credential);
      User user = auth.user;

      await firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'displayName': user.displayName,
        'name': user.displayName,
        'googleId': googleAuth.idToken,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'deletedAt': null,
      });
    } catch (error) {
      print('google signin err: $error');
    } finally {
      _googleSignIn.signOut();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness));
    var _localization = Localization.of(context);
    final TextStyle _signInWithTextStyle = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.7),
      fontSize: 16.0,
    );

    Widget renderSignInBtn() {
      return Button(
        onPress: () =>
            General.instance.navigateScreenNamed(context, '/sign_in'),
        margin: EdgeInsets.only(top: 198.0),
        textStyle: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        text: _localization.trans('SIGN_IN'),
        width: 240.0,
        height: 56.0,
      );
    }

    Widget renderDoNotHaveAccount() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () =>
              General.instance.navigateScreenNamed(context, '/sign_up'),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: _localization.trans('DO_NOT_HAVE_ACCOUNT'),
                ),
                TextSpan(
                  text: '  ' + _localization.trans('SIGN_UP'),
                  style: TextStyle(
                      color: Asset.Colors.green, fontWeight: FontWeight.bold),
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
        margin: EdgeInsets.only(top: 12.0),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Text(
                '----------------------',
                style: _signInWithTextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            Text(
              ' or sign in with ',
              style: _signInWithTextStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            Expanded(
              child: Text(
                '----------------------',
                style: _signInWithTextStyle,
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
            margin: EdgeInsets.only(top: 20.0),
            imageMarginLeft: 8,
            textStyle: _signInWithTextStyle,
            borderColor: Colors.white,
            backgroundColor: Colors.transparent,
            text: 'Google',
            width: MediaQuery.of(context).size.width >
                    MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.width - 224
                : MediaQuery.of(context).size.width - 128,
            height: 52.0,
            image: Image(
              image: Asset.Icons.icGoogle,
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
        color: Theme.of(context).accentColor,
        fontSize: 13,
      );

      return Container(
        margin: EdgeInsets.only(top: 16.0, bottom: 40.0),
        child: RichText(
          text: TextSpan(
            text: _localization.trans('TERMS_1'),
            style: _signInWithTextStyle.merge(
              TextStyle(fontSize: 12, height: 1.3),
            ),
            children: [
              TextSpan(
                text: _localization.trans('TERMS_OF_USE'),
                style: clickableTextStyle,
                semanticsLabel: _localization.trans('TERMS_OF_USE'),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    launch('https://dooboolab.com/termsofservice');
                  },
              ),
              TextSpan(
                text: _localization.trans('TERMS_2'),
                semanticsLabel: _localization.trans('TERMS_2'),
              ),
              TextSpan(
                text: _localization.trans('PRIVACY_POLICY'),
                style: clickableTextStyle,
                semanticsLabel: _localization.trans('PRIVACY_POLICY'),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    launch('https://dooboolab.com/privacyandpolicy');
                  },
              ),
              TextSpan(
                text: _localization.trans('TERMS_3'),
                semanticsLabel: _localization.trans('TERMS_3'),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      body: Container(
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
                          image: Asset.Icons.icWeCount,
                          width: 200.0,
                          height: 60.0),
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
        constraints: BoxConstraints.expand(
          height: double.infinity,
          width: double.infinity,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}
