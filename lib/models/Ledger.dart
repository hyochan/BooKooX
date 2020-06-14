import 'package:bookoox/models/Currency.dart';
import 'package:bookoox/models/User.dart';
import 'package:bookoox/types/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<User> members;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Ledger({
    @required this.title,
    @required this.color,
    @required this.currency,
    this.description,

    /// Contain only the [int] number of members
    ///
    /// Since we don't need to render all member's data in first-hand
    /// We've seperated people to only fetch the length of the members
    this.people,

    /// Contain the full [User] data of members including photoURL
    /// 
    /// members will be fetched when needed
    this.members,
    this.ownerId,
    this.adminIds,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.deletedAt,
  });

  factory Ledger.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Ledger(
      title: data['title'] ?? '',
      color: colorItems[data['color'] ?? 1],
      currency: Currency(
        currency: data['currencyCode'],
        locale: data['currency'],
      ),
      people: List.from(data['members'] ?? []).length,
    );
  }

  factory Ledger.fromMap(Map data) {
    data = data ?? {};
    return Ledger(
      title: data['title'] ?? '',
      color: data['color'],
      currency: Currency(
        currency: data['currencyCode'],
        locale: data['currency'],
      ),
    );
  }

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
