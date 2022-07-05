import 'package:wecount/models/category_model.dart' show Category;
import 'package:wecount/models/photo_model.dart';
import 'package:wecount/models/user_model.dart' show UserModel;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LedgerItemModel {
  double? price;
  Category? category;
  String? memo;
  UserModel? writer;
  DateTime? selectedDate;
  List<PhotoModel>? picture;
  LatLng? latlng;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  LedgerItemModel({
    this.price,
    this.category,
    this.memo,
    this.writer,
    this.selectedDate,
    this.picture,
    this.latlng,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'category': category,
      'memo': memo,
      'writer': writer,
      'selectedDate': selectedDate,
      'picture': picture,
      'latlng': latlng,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  /// specific function for condense() at homeStatistic
  /// make a new 'rough' copy of this
  /// this copy those properties that is being used. other properties not specified here is not being used
  /// this is being used to reduce boilerplate when creating new Ledger with same property values
  /// that means this is basically same with making new LedgerItem but less code
  LedgerItemModel createRoughCopy() {
    return LedgerItemModel(
      price: price,
      category: Category(
        iconId: category!.iconId,
        label: category!.label,
        type: category!.type,
      ),
      selectedDate: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      ),
    );
  }
}
