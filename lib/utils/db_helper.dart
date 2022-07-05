import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:wecount/models/category_model.dart';

final List<Category> initialCategory = [
  Category(iconId: 0, label: 'CAFE', type: CategoryType.consume),
  Category(iconId: 1, label: 'DRINK', type: CategoryType.consume),
  Category(iconId: 2, label: 'SNACK', type: CategoryType.consume),
  Category(iconId: 3, label: 'MEAL', type: CategoryType.consume),
  Category(iconId: 4, label: 'DATING', type: CategoryType.consume),
  Category(iconId: 5, label: 'MOVIE', type: CategoryType.consume),
  Category(iconId: 6, label: 'PET', type: CategoryType.consume),
  Category(iconId: 7, label: 'TRANSPORT', type: CategoryType.consume),
  Category(iconId: 8, label: 'EXERCISE', type: CategoryType.consume),
  Category(iconId: 9, label: 'WEAR', type: CategoryType.consume),
  Category(iconId: 10, label: 'SLEEP', type: CategoryType.consume),
  Category(iconId: 11, label: 'BABY', type: CategoryType.consume),
  Category(iconId: 12, label: 'GIFT', type: CategoryType.consume),
  Category(iconId: 13, label: 'ELECTRONIC', type: CategoryType.consume),
  Category(iconId: 14, label: 'FURNITURE', type: CategoryType.consume),
  Category(iconId: 15, label: 'TRAVEL', type: CategoryType.consume),
  Category(iconId: 16, label: 'MOBILE_FEE', type: CategoryType.consume),
  Category(iconId: 17, label: 'HOSPITAL', type: CategoryType.consume),
  Category(
    iconId: 18,
    label: 'WALLET_MONEY',
    type: CategoryType.income,
  ),
  Category(
    iconId: 19,
    label: 'SALARY',
    type: CategoryType.income,
  ),
  Category(
    iconId: 20,
    label: 'BONUS',
    type: CategoryType.income,
  ),
  Category(
    iconId: 21,
    label: 'SELL_PRODUCT',
    type: CategoryType.income,
  ),
  Category(
    iconId: 22,
    label: 'AWARD',
    type: CategoryType.income,
  ),
  Category(
    iconId: 23,
    label: 'PRESENT',
    type: CategoryType.income,
  ),
  Category(
    iconId: 24,
    label: 'EXTRA',
    type: CategoryType.income,
  ),
  Category(iconId: 25, label: 'CAR', type: CategoryType.consume),
  Category(iconId: 26, label: 'CULTURE', type: CategoryType.consume),
  Category(iconId: 27, label: 'EDUCATION', type: CategoryType.consume),
  Category(iconId: 28, label: 'ELECTRONIC', type: CategoryType.consume),
  Category(iconId: 29, label: 'INSURANCE', type: CategoryType.consume),
  Category(iconId: 30, label: 'MAINTENANCE', type: CategoryType.consume),
  Category(iconId: 31, label: 'MEMBERSHIP', type: CategoryType.consume),
  Category(iconId: 32, label: 'STUFFS', type: CategoryType.consume),
  Category(iconId: 33, label: 'TAX', type: CategoryType.consume),
];

class DBHelper {
  static final DBHelper instance = DBHelper();
  static const String categoryDB = 'category.db';
  static Database? _database;

  Future<Database> initDB(BuildContext context) async {
    final String path = join(await getDatabasesPath(), 'category.db');
    _database = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE categories(id INTEGER primary key AUTOINCREMENT, type INTEGER, iconId INTEGER, label TEXT)",
        );
        for (var category in initialCategory) {
          // ignore: use_build_context_synchronously
          db.insert('categories', category.toMapInitial(context),
              conflictAlgorithm: ConflictAlgorithm.abort);
        }
      },
      version: 5,
    );

    return _database!;
  }

  Future<int> insertCategory(BuildContext context, Category category) async {
    final Database db = await initDB(context);

    return db.insert(
      'categories',
      {
        'iconId': category.iconId,
        'label': category.label,
        'type': category.type!.index,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> getCategories(BuildContext context) async {
    final Database db = await initDB(context);
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: CategoryType.values[maps[i]['type']],
      );
    });
  }

  Future<List<Category>> getIncomeCategories(BuildContext context) async {
    final Database db = await initDB(context);
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: CategoryType.values[maps[i]['type']],
      );
    });
  }

  Future<List<Category>> getConsumeCategories(BuildContext context) async {
    final Database db = await initDB(context);

    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: CategoryType.values[maps[i]['type']],
      );
    });
  }

  Future<int> deleteCategory(BuildContext context, int? iconId) async {
    final Database db = await initDB(context);

    return db.delete('categories', where: "iconId = ?", whereArgs: [iconId]);
  }

  bool isExistFiled(DocumentSnapshot doc, String filedName) {
    Object? data = doc.data();

    if (data != null) {
      return (data as Map)[filedName] != null;
    }

    return false;
  }
}
