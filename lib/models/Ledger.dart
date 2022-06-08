import 'package:bookoox/models/Currency.dart';
import 'package:bookoox/models/User.dart';
import 'package:bookoox/types/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './LedgerItem.dart' show LedgerItem;

final List<ColorType> colorItems = [
  ColorType.RED,
  ColorType.ORANGE,
  ColorType.YELLOW,
  ColorType.GREEN,
  ColorType.BLUE,
  ColorType.DUSK,
  ColorType.PURPLE,
];

class Ledger {
  String id;
  String title;
  ColorType color;
  String description;
  int people;
  String ownerId;
  List<String> adminIds;
  List<LedgerItem> items;
  Currency currency;
  List<String> memberIds;
  List<User> members;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Ledger({
    this.id,
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
    this.adminIds = const [],
    this.memberIds = const [],
    this.createdAt,
    this.updatedAt,
    this.items,
    this.deletedAt,
  });

  factory Ledger.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Ledger(
      id: doc.documentID,
      title: data['title'] ?? '',
      color: colorItems[data['color'] ?? 5],
      currency: Currency(
        currency: data['currency'],
        locale: data['currencyLocale'],
        symbol: data['currencySymbol'],
      ),
      description: data['description'] ?? '',
      people: List.from(data['members'] ?? []).length,
      ownerId: data['ownerId'] ?? '',
      adminIds: List.from(data['admins'] ?? []),
      memberIds: List.from(data['members'] ?? []),
    );
  }

  factory Ledger.fromMap(Map data) {
    data = data ?? {};
    return Ledger(
      title: data['title'] ?? '',
      color: colorItems[data['color'] ?? 5],
      currency: Currency(
        currency: data['currencyCode'],
        locale: data['currency'],
      ),
      ownerId: data['ownerId'] ?? '',
      description: data['description'] ?? '',
    );
  }

  @override
  String toString() {
    return 'title: $title, color: ${color.toString()}, ' +
        'description: $description, people: $people, ownerId: $ownerId, ' +
        'adminIds: $adminIds, ' +
        'items: ${items.toString()}, currency: ${currency.toString()}, ' +
        'createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt';
  }
}
