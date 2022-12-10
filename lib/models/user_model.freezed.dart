// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get displayName => throw _privateConstructorUsedError;
  String? get googleId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get selectedLedger => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  String? get thumbURL => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get statusMsg => throw _privateConstructorUsedError;
  bool? get showEmailAddress => throw _privateConstructorUsedError;
  bool? get showPhoneNumber => throw _privateConstructorUsedError;
  Membership? get membership => throw _privateConstructorUsedError;
  @TimestampConverter()
  dynamic get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  dynamic get deletedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  dynamic get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String displayName,
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
      @TimestampConverter() dynamic createdAt,
      @TimestampConverter() dynamic deletedAt,
      @TimestampConverter() dynamic updatedAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? googleId = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? selectedLedger = freezed,
    Object? uid = freezed,
    Object? thumbURL = freezed,
    Object? photoURL = freezed,
    Object? phoneNumber = freezed,
    Object? statusMsg = freezed,
    Object? showEmailAddress = freezed,
    Object? showPhoneNumber = freezed,
    Object? membership = freezed,
    Object? createdAt = null,
    Object? deletedAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      googleId: freezed == googleId
          ? _value.googleId
          : googleId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedLedger: freezed == selectedLedger
          ? _value.selectedLedger
          : selectedLedger // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbURL: freezed == thumbURL
          ? _value.thumbURL
          : thumbURL // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      statusMsg: freezed == statusMsg
          ? _value.statusMsg
          : statusMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      showEmailAddress: freezed == showEmailAddress
          ? _value.showEmailAddress
          : showEmailAddress // ignore: cast_nullable_to_non_nullable
              as bool?,
      showPhoneNumber: freezed == showPhoneNumber
          ? _value.showPhoneNumber
          : showPhoneNumber // ignore: cast_nullable_to_non_nullable
              as bool?,
      membership: freezed == membership
          ? _value.membership
          : membership // ignore: cast_nullable_to_non_nullable
              as Membership?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String displayName,
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
      @TimestampConverter() dynamic createdAt,
      @TimestampConverter() dynamic deletedAt,
      @TimestampConverter() dynamic updatedAt});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? googleId = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? selectedLedger = freezed,
    Object? uid = freezed,
    Object? thumbURL = freezed,
    Object? photoURL = freezed,
    Object? phoneNumber = freezed,
    Object? statusMsg = freezed,
    Object? showEmailAddress = freezed,
    Object? showPhoneNumber = freezed,
    Object? membership = freezed,
    Object? createdAt = null,
    Object? deletedAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_UserModel(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      googleId: freezed == googleId
          ? _value.googleId
          : googleId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedLedger: freezed == selectedLedger
          ? _value.selectedLedger
          : selectedLedger // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbURL: freezed == thumbURL
          ? _value.thumbURL
          : thumbURL // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      statusMsg: freezed == statusMsg
          ? _value.statusMsg
          : statusMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      showEmailAddress: freezed == showEmailAddress
          ? _value.showEmailAddress
          : showEmailAddress // ignore: cast_nullable_to_non_nullable
              as bool?,
      showPhoneNumber: freezed == showPhoneNumber
          ? _value.showPhoneNumber
          : showPhoneNumber // ignore: cast_nullable_to_non_nullable
              as bool?,
      membership: freezed == membership
          ? _value.membership
          : membership // ignore: cast_nullable_to_non_nullable
              as Membership?,
      createdAt: null == createdAt ? _value.createdAt : createdAt,
      deletedAt: null == deletedAt ? _value.deletedAt : deletedAt,
      updatedAt: null == updatedAt ? _value.updatedAt : updatedAt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel extends _UserModel {
  const _$_UserModel(
      {required this.displayName,
      this.googleId,
      this.name,
      this.email,
      this.selectedLedger,
      this.uid,
      this.thumbURL,
      this.photoURL,
      this.phoneNumber,
      this.statusMsg,
      this.showEmailAddress,
      this.showPhoneNumber,
      this.membership,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.deletedAt,
      @TimestampConverter() this.updatedAt})
      : super._();

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String displayName;
  @override
  final String? googleId;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? selectedLedger;
  @override
  final String? uid;
  @override
  final String? thumbURL;
  @override
  final String? photoURL;
  @override
  final String? phoneNumber;
  @override
  final String? statusMsg;
  @override
  final bool? showEmailAddress;
  @override
  final bool? showPhoneNumber;
  @override
  final Membership? membership;
  @override
  @TimestampConverter()
  final dynamic createdAt;
  @override
  @TimestampConverter()
  final dynamic deletedAt;
  @override
  @TimestampConverter()
  final dynamic updatedAt;

  @override
  String toString() {
    return 'UserModel(displayName: $displayName, googleId: $googleId, name: $name, email: $email, selectedLedger: $selectedLedger, uid: $uid, thumbURL: $thumbURL, photoURL: $photoURL, phoneNumber: $phoneNumber, statusMsg: $statusMsg, showEmailAddress: $showEmailAddress, showPhoneNumber: $showPhoneNumber, membership: $membership, createdAt: $createdAt, deletedAt: $deletedAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.googleId, googleId) ||
                other.googleId == googleId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.selectedLedger, selectedLedger) ||
                other.selectedLedger == selectedLedger) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.thumbURL, thumbURL) ||
                other.thumbURL == thumbURL) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.statusMsg, statusMsg) ||
                other.statusMsg == statusMsg) &&
            (identical(other.showEmailAddress, showEmailAddress) ||
                other.showEmailAddress == showEmailAddress) &&
            (identical(other.showPhoneNumber, showPhoneNumber) ||
                other.showPhoneNumber == showPhoneNumber) &&
            (identical(other.membership, membership) ||
                other.membership == membership) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      displayName,
      googleId,
      name,
      email,
      selectedLedger,
      uid,
      thumbURL,
      photoURL,
      phoneNumber,
      statusMsg,
      showEmailAddress,
      showPhoneNumber,
      membership,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(deletedAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String displayName,
      final String? googleId,
      final String? name,
      final String? email,
      final String? selectedLedger,
      final String? uid,
      final String? thumbURL,
      final String? photoURL,
      final String? phoneNumber,
      final String? statusMsg,
      final bool? showEmailAddress,
      final bool? showPhoneNumber,
      final Membership? membership,
      @TimestampConverter() final dynamic createdAt,
      @TimestampConverter() final dynamic deletedAt,
      @TimestampConverter() final dynamic updatedAt}) = _$_UserModel;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get displayName;
  @override
  String? get googleId;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get selectedLedger;
  @override
  String? get uid;
  @override
  String? get thumbURL;
  @override
  String? get photoURL;
  @override
  String? get phoneNumber;
  @override
  String? get statusMsg;
  @override
  bool? get showEmailAddress;
  @override
  bool? get showPhoneNumber;
  @override
  Membership? get membership;
  @override
  @TimestampConverter()
  dynamic get createdAt;
  @override
  @TimestampConverter()
  dynamic get deletedAt;
  @override
  @TimestampConverter()
  dynamic get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
