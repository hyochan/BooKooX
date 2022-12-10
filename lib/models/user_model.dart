import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wecount/utils/converter.dart';
import 'package:wecount/utils/logger.dart';

part "user_model.freezed.dart";
part "user_model.g.dart";

enum Membership {
  Owner,
  Admin,
  Guest,
}

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel(
      {required String displayName,
      String? googleId,
      String? name,
      String? email,
      String? selectedLedger,
      String? uid,
      String? thumbURL,
      String? photoURL,
      String? phoneNumber,
      String? statusMsg,
      bool? showEmailAddress,
      bool? showPhoneNumber,
      Membership? membership,
      @TimestampConverter() createdAt,
      @TimestampConverter() deletedAt,
      @TimestampConverter() updatedAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromMap(Map? data, String id) {
    data = data ?? {};
    return UserModel(
      uid: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      showEmailAddress: data['showEmailAddress'] ?? true,
      thumbURL: data['thumbURL'],
      photoURL: data['photoURL'],
      selectedLedger: data['selectedLedger'],
      phoneNumber: data['phoneNumber'] ?? '',
      showPhoneNumber: data['showPhoneNumber'] ?? false,
      statusMsg: data['statusMsg'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      deletedAt: data['deletedAt'],
    );
  }
  // void changeMemberShip(int val) {
  //   if (Membership.Owner.index == val) {
  //     membership = Membership.Owner;
  //   } else if (Membership.Admin.index == val) {
  //     membership = Membership.Admin;
  //   } else {
  //     membership = Membership.Guest;
  //   }
  // }
}
