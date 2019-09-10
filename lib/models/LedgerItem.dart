
import 'package:bookoo2/models/Category.dart' show Category;
import 'package:bookoo2/models/Photo.dart';
import 'package:bookoo2/models/User.dart' show User;

class LedgerItem {
  double price;
  Category category;
  String memo;
  User writer;
  DateTime selectedDate;
  List<Photo> picture;
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
