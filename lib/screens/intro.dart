import 'package:flutter/material.dart';
import '../utils/general.dart' show General;
import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;
import '../widgets/button.dart' show Button;

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    final TextStyle _loginWithTextStyle = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.7),
      fontSize: 16.0,
    );

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.only(top: 102.0, left: 60.0, right: 60.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Image(image: Theme.Icons.icBooKoo, width: 200.0, height: 60.0),
                      Button(
                        onPress: () => General.instance.navigateScreenNamed(context, '/login'),
                        margin: EdgeInsets.only(top: 198.0),
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          color: Theme.Colors.dusk,
                        ),
                        backgroundColor: Colors.white,
                        text: _localization.trans('LOGIN'),
                        width: 240.0,
                        height: 56.0,
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(
                            text: _localization.trans('DO_NOT_HAVE_ACCOUNT'),
                            children: <TextSpan>[
                              TextSpan(
                                text: '  ' + _localization.trans('SIGN_UP'),
                                style: TextStyle(
                                    color: Theme.Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Button(
                            margin: EdgeInsets.only(top: 20.0),
                            textStyle: _loginWithTextStyle.merge(
                              TextStyle(fontSize: 15.0),
                            ),
                            borderColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            text: '  Facebook',
                            width: MediaQuery.of(context).size.width / 2 - 64,
                            height: 56.0,
                            image: Image(
                              image: Theme.Icons.icFacebookW,
                            ),
                          ),
                          Button(
                            margin: EdgeInsets.only(top: 20.0),
                            textStyle: _loginWithTextStyle,
                            borderColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            text: '  Google',
                            width: MediaQuery.of(context).size.width / 2- 64,
                            height: 56.0,
                            image: Image(
                              image: Theme.Icons.icGoogleW,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0, bottom: 40.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {},
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
                      ),
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
          gradient: LinearGradient(colors: [Theme.Colors.dusk, Theme.Colors.darkGray],
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
