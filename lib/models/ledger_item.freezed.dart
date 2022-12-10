// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ledger_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LedgerItem _$LedgerItemFromJson(Map<String, dynamic> json) {
  return _LedgerItem.fromJson(json);
}

/// @nodoc
mixin _$LedgerItem {
  double? get price => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  UserModel? get writer => throw _privateConstructorUsedError;
  DateTime? get selectedDate => throw _privateConstructorUsedError;
  List<Photo>? get picture => throw _privateConstructorUsedError;
  String? get latlng => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LedgerItemCopyWith<LedgerItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerItemCopyWith<$Res> {
  factory $LedgerItemCopyWith(
          LedgerItem value, $Res Function(LedgerItem) then) =
      _$LedgerItemCopyWithImpl<$Res, LedgerItem>;
  @useResult
  $Res call(
      {double? price,
      Category? category,
      String? memo,
      UserModel? writer,
      DateTime? selectedDate,
      List<Photo>? picture,
      String? latlng,
      String? address,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt,
      @ServerTimestampConverter() DateTime? deletedAt});

  $CategoryCopyWith<$Res>? get category;
  $UserModelCopyWith<$Res>? get writer;
}

/// @nodoc
class _$LedgerItemCopyWithImpl<$Res, $Val extends LedgerItem>
    implements $LedgerItemCopyWith<$Res> {
  _$LedgerItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = freezed,
    Object? category = freezed,
    Object? memo = freezed,
    Object? writer = freezed,
    Object? selectedDate = freezed,
    Object? picture = freezed,
    Object? latlng = freezed,
    Object? address = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      writer: freezed == writer
          ? _value.writer
          : writer // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as List<Photo>?,
      latlng: freezed == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get writer {
    if (_value.writer == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.writer!, (value) {
      return _then(_value.copyWith(writer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LedgerItemCopyWith<$Res>
    implements $LedgerItemCopyWith<$Res> {
  factory _$$_LedgerItemCopyWith(
          _$_LedgerItem value, $Res Function(_$_LedgerItem) then) =
      __$$_LedgerItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? price,
      Category? category,
      String? memo,
      UserModel? writer,
      DateTime? selectedDate,
      List<Photo>? picture,
      String? latlng,
      String? address,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt,
      @ServerTimestampConverter() DateTime? deletedAt});

  @override
  $CategoryCopyWith<$Res>? get category;
  @override
  $UserModelCopyWith<$Res>? get writer;
}

/// @nodoc
class __$$_LedgerItemCopyWithImpl<$Res>
    extends _$LedgerItemCopyWithImpl<$Res, _$_LedgerItem>
    implements _$$_LedgerItemCopyWith<$Res> {
  __$$_LedgerItemCopyWithImpl(
      _$_LedgerItem _value, $Res Function(_$_LedgerItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = freezed,
    Object? category = freezed,
    Object? memo = freezed,
    Object? writer = freezed,
    Object? selectedDate = freezed,
    Object? picture = freezed,
    Object? latlng = freezed,
    Object? address = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_LedgerItem(
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      writer: freezed == writer
          ? _value.writer
          : writer // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      picture: freezed == picture
          ? _value._picture
          : picture // ignore: cast_nullable_to_non_nullable
              as List<Photo>?,
      latlng: freezed == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LedgerItem extends _LedgerItem {
  _$_LedgerItem(
      {this.price,
      this.category,
      this.memo,
      this.writer,
      this.selectedDate,
      final List<Photo>? picture,
      this.latlng,
      this.address,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.updatedAt,
      @ServerTimestampConverter() this.deletedAt})
      : _picture = picture,
        super._();

  factory _$_LedgerItem.fromJson(Map<String, dynamic> json) =>
      _$$_LedgerItemFromJson(json);

  @override
  final double? price;
  @override
  final Category? category;
  @override
  final String? memo;
  @override
  final UserModel? writer;
  @override
  final DateTime? selectedDate;
  final List<Photo>? _picture;
  @override
  List<Photo>? get picture {
    final value = _picture;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? latlng;
  @override
  final String? address;
  @override
  @ServerTimestampConverter()
  final DateTime? createdAt;
  @override
  @ServerTimestampConverter()
  final DateTime? updatedAt;
  @override
  @ServerTimestampConverter()
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'LedgerItem(price: $price, category: $category, memo: $memo, writer: $writer, selectedDate: $selectedDate, picture: $picture, latlng: $latlng, address: $address, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LedgerItem &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.writer, writer) || other.writer == writer) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._picture, _picture) &&
            (identical(other.latlng, latlng) || other.latlng == latlng) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      price,
      category,
      memo,
      writer,
      selectedDate,
      const DeepCollectionEquality().hash(_picture),
      latlng,
      address,
      createdAt,
      updatedAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LedgerItemCopyWith<_$_LedgerItem> get copyWith =>
      __$$_LedgerItemCopyWithImpl<_$_LedgerItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LedgerItemToJson(
      this,
    );
  }
}

abstract class _LedgerItem extends LedgerItem {
  factory _LedgerItem(
      {final double? price,
      final Category? category,
      final String? memo,
      final UserModel? writer,
      final DateTime? selectedDate,
      final List<Photo>? picture,
      final String? latlng,
      final String? address,
      @ServerTimestampConverter() final DateTime? createdAt,
      @ServerTimestampConverter() final DateTime? updatedAt,
      @ServerTimestampConverter() final DateTime? deletedAt}) = _$_LedgerItem;
  _LedgerItem._() : super._();

  factory _LedgerItem.fromJson(Map<String, dynamic> json) =
      _$_LedgerItem.fromJson;

  @override
  double? get price;
  @override
  Category? get category;
  @override
  String? get memo;
  @override
  UserModel? get writer;
  @override
  DateTime? get selectedDate;
  @override
  List<Photo>? get picture;
  @override
  String? get latlng;
  @override
  String? get address;
  @override
  @ServerTimestampConverter()
  DateTime? get createdAt;
  @override
  @ServerTimestampConverter()
  DateTime? get updatedAt;
  @override
  @ServerTimestampConverter()
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$_LedgerItemCopyWith<_$_LedgerItem> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  int? get id => throw _privateConstructorUsedError;
  int? get iconId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  CategoryType? get type => throw _privateConstructorUsedError;
  bool get showDelete => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call(
      {int? id,
      int? iconId,
      String label,
      CategoryType? type,
      bool showDelete});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? iconId = freezed,
    Object? label = null,
    Object? type = freezed,
    Object? showDelete = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      iconId: freezed == iconId
          ? _value.iconId
          : iconId // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CategoryType?,
      showDelete: null == showDelete
          ? _value.showDelete
          : showDelete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$$_CategoryCopyWith(
          _$_Category value, $Res Function(_$_Category) then) =
      __$$_CategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? iconId,
      String label,
      CategoryType? type,
      bool showDelete});
}

/// @nodoc
class __$$_CategoryCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$_Category>
    implements _$$_CategoryCopyWith<$Res> {
  __$$_CategoryCopyWithImpl(
      _$_Category _value, $Res Function(_$_Category) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? iconId = freezed,
    Object? label = null,
    Object? type = freezed,
    Object? showDelete = null,
  }) {
    return _then(_$_Category(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      iconId: freezed == iconId
          ? _value.iconId
          : iconId // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CategoryType?,
      showDelete: null == showDelete
          ? _value.showDelete
          : showDelete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Category extends _Category {
  _$_Category(
      {this.id,
      this.iconId,
      required this.label,
      this.type,
      this.showDelete = false})
      : super._();

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryFromJson(json);

  @override
  final int? id;
  @override
  final int? iconId;
  @override
  final String label;
  @override
  final CategoryType? type;
  @override
  @JsonKey()
  final bool showDelete;

  @override
  String toString() {
    return 'Category(id: $id, iconId: $iconId, label: $label, type: $type, showDelete: $showDelete)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Category &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.iconId, iconId) || other.iconId == iconId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.showDelete, showDelete) ||
                other.showDelete == showDelete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, iconId, label, type, showDelete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      __$$_CategoryCopyWithImpl<_$_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryToJson(
      this,
    );
  }
}

abstract class _Category extends Category {
  factory _Category(
      {final int? id,
      final int? iconId,
      required final String label,
      final CategoryType? type,
      final bool showDelete}) = _$_Category;
  _Category._() : super._();

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  @override
  int? get id;
  @override
  int? get iconId;
  @override
  String get label;
  @override
  CategoryType? get type;
  @override
  bool get showDelete;
  @override
  @JsonKey(ignore: true)
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      throw _privateConstructorUsedError;
}

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return _Photo.fromJson(json);
}

/// @nodoc
mixin _$Photo {
  dynamic get file => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  bool? get isAddBtn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res, Photo>;
  @useResult
  $Res call({dynamic file, String? url, bool? isAddBtn});
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res, $Val extends Photo>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? url = freezed,
    Object? isAddBtn = freezed,
  }) {
    return _then(_value.copyWith(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as dynamic,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isAddBtn: freezed == isAddBtn
          ? _value.isAddBtn
          : isAddBtn // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhotoCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$_PhotoCopyWith(_$_Photo value, $Res Function(_$_Photo) then) =
      __$$_PhotoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic file, String? url, bool? isAddBtn});
}

/// @nodoc
class __$$_PhotoCopyWithImpl<$Res> extends _$PhotoCopyWithImpl<$Res, _$_Photo>
    implements _$$_PhotoCopyWith<$Res> {
  __$$_PhotoCopyWithImpl(_$_Photo _value, $Res Function(_$_Photo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? url = freezed,
    Object? isAddBtn = freezed,
  }) {
    return _then(_$_Photo(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as dynamic,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isAddBtn: freezed == isAddBtn
          ? _value.isAddBtn
          : isAddBtn // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Photo extends _Photo {
  _$_Photo({this.file, this.url, this.isAddBtn}) : super._();

  factory _$_Photo.fromJson(Map<String, dynamic> json) =>
      _$$_PhotoFromJson(json);

  @override
  final dynamic file;
  @override
  final String? url;
  @override
  final bool? isAddBtn;

  @override
  String toString() {
    return 'Photo(file: $file, url: $url, isAddBtn: $isAddBtn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Photo &&
            const DeepCollectionEquality().equals(other.file, file) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isAddBtn, isAddBtn) ||
                other.isAddBtn == isAddBtn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(file), url, isAddBtn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotoCopyWith<_$_Photo> get copyWith =>
      __$$_PhotoCopyWithImpl<_$_Photo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhotoToJson(
      this,
    );
  }
}

abstract class _Photo extends Photo {
  factory _Photo(
      {final dynamic file, final String? url, final bool? isAddBtn}) = _$_Photo;
  _Photo._() : super._();

  factory _Photo.fromJson(Map<String, dynamic> json) = _$_Photo.fromJson;

  @override
  dynamic get file;
  @override
  String? get url;
  @override
  bool? get isAddBtn;
  @override
  @JsonKey(ignore: true)
  _$$_PhotoCopyWith<_$_Photo> get copyWith =>
      throw _privateConstructorUsedError;
}
