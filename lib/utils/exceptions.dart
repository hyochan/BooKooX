class UserNotSignedInException implements Exception {
  UserNotSignedInException();

  @override
  String toString() {
    return '로그인이 필요합니다';
  }
}
