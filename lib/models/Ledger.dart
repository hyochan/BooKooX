import './LedgerItem.dart' show LedgerItem;

class Ledger {
  String title;
  int color;
  String description;
  int people;
  String ownerId;
  List<LedgerItem> items;
  // List<User> members;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Ledger({
    this.title,
    this.color,
    this.description,
    this.people,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.items,
    // this.members,
    this.deletedAt,
  });
}
