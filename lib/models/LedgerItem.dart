import 'package:bookoo2/models/Category.dart' show Category;
import 'package:bookoo2/models/Photo.dart';
import 'package:bookoo2/models/User.dart' show User;
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LedgerItem {
  double price;
  Category category;
  String memo;
  User writer;
  DateTime selectedDate;
  List<Photo> picture;
  LatLng latlng;
  Address address;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

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
  LedgerItem createRoughCopy() {
    return new LedgerItem(
      price: this.price,
      category: new Category(
        iconId: this.category.iconId,
        label: this.category.label,
        type: this.category.type,
      ),
      selectedDate: new DateTime(this.selectedDate.year,
          this.selectedDate.month, this.selectedDate.day),
    );
  }
}
