import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wecount/models/currency.dart';
import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/utils/converter.dart';
import 'package:wecount/types/color.dart';
import 'package:wecount/utils/logger.dart';

part 'ledger.freezed.dart';
part 'ledger.g.dart';

@freezed
class Ledger with _$Ledger {
  const Ledger._();
  factory Ledger(
      {String? id,
      required String title,
      required ColorType color,
      String? description,
      int? people,
      String? ownerId,
      @Default([]) List<String> adminIds,
      List<LedgerItem>? items,
      required Currency currency,
      @Default([]) List<String> memberIds,
      List<String>? members,
      @ServerTimestampConverter() createdAt,
      @ServerTimestampConverter() updatedAt,
      @ServerTimestampConverter() deletedAt}) = _Ledger;

  factory Ledger.fromJson(Map<String, dynamic> json) => _$LedgerFromJson(json);

  factory Ledger.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;

    return Ledger(
      id: doc.id,
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

  factory Ledger.fromMap(Map? data) {
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
}

final List<ColorType> colorItems = [
  ColorType.red,
  ColorType.orange,
  ColorType.yellow,
  ColorType.green,
  ColorType.blue,
  ColorType.dusk,
  ColorType.purple,
];
