import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wecount/models/photo_model.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/converter.dart';
import 'package:wecount/utils/localization.dart';

part 'ledger_item_model.freezed.dart';
part 'ledger_item_model.g.dart';

@freezed
class LedgerItemModel with _$LedgerItemModel {
  const LedgerItemModel._();
  factory LedgerItemModel({
    double? price,
    CategoryModel? category,
    String? memo,
    UserModel? writer,
    @ServerTimestampConverter() DateTime? selectedDate,
    List<PhotoModel>? picture,
    String? latlng,
    String? address,
    @ServerTimestampConverter() DateTime? createdAt,
    @ServerTimestampConverter() DateTime? updatedAt,
    @ServerTimestampConverter() DateTime? deletedAt,
  }) = _LedgerItemModel;

  factory LedgerItemModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerItemModelFromJson(json);

  factory LedgerItemModel.createRoughCopy(LedgerItemModel data) {
    return LedgerItemModel(
      price: data.price,
      category: CategoryModel(
        iconId: data.category!.iconId,
        label: data.category!.label,
        type: data.category!.type,
      ),
      selectedDate: DateTime(data.selectedDate!.year, data.selectedDate!.month,
          data.selectedDate!.day),
    );
  }
}

@freezed
class CategoryModel with _$CategoryModel {
  const CategoryModel._();
  factory CategoryModel({
    int? id,
    int? iconId,
    required String label,
    CategoryType? type,
    @Default(false) bool showDelete,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  // Initial creation
  Map<String, dynamic> toMapInitial(BuildContext context) {
    return {
      'iconId': iconId,
      'label': t(label),
      'type': type!.index,
    };
  }

  // After creation
  Map<String, dynamic> toMap() {
    return {
      'iconId': iconId,
      'label': label,
      'type': type,
    };
  }

  AssetImage? getIconImage() {
    return iconMaps[iconId!];
  }
}

enum CategoryType {
  consume,
  income,
}

final List<AssetImage> categoryIcons = [
  const AssetImage('res/icons/categoryCafe.png'),
  const AssetImage('res/icons/categoryDrink.png'),
  const AssetImage('res/icons/categorySnack.png'),
  const AssetImage('res/icons/categoryMeal.png'),
  const AssetImage('res/icons/categoryDate.png'),
  const AssetImage('res/icons/categoryMovie.png'),
  const AssetImage('res/icons/categoryPet.png'),
  const AssetImage('res/icons/categoryTransport.png'),
  const AssetImage('res/icons/categoryExercise.png'),
  const AssetImage('res/icons/categoryWear.png'),
  const AssetImage('res/icons/categorySleep.png'),
  const AssetImage('res/icons/categoryBaby.png'),
  const AssetImage('res/icons/categoryGift.png'),
  const AssetImage('res/icons/categoryElectronic.png'),
  const AssetImage('res/icons/categoryFurniture.png'),
  const AssetImage('res/icons/categoryTravel.png'),
  const AssetImage('res/icons/categoryMobileFee.png'),
  const AssetImage('res/icons/categoryHospital.png'),
  const AssetImage('res/icons/categoryWallet.png'),
  const AssetImage('res/icons/categorySalary.png'),
  const AssetImage('res/icons/categoryBonus.png'),
  const AssetImage('res/icons/categoryProduct.png'),
  const AssetImage('res/icons/categoryAward.png'),
  const AssetImage('res/icons/categoryPresent.png'),
  const AssetImage('res/icons/categoryExtra.png'),
  const AssetImage('res/icons/categoryCar.png'),
  const AssetImage('res/icons/categoryCulture.png'),
  const AssetImage('res/icons/categoryEducation.png'),
  const AssetImage('res/icons/categoryElectric.png'),
  const AssetImage('res/icons/categoryInsurance.png'),
  const AssetImage('res/icons/categoryMaintenance.png'),
  const AssetImage('res/icons/categoryMembership.png'),
  const AssetImage('res/icons/categoryStuffs.png'),
  const AssetImage('res/icons/categoryTax.png'),
];

final Map<int, dynamic> iconMaps = {
  0: categoryIcons[0],
  1: categoryIcons[1],
  2: categoryIcons[2],
  3: categoryIcons[3],
  4: categoryIcons[4],
  5: categoryIcons[5],
  6: categoryIcons[6],
  7: categoryIcons[7],
  8: categoryIcons[8],
  9: categoryIcons[9],
  10: categoryIcons[10],
  11: categoryIcons[11],
  12: categoryIcons[12],
  13: categoryIcons[13],
  14: categoryIcons[14],
  15: categoryIcons[15],
  16: categoryIcons[16],
  17: categoryIcons[17],
  18: categoryIcons[18],
  19: categoryIcons[19],
  20: categoryIcons[20],
  21: categoryIcons[21],
  22: categoryIcons[22],
  23: categoryIcons[23],
  24: categoryIcons[24],
  25: categoryIcons[25],
  26: categoryIcons[26],
  27: categoryIcons[27],
  28: categoryIcons[28],
  29: categoryIcons[29],
  30: categoryIcons[30],
  31: categoryIcons[31],
  32: categoryIcons[32],
  33: categoryIcons[33],
};
