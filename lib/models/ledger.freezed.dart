// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ledger _$LedgerFromJson(Map<String, dynamic> json) {
  return _Ledger.fromJson(json);
}

/// @nodoc
mixin _$Ledger {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ColorType get color => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get people => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  List<String> get adminIds => throw _privateConstructorUsedError;
  List<LedgerItem>? get items => throw _privateConstructorUsedError;
  Currency get currency => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  List<String>? get members => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  dynamic get createdAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  dynamic get updatedAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  dynamic get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LedgerCopyWith<Ledger> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerCopyWith<$Res> {
  factory $LedgerCopyWith(Ledger value, $Res Function(Ledger) then) =
      _$LedgerCopyWithImpl<$Res, Ledger>;
  @useResult
  $Res call(
      {String? id,
      String title,
      ColorType color,
      String? description,
      int? people,
      String? ownerId,
      List<String> adminIds,
      List<LedgerItem>? items,
      Currency currency,
      List<String> memberIds,
      List<String>? members,
      @ServerTimestampConverter() dynamic createdAt,
      @ServerTimestampConverter() dynamic updatedAt,
      @ServerTimestampConverter() dynamic deletedAt});

  $CurrencyCopyWith<$Res> get currency;
}

/// @nodoc
class _$LedgerCopyWithImpl<$Res, $Val extends Ledger>
    implements $LedgerCopyWith<$Res> {
  _$LedgerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? color = null,
    Object? description = freezed,
    Object? people = freezed,
    Object? ownerId = freezed,
    Object? adminIds = null,
    Object? items = freezed,
    Object? currency = null,
    Object? memberIds = null,
    Object? members = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorType,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      people: freezed == people
          ? _value.people
          : people // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminIds: null == adminIds
          ? _value.adminIds
          : adminIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<LedgerItem>?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency,
      memberIds: null == memberIds
          ? _value.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCopyWith<$Res> get currency {
    return $CurrencyCopyWith<$Res>(_value.currency, (value) {
      return _then(_value.copyWith(currency: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LedgerCopyWith<$Res> implements $LedgerCopyWith<$Res> {
  factory _$$_LedgerCopyWith(_$_Ledger value, $Res Function(_$_Ledger) then) =
      __$$_LedgerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      ColorType color,
      String? description,
      int? people,
      String? ownerId,
      List<String> adminIds,
      List<LedgerItem>? items,
      Currency currency,
      List<String> memberIds,
      List<String>? members,
      @ServerTimestampConverter() dynamic createdAt,
      @ServerTimestampConverter() dynamic updatedAt,
      @ServerTimestampConverter() dynamic deletedAt});

  @override
  $CurrencyCopyWith<$Res> get currency;
}

/// @nodoc
class __$$_LedgerCopyWithImpl<$Res>
    extends _$LedgerCopyWithImpl<$Res, _$_Ledger>
    implements _$$_LedgerCopyWith<$Res> {
  __$$_LedgerCopyWithImpl(_$_Ledger _value, $Res Function(_$_Ledger) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? color = null,
    Object? description = freezed,
    Object? people = freezed,
    Object? ownerId = freezed,
    Object? adminIds = null,
    Object? items = freezed,
    Object? currency = null,
    Object? memberIds = null,
    Object? members = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_Ledger(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorType,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      people: freezed == people
          ? _value.people
          : people // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminIds: null == adminIds
          ? _value._adminIds
          : adminIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<LedgerItem>?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency,
      memberIds: null == memberIds
          ? _value._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      members: freezed == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt ? _value.createdAt! : createdAt,
      updatedAt: freezed == updatedAt ? _value.updatedAt! : updatedAt,
      deletedAt: freezed == deletedAt ? _value.deletedAt! : deletedAt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ledger extends _Ledger {
  _$_Ledger(
      {this.id,
      required this.title,
      required this.color,
      this.description,
      this.people,
      this.ownerId,
      final List<String> adminIds = const [],
      final List<LedgerItem>? items,
      required this.currency,
      final List<String> memberIds = const [],
      final List<String>? members,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.updatedAt,
      @ServerTimestampConverter() this.deletedAt})
      : _adminIds = adminIds,
        _items = items,
        _memberIds = memberIds,
        _members = members,
        super._();

  factory _$_Ledger.fromJson(Map<String, dynamic> json) =>
      _$$_LedgerFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final ColorType color;
  @override
  final String? description;
  @override
  final int? people;
  @override
  final String? ownerId;
  final List<String> _adminIds;
  @override
  @JsonKey()
  List<String> get adminIds {
    if (_adminIds is EqualUnmodifiableListView) return _adminIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminIds);
  }

  final List<LedgerItem>? _items;
  @override
  List<LedgerItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Currency currency;
  final List<String> _memberIds;
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String>? _members;
  @override
  List<String>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @ServerTimestampConverter()
  final dynamic createdAt;
  @override
  @ServerTimestampConverter()
  final dynamic updatedAt;
  @override
  @ServerTimestampConverter()
  final dynamic deletedAt;

  @override
  String toString() {
    return 'Ledger(id: $id, title: $title, color: $color, description: $description, people: $people, ownerId: $ownerId, adminIds: $adminIds, items: $items, currency: $currency, memberIds: $memberIds, members: $members, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ledger &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.people, people) || other.people == people) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(other._adminIds, _adminIds) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      color,
      description,
      people,
      ownerId,
      const DeepCollectionEquality().hash(_adminIds),
      const DeepCollectionEquality().hash(_items),
      currency,
      const DeepCollectionEquality().hash(_memberIds),
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(deletedAt));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LedgerCopyWith<_$_Ledger> get copyWith =>
      __$$_LedgerCopyWithImpl<_$_Ledger>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LedgerToJson(
      this,
    );
  }
}

abstract class _Ledger extends Ledger {
  factory _Ledger(
      {final String? id,
      required final String title,
      required final ColorType color,
      final String? description,
      final int? people,
      final String? ownerId,
      final List<String> adminIds,
      final List<LedgerItem>? items,
      required final Currency currency,
      final List<String> memberIds,
      final List<String>? members,
      @ServerTimestampConverter() final dynamic createdAt,
      @ServerTimestampConverter() final dynamic updatedAt,
      @ServerTimestampConverter() final dynamic deletedAt}) = _$_Ledger;
  _Ledger._() : super._();

  factory _Ledger.fromJson(Map<String, dynamic> json) = _$_Ledger.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  ColorType get color;
  @override
  String? get description;
  @override
  int? get people;
  @override
  String? get ownerId;
  @override
  List<String> get adminIds;
  @override
  List<LedgerItem>? get items;
  @override
  Currency get currency;
  @override
  List<String> get memberIds;
  @override
  List<String>? get members;
  @override
  @ServerTimestampConverter()
  dynamic get createdAt;
  @override
  @ServerTimestampConverter()
  dynamic get updatedAt;
  @override
  @ServerTimestampConverter()
  dynamic get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$_LedgerCopyWith<_$_Ledger> get copyWith =>
      throw _privateConstructorUsedError;
}
