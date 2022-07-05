import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Membership {
  owner,
  admin,
  guest,
}

class UserModel {
  String? uid;
  String? email;
  String? displayName;
  String? thumbURL;
  String? photoURL;
  String? phoneNumber;
  String? statusMsg;
  String? selectedLedgerId;
  bool? showEmailAddress;
  bool? showPhoneNumber;
  Membership? membership;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  Timestamp? deletedAt;

  UserModel({
    this.uid,
    this.email,
    this.displayName,
    this.thumbURL,
    this.photoURL,
    this.phoneNumber,
    this.statusMsg,
    this.selectedLedgerId,
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

  factory UserModel.fromJson(Map? data, String id) {
    data = data ?? {};

    return UserModel(
      uid: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      showEmailAddress: data['showEmailAddress'] ?? true,
      thumbURL: data['thumbURL'],
      photoURL: data['photoURL'],
      phoneNumber: data['phoneNumber'] ?? '',
      showPhoneNumber: data['showPhoneNumber'] ?? false,
      statusMsg: data['statusMsg'] ?? '',
      selectedLedgerId: data['selectedLedgerId'],
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['createdAt'] ?? Timestamp.now(),
      deletedAt: data['createdAt'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'displayName': displayName,
      'showEmailAddress': showEmailAddress,
      'thumbURL': thumbURL,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'showPhoneNumber': showPhoneNumber,
      'statusMsg': statusMsg,
      'selectedLedgerId': selectedLedgerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  static bool isSignIn() => FirebaseAuth.instance.currentUser != null;

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
