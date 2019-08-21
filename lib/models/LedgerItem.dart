import './Category.dart' show Category;

class LedgerItem {
  double cost;
  Category category;
  String memo;
  String writerId;
  DateTime selectedDate;
  DateTime createdAt;
  DateTime updatedAt;

  LedgerItem({
    this.cost,
    this.category,
    this.memo,
    this.writerId,
    this.selectedDate,
    this.createdAt,
    this.updatedAt,
  });
}
