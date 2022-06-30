import 'package:cloud_firestore/cloud_firestore.dart';

enum Membership {
  owner,
  admin,
  guest,
}

class User {
  String? uid;
  String? email;
  String? displayName;
  String? thumbURL;
  String? photoURL;
  String? phoneNumber;
  String? statusMsg;
  bool? showEmailAddress;
  bool? showPhoneNumber;
  Membership? membership;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  Timestamp? deletedAt;

  User({
    this.uid,
    this.email,
    this.displayName,
    this.thumbURL,
    this.photoURL,
    this.phoneNumber,
    this.statusMsg,
    this.showEmailAddress,
    this.showPhoneNumber,

    /// [membership] judges the permission of user in ledger.
    ///
    /// This will be fetched in the [members] screen.
    this.membership,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromMap(Map? data, String id) {
    data = data ?? {};
    return User(
      uid: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      showEmailAddress: data['showEmailAddress'] ?? true,
      thumbURL: data['thumbURL'],
      photoURL: data['photoURL'],
      phoneNumber: data['phoneNumber'] ?? '',
      showPhoneNumber: data['showPhoneNumber'] ?? false,
      statusMsg: data['statusMsg'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['createdAt'] ?? Timestamp.now(),
      deletedAt: data['createdAt'],
    );
  }

  void changeMemberShip(int val) {
    if (Membership.owner.index == val) {
      membership = Membership.owner;
    } else if (Membership.admin.index == val) {
      membership = Membership.admin;
    } else {
      membership = Membership.guest;
    }
  }
}
