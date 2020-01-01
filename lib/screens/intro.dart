import 'package:flutter/material.dart';

import 'package:bookoo2/shared/button.dart' show Button;
import 'package:bookoo2/utils/asset.dart' as Asset;
import 'package:bookoo2/utils/general.dart' show General;
import 'package:bookoo2/utils/localization.dart' show Localization;
import 'package:flutter/services.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light
    ));
    var _localization = Localization.of(context);
    final TextStyle _loginWithTextStyle = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.7),
      fontSize: 16.0,
    );

    Widget loginButton() {
      return Button(
        onPress: () => General.instance.navigateScreenNamed(context, '/login'),
        margin: EdgeInsets.only(top: 198.0),
        textStyle: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        text: _localization.trans('LOGIN'),
        width: 240.0,
        height: 56.0,
      );
    }

    Widget doNotHaveAccount() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () => General.instance.navigateScreenNamed(context, '/sign_up'),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: _localization.trans('DO_NOT_HAVE_ACCOUNT'),
                ),
                TextSpan(
                  text: '  ' + _localization.trans('SIGN_UP'),
                  style: TextStyle(
                      color: Asset.Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    Widget orLoginWith() {
      return Container(
        margin: EdgeInsets.only(top: 12.0),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Text(
                '----------------------',
                style: _loginWithTextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            Text(
              ' or login with ',
              style: _loginWithTextStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            Expanded(
              child: Text(
                '----------------------',
                style: _loginWithTextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
    }

    Widget socialLoginButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Button(
            margin: EdgeInsets.only(top: 20.0),
            textStyle: _loginWithTextStyle.merge(
              TextStyle(fontSize: 15.0),
            ),
            borderColor: Colors.white,
            backgroundColor: Colors.transparent,
            text: 'Facebook',
            width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
              ? MediaQuery.of(context).size.width / 2 - 112
              : MediaQuery.of(context).size.width / 2 - 64,
            height: 56.0,
            image: Image(
              image: Asset.Icons.icFacebook,
              width: 20.0,
              height: 20.0,
            ),
          ),
          Button(
            margin: EdgeInsets.only(top: 20.0),
            imageMarginLeft: 8,
            textStyle: _loginWithTextStyle,
            borderColor: Colors.white,
            backgroundColor: Colors.transparent,
            text: 'Google',
            width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
              ? MediaQuery.of(context).size.width / 2 - 112
              : MediaQuery.of(context).size.width / 2 - 64,
            height: 56.0,
            image: Image(
              image: Asset.Icons.icGoogle,
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      );
    }

    Widget termsAndAgreement() {
      return Container(
        margin: EdgeInsets.only(top: 16.0, bottom: 40.0),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () => General.instance.navigateScreenNamed(context, '/terms'),
          child: RichText(
            text: TextSpan(
              text: _localization.trans('TERMS_PRIVACY_AGREEMENT'),
              style: _loginWithTextStyle.merge(
                TextStyle(fontSize: 10.0),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.only(top: 148.0, left: 60.0, right: 60.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Image(image: Asset.Icons.icBooKoo, width: 200.0, height: 60.0),
                      loginButton(),
                      doNotHaveAccount(),
                      orLoginWith(),
                      socialLoginButtons(),
                      termsAndAgreement(),
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
          gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorDark],
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
