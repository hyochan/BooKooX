// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      displayName: json['displayName'] as String,
      googleId: json['googleId'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      selectedLedger: json['selectedLedger'] as String?,
      uid: json['uid'] as String?,
      thumbURL: json['thumbURL'] as String?,
      photoURL: json['photoURL'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      statusMsg: json['statusMsg'] as String?,
      showEmailAddress: json['showEmailAddress'] as bool?,
      showPhoneNumber: json['showPhoneNumber'] as bool?,
      membership: $enumDecodeNullable(_$MembershipEnumMap, json['membership']),
      createdAt: json['createdAt'],
      deletedAt: json['deletedAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'googleId': instance.googleId,
      'name': instance.name,
      'email': instance.email,
      'selectedLedger': instance.selectedLedger,
      'uid': instance.uid,
      'thumbURL': instance.thumbURL,
      'photoURL': instance.photoURL,
      'phoneNumber': instance.phoneNumber,
      'statusMsg': instance.statusMsg,
      'showEmailAddress': instance.showEmailAddress,
      'showPhoneNumber': instance.showPhoneNumber,
      'membership': _$MembershipEnumMap[instance.membership],
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'updatedAt': instance.updatedAt,
    };

const _$MembershipEnumMap = {
  Membership.owner: 'owner',
  Membership.admin: 'admin',
  Membership.guest: 'guest',
};
