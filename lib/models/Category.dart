import 'package:flutter/material.dart';
import '../utils/localization.dart';

enum CategoryType {
  CONSUME,
  INCOME,
}

final Map<int, dynamic> iconMaps = {
  0: AssetImage('res/icons/categoryCafe.png'),
  1: AssetImage('res/icons/categoryDrink.png'),
  2: AssetImage('res/icons/categorySnack.png'),
  3: AssetImage('res/icons/categoryMeal.png'),
  4: AssetImage('res/icons/categoryDate.png'),
  5: AssetImage('res/icons/categoryMovie.png'),
  6: AssetImage('res/icons/categoryPet.png'),
  7: AssetImage('res/icons/categoryTransport.png'),
  8: AssetImage('res/icons/categoryExercise.png'),
  9: AssetImage('res/icons/categoryWear.png'),
  10: AssetImage('res/icons/categorySleep.png'),
  11: AssetImage('res/icons/categoryBaby.png'),
  12: AssetImage('res/icons/categoryGift.png'),
  13: AssetImage('res/icons/categoryElectronic.png'),
  14: AssetImage('res/icons/categoryFurniture.png'),
  15: AssetImage('res/icons/categoryTravel.png'),
  16: AssetImage('res/icons/categoryMobileFee.png'),
  17: AssetImage('res/icons/categoryHospital.png'),
  18: AssetImage('res/icons/categoryWallet.png'),
  19: AssetImage('res/icons/categorySalary.png'),
  20: AssetImage('res/icons/categoryBonus.png'),
  21: AssetImage('res/icons/categoryProduct.png'),
  22: AssetImage('res/icons/categoryAward.png'),
  23: AssetImage('res/icons/categoryPresent.png'),
  24: AssetImage('res/icons/categoryExra.png'),
  25: AssetImage('res/icons/categoryCar.png'),
  26: AssetImage('res/icons/categoryCulture.png'),
  27: AssetImage('res/icons/categoryEducation.png'),
  28: AssetImage('res/icons/categoryElectric.png'),
  29: AssetImage('res/icons/categoryInsurance.png'),
  30: AssetImage('res/icons/categoryMaintenance.png'),
  31: AssetImage('res/icons/categoryMembership.png'),
  32: AssetImage('res/icons/categoryStuffs.png'),
  33: AssetImage('res/icons/categoryTax.png'),
};

class Category {
  int iconId;
  String label;
  CategoryType type;

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
      'type': type,
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
}
