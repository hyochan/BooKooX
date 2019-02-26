import 'dart:async';

class TextFieldBloc {
  final _email  = StreamController<String>();
  final _password = StreamController<String>();
  final _passwordOk = StreamController<String>();
  final _displayName = StreamController<String>();

  Stream<String> get email => _email.stream;
  Stream<String> get password => _password.stream;
  Stream<String> get passwordOk => _passwordOk.stream;
  Stream<String> get displayName => _displayName.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePasswordOk => _password.sink.add;
  Function(String) get changeDisplayName => _displayName.sink.add;

  TextFieldBloc() {
    changeEmail('');
    changePassword('');
    changePasswordOk('');
    changeDisplayName('');
  }

  dispose() {
    _email.close();
    _password.close();
    _passwordOk.close();
    _displayName.close();
  }
}