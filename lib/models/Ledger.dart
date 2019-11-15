import 'package:bookoo2/models/Currency.dart';
import 'package:bookoo2/types/color.dart';
import 'package:flutter/material.dart';

import './LedgerItem.dart' show LedgerItem;

final List<ColorType> colorItems = [
  ColorType.PURPLE,
  ColorType.DUSK,
  ColorType.BLUE,
  ColorType.GREEN,
  ColorType.YELLOW,
  ColorType.ORANGE,
  ColorType.RED,
];
class Ledger {
  String title;
  ColorType color;
  String description;
  int people;
  String ownerId;
  List<String> adminIds;
  List<LedgerItem> items;
  Currency currency;
  // List<User> members;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Ledger({
    @required this.title,
    @required this.color,
    @required this.currency,
    this.description,
    this.people,
    this.ownerId,
    this.adminIds,
    this.createdAt,
    this.updatedAt,
    this.items,
    // this.members,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'title: $title, color: ${color.toString()}, '
      + 'description: $description, people: $people, ownerId: $ownerId, '
      + 'adminIds: $adminIds, '
      + 'items: ${items.toString()}, currency: ${currency.toString()}, '
      + 'createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt'
    ;
  }
}
