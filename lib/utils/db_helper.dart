import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Category.dart';

final List<Category> initalCategory = [
  Category(
    iconId: 0,
    label: 'CAFE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 1,
    label: 'DRINK',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 2,
    label: 'SNACK',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 3,
    label: 'MEAL',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 4,
    label: 'DATING',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 5,
    label: 'MOVIE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 6,
    label: 'PET',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 7,
    label: 'TRANSPORT',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 8,
    label: 'EXERCISE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 9,
    label: 'WEAR',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 10,
    label: 'SLEEP',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 11,
    label: 'BABY',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 12,
    label: 'GIFT',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 13,
    label: 'ELECTRONIC',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 14,
    label: 'FURNITURE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 15,
    label: 'TRAVEL',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 16,
    label: 'MOBILE_FEE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 17,
    label: 'HOSPITAL',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 18,
    label: 'WALLET_MONEY',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 19,
    label: 'SALARY',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 20,
    label: 'BONUS',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 21,
    label: 'SELL_PRODUCT',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 22,
    label: 'AWARD',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 23,
    label: 'PRESENT',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 24,
    label: 'EXTRA',
    type: CategoryType.INCOME,
  ),
  Category(
    iconId: 25,
    label: 'CAR',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 26,
    label: 'CULTURE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 27,
    label: 'EDUCATION',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 28,
    label: 'ELECTRONIC',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 29,
    label: 'INSURANCE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 30,
    label: 'MAINTENANCE',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 31,
    label: 'MEMBERSHIP',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 32,
    label: 'STUFFS',
    type: CategoryType.CONSUME
  ),
  Category(
    iconId: 33,
    label: 'TAX',
    type: CategoryType.CONSUME
  ),
];

class DbHelper {
  static final DbHelper instance = new DbHelper();
  static const String CATEGORY_DB = 'category.db';
  static Database database;

  void initCategoryDb(BuildContext context) async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'category.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE categories(id INTEGER primary key AUTOINCREMENT, category INTEGER, iconId INTEGER, text TEXT)",
        );
        initalCategory.forEach((category) {
          db.insert('categories', category.toMapInitial(context), conflictAlgorithm: ConflictAlgorithm.abort);
        });
      },
      version: 1,
    );
  }

  Future<int> insertCategory(Category category) async {
    return database.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> getCategories() async {
    final List<Map<String, dynamic>> maps = await database.query('categories');
    return List.generate(maps.length, (i) {
      return Category(
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: maps[i]['type'],
      );
    });
  }

  Future<int> deleteCategory(int id) async {
    return database.delete('categories', where: "id = ?", whereArgs: [id]);
  }
}