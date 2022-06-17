import 'package:wecount/models/category.dart' show Category;
import 'package:wecount/models/photo.dart';
import 'package:wecount/models/user.dart' show User;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LedgerItem {
  double? price;
  Category? category;
  String? memo;
  User? writer;
  DateTime? selectedDate;
  List<Photo>? picture;
  LatLng? latlng;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  LedgerItem({
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
    return this.toMap().toString();
  }

  /// specific function for condense() at homeStatistic
  /// make a new 'rough' copy of this
  /// this copy those properties that is being used. other properties not specified here is not being used
  /// this is being used to reduce boilerplate when creating new Ledger with same property values
  /// that means this is basically same with making new LedgerItem but less code
  LedgerItem createRoughCopy() {
    return LedgerItem(
      price: this.price,
      category: Category(
        iconId: this.category!.iconId,
        label: this.category!.label,
        type: this.category!.type,
      ),
      selectedDate: DateTime(this.selectedDate!.year, this.selectedDate!.month,
          this.selectedDate!.day),
    );
  }
}
