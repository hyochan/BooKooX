import 'package:flutter/widgets.dart';
enum Membership {
  Owner,
  Admin,
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
  Membership membership;
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
    this.membership,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  void changeMemberShip(int val) {
    if (Membership.Owner.index == val) {
      membership = Membership.Owner;
    } else if (Membership.Admin.index == val) {
      membership = Membership.Admin;
    } else {
      membership = Membership.Guest;
    }
  }
}
