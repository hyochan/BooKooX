import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wecount/models/currency_model.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/types/color.dart';

import './ledger_item.dart' show LedgerItemModel;

final List<ColorType> colorItems = [
  ColorType.red,
  ColorType.orange,
  ColorType.yellow,
  ColorType.green,
  ColorType.blue,
  ColorType.dusk,
  ColorType.purple,
];

class LedgerModel {
  String? id;
  String title;
  ColorType color;
  String? description;
  int? people;
  String? ownerId;
  List<String> adminIds;
  List<LedgerItemModel>? items;
  CurrencyModel currency;
  List<String> memberIds;
  List<UserModel>? members;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  LedgerModel({
    this.id,
    required this.title,
    required this.color,
    required this.currency,
    this.description,

    /// Contain only the [int] number of members
    ///
    /// Since we don't need to render all member's data in first-hand
    /// We've separated people to only fetch the length of the members
    this.people,

    /// Contain the full [UserModel] data of members including photoURL
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

  factory LedgerModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;

    return LedgerModel(
      id: doc.id,
      title: data['title'] ?? '',
      color: colorItems[data['color'] ?? 5],
      currency: CurrencyModel(
        currency: data['currency'],
        locale: data['currencyLocale'],
        symbol: data['currencySymbol'],
      ),
      description: data['description'] ?? '',
      people: List.from(data['memberIds'] ?? []).length,
      ownerId: data['ownerId'] ?? '',
      adminIds: List.from(data['admins'] ?? []),
      memberIds: List.from(data['members'] ?? []),
    );
  }

  factory LedgerModel.fromJson(Map? data) {
    data = data ?? {};

    return LedgerModel(
      title: data['title'] ?? '',
      color: colorItems[data['color'] ?? 5],
      currency: CurrencyModel(
        currency: data['currencyCode'],
        locale: data['currency'],
      ),
      ownerId: data['ownerId'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'description': description,
      'people': people,
      'ownerId': ownerId,
      'adminIds': adminIds,
      'items': items,
      'currency': currency,
      'memberIds': memberIds,
      'members': members,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  @override
  String toString() {
    return 'title: $title, color: ${color.toString()}, description: $description, people: $people, ownerId: $ownerId, adminIds: $adminIds, items: ${items.toString()}, currency: ${currency.toString()}, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt';
  }
}
