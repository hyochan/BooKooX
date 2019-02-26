import 'package:flutter/material.dart';

import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;
import '../utils/general.dart' show General;
import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;
import '../utils/validator.dart' show Validator;

//class Login extends StatefulWidget {
//  Login({Key key}) : super(key: key);
//
//  @override
//  LoginState createState() => new LoginState();
//}

//class LoginState extends State<Login> {
class Login extends StatelessWidget {
  BuildContext _context;
  Localization _localization;
  ScrollController _scrollController;
  TextEditingController _emailController;
  TextEditingController _pwController;
  FocusNode _emailFocus;
  FocusNode _pwFocus;

  void _onLogin(String email, String password) {
    bool isEmail = Validator.instance.validateEmail(email);
    bool isPassword = Validator.instance.validatePassword(password);

    if (!isEmail) {
      General.instance.showDialogYes(_context,
          title: _localization.trans('ERROR'),
        content: _localization.trans('NO_VALID_EMAIL'),
      );
      return;
    }

    if (!isPassword) {
      General.instance.showDialogYes(_context,
        title: _localization.trans('ERROR'),
        content: _localization.trans('NO_VALID_PASSWORD'),
      );
      return;
    }
    print('onLogin');
  }

  void _onFindPw() {
    print('onFindPw');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _localization = Localization.of(context);
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    _emailController = TextEditingController();
    _emailFocus = FocusNode();
    _pwController = TextEditingController();
    _pwFocus = FocusNode();

//    double bottomInset = MediaQuery.of(context).viewInsets.bottom;
//    if (bottomInset != 0.0) {
//      print('jump scroll controller');
//      _scrollController.jumpTo(100.0);
//    } else {
//      print('has clients');
//    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.Colors.dusk,
        ),
      ),
      resizeToAvoidBottomPadding: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Text(_localization.trans('LOGIN'),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Theme.Colors.dusk,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  EditText(
                    focusNode: _emailFocus,
                    margin: EdgeInsets.only(top: 68.0),
                    textInputAction: TextInputAction.next,
                    textLabel: _localization.trans('EMAIL'),
                    textHint: _localization.trans('EMAIL_HINT'),
                    textEditingController: _emailController,
                    onSubmitted: (String str) {
                      if (_pwController.text == '') {
                        FocusScope.of(context).requestFocus(_pwFocus);
                      }
                      _emailController.text = str;
                    },
                  ),
                  EditText(
                    obscureText: true,
                    focusNode: _pwFocus,
                    margin: EdgeInsets.only(top: 24.0),
                    textInputAction: TextInputAction.next,
                    textLabel: _localization.trans('PASSWORD'),
                    textHint: _localization.trans('PASSWORD_HINT'),
                    textEditingController: _pwController,
                    isSecret: true,
                    onSubmitted: (String str) {
                      _pwController.text = str;
                      _onLogin(_emailController.text, _pwController.text);
                    },
                  ),
                  Button(
                    onPress: () => _onLogin(_emailController.text, _pwController.text),
                    margin: EdgeInsets.only(top: 28.0, bottom: 8.0),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    borderColor: Colors.white,
                    backgroundColor: Theme.Colors.dusk,
                    text: _localization.trans('LOGIN'),
                    width: MediaQuery.of(context).size.width / 2- 64,
                    height: 56.0,
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    onPressed: _onFindPw,
                    child: RichText(
                      text: TextSpan(
                        text: '${_localization.trans('DID_YOU_FORGOT_PASSWORD')}?',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.Colors.mediumGray,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '  ' + _localization.trans('FIND_PASSWORD'),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}