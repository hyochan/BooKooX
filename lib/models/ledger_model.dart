import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wecount/models/currency_model.dart';
import 'package:wecount/models/ledger_item_model.dart';
import 'package:wecount/utils/converter.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/logger.dart';

part 'ledger_model.freezed.dart';
part 'ledger_model.g.dart';

@freezed
class LedgerModel with _$LedgerModel {
  const LedgerModel._();
  factory LedgerModel(
      {String? id,
      required String title,
      required ColorType color,
      String? description,
      int? people,
      String? ownerId,
      @Default([]) List<String> adminIds,
      List<LedgerItemModel>? items,
      required CurrencyModel currency,
      @Default([]) List<String> memberIds,
      List<String>? members,
      @ServerTimestampConverter() createdAt,
      @ServerTimestampConverter() updatedAt,
      @ServerTimestampConverter() deletedAt}) = _LedgerModel;

  factory LedgerModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerModelFromJson(json);

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
      people: List.from(data['members'] ?? []).length,
      ownerId: data['ownerId'] ?? '',
      adminIds: List.from(data['admins'] ?? []),
      memberIds: List.from(data['members'] ?? []),
    );
  }

  factory LedgerModel.fromMap(Map? data) {
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
