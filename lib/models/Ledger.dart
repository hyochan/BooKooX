import 'package:bookoo2/models/Currency.dart';
import 'package:bookoo2/types/color.dart';

import './LedgerItem.dart' show LedgerItem;

class Ledger {
  String title;
  ColorType color;
  String description;
  int people;
  String ownerId;
  List<LedgerItem> items;
  Currency currency;
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
    this.currency,
    // this.members,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'title: $title, color: ${color.toString()}, '
      + 'description: $description, people: $people, ownerId: $ownerId, '
      + 'items: ${items.toString()}, currency: ${currency.toString()}, '
      + 'createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt'
    ;
  }
}
