import './Category.dart' show Category;
import './User.dart' show User;

class LedgerItem {
  double cost;
  Category category;
  String memo;
  User writer;
  DateTime selectedDate;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  LedgerItem({
    this.cost,
    this.category,
    this.memo,
    this.writer,
    this.selectedDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
}
