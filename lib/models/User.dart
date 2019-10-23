import 'package:flutter/widgets.dart';
enum Membership {
  Owner,
  Writer,
  Guest,
}

class User {
  @required String uid;
  String email;
  @required String displayName;
  bool showEmailAddress;
  String thumbURL;
  String photoURL;
  String phoneNumber;
  bool showPhoneNumber;
  String statusMsg;
  List<String> ledgers;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  User({
    this.uid,
    this.email,
    this.displayName,
    this.showEmailAddress,
    this.thumbURL,
    this.photoURL,
    this.phoneNumber,
    this.showPhoneNumber,
    this.statusMsg,
    this.ledgers,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
}
