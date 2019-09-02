import 'package:flutter/cupertino.dart';
import '../utils/localization.dart';

enum CategoryType {
  CONSUME,
  INCOME,
}

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
}
