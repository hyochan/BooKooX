import './User.dart' show User;
import './LedgerItem.dart' show LedgerItem;

class Ledger {
  String title;
  int color;
  String description;
  int people;
  String owner;
  bool visible;
  DateTime createdAt;
  DateTime updatedAt;
  List<LedgerItem> items;
  List<User> members;

  Ledger({
    this.title,
    this.color,
    this.description,
    this.people,
    this.owner,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.members,
  });
}
