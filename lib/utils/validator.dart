class Validator {
  static final Validator instance = Validator();

  bool validateEmail(String email) {
    RegExp regExp = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    if (password.length < 6 ||
        !password.contains(RegExp(r'[A-z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    return true;
  }

  bool validateNicknameOrName(String str) {
    if (str.length < 3) {
      return false;
    }

    return true;
  }
}
