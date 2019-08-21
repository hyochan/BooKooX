class User {
  String uid;
  String email;
  bool showEmailAddress;
  String thumbURL;
  String photoURL;
  String phoneNumber;
  bool showPhoneNumber;
  String statusMsg;
  List<String> ledgers;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    this.uid,
    this.email,
    this.showEmailAddress,
    this.thumbURL,
    this.photoURL,
    this.phoneNumber,
    this.showPhoneNumber,
    this.statusMsg,
    this.ledgers,
    this.createdAt,
    this.updatedAt,
  });
}
