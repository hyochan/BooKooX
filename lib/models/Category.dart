import 'package:flutter/material.dart';
import '../utils/localization.dart';

enum CategoryType {
  CONSUME,
  INCOME,
}

final List<AssetImage> categoryIcons = [
  AssetImage('res/icons/categoryCafe.png'),
  AssetImage('res/icons/categoryDrink.png'),
  AssetImage('res/icons/categorySnack.png'),
  AssetImage('res/icons/categoryMeal.png'),
  AssetImage('res/icons/categoryDate.png'),
  AssetImage('res/icons/categoryMovie.png'),
  AssetImage('res/icons/categoryPet.png'),
  AssetImage('res/icons/categoryTransport.png'),
  AssetImage('res/icons/categoryExercise.png'),
  AssetImage('res/icons/categoryWear.png'),
  AssetImage('res/icons/categorySleep.png'),
  AssetImage('res/icons/categoryBaby.png'),
  AssetImage('res/icons/categoryGift.png'),
  AssetImage('res/icons/categoryElectronic.png'),
  AssetImage('res/icons/categoryFurniture.png'),
  AssetImage('res/icons/categoryTravel.png'),
  AssetImage('res/icons/categoryMobileFee.png'),
  AssetImage('res/icons/categoryHospital.png'),
  AssetImage('res/icons/categoryWallet.png'),
  AssetImage('res/icons/categorySalary.png'),
  AssetImage('res/icons/categoryBonus.png'),
  AssetImage('res/icons/categoryProduct.png'),
  AssetImage('res/icons/categoryAward.png'),
  AssetImage('res/icons/categoryPresent.png'),
  AssetImage('res/icons/categoryExtra.png'),
  AssetImage('res/icons/categoryCar.png'),
  AssetImage('res/icons/categoryCulture.png'),
  AssetImage('res/icons/categoryEducation.png'),
  AssetImage('res/icons/categoryElectric.png'),
  AssetImage('res/icons/categoryInsurance.png'),
  AssetImage('res/icons/categoryMaintenance.png'),
  AssetImage('res/icons/categoryMembership.png'),
  AssetImage('res/icons/categoryStuffs.png'),
  AssetImage('res/icons/categoryTax.png'),
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

class Category {
  int iconId;
  String label;
  CategoryType type;
  bool showDelete = false;

  Category({
    this.iconId,
    this.label,
    this.type,
  });

  // Initial creation
  Map<String, dynamic> toMapInitial(BuildContext context) {
    return {
      'iconId': iconId,
      'label': Localization.of(context).trans(label),
      'type': type.index,
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

  AssetImage getIconImage(int iconId) {
    return iconMaps[iconId];
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
