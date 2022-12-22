import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wecount/models/ledger_item_model.dart';

final List<CategoryModel> initialCategory = [
  CategoryModel(iconId: 0, label: 'cafe', type: CategoryType.consume),
  CategoryModel(iconId: 1, label: 'drink', type: CategoryType.consume),
  CategoryModel(iconId: 2, label: 'snack', type: CategoryType.consume),
  CategoryModel(iconId: 3, label: 'meal', type: CategoryType.consume),
  CategoryModel(iconId: 4, label: 'dating', type: CategoryType.consume),
  CategoryModel(iconId: 5, label: 'movie', type: CategoryType.consume),
  CategoryModel(iconId: 6, label: 'pet', type: CategoryType.consume),
  CategoryModel(iconId: 7, label: 'transport', type: CategoryType.consume),
  CategoryModel(iconId: 8, label: 'exercise', type: CategoryType.consume),
  CategoryModel(iconId: 9, label: 'wear', type: CategoryType.consume),
  CategoryModel(iconId: 10, label: 'sleep', type: CategoryType.consume),
  CategoryModel(iconId: 11, label: 'baby', type: CategoryType.consume),
  CategoryModel(iconId: 12, label: 'gift', type: CategoryType.consume),
  CategoryModel(iconId: 13, label: 'electronic', type: CategoryType.consume),
  CategoryModel(iconId: 14, label: 'furniture', type: CategoryType.consume),
  CategoryModel(iconId: 15, label: 'travel', type: CategoryType.consume),
  CategoryModel(iconId: 16, label: 'mobileFee', type: CategoryType.consume),
  CategoryModel(iconId: 17, label: 'hospital', type: CategoryType.consume),
  CategoryModel(
    iconId: 18,
    label: 'walletMoney',
    type: CategoryType.income,
  ),
  CategoryModel(
    iconId: 19,
    label: 'salary',
    type: CategoryType.income,
  ),
  CategoryModel(
    iconId: 20,
    label: 'bonus',
    type: CategoryType.income,
  ),
  CategoryModel(
    iconId: 21,
    label: 'salesOfGood',
    type: CategoryType.income,
  ),
  CategoryModel(
    iconId: 22,
    label: 'award',
    type: CategoryType.income,
  ),
  CategoryModel(
    iconId: 23,
    label: 'present',
    type: CategoryType.income,
  ),
  CategoryModel(
    iconId: 24,
    label: 'extra',
    type: CategoryType.income,
  ),
  CategoryModel(iconId: 25, label: 'car', type: CategoryType.consume),
  CategoryModel(iconId: 26, label: 'culture', type: CategoryType.consume),
  CategoryModel(iconId: 27, label: 'education', type: CategoryType.consume),
  CategoryModel(iconId: 28, label: 'electronic', type: CategoryType.consume),
  CategoryModel(iconId: 29, label: 'insurance', type: CategoryType.consume),
  CategoryModel(iconId: 30, label: 'maintenance', type: CategoryType.consume),
  CategoryModel(iconId: 31, label: 'membership', type: CategoryType.consume),
  CategoryModel(iconId: 32, label: 'stuffs', type: CategoryType.consume),
  CategoryModel(iconId: 33, label: 'tax', type: CategoryType.consume),
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
          'CREATE TABLE categories(id INTEGER primary key AUTOINCREMENT, type INTEGER, iconId INTEGER, label TEXT)',
        );
        if (context.mounted) {
          for (final category in initialCategory) {
            db.insert('categories', category.toMapInitial(context),
                conflictAlgorithm: ConflictAlgorithm.abort);
          }
        }
      },
      version: 5,
    );

    return _database!;
  }

  Future<int> insertCategory(
      BuildContext context, CategoryModel category) async {
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

  Future<List<CategoryModel>> getCategories(BuildContext context) async {
    final Database db = await initDB(context);
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) {
      return CategoryModel(
        id: maps[i]['id'],
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: CategoryType.values[maps[i]['type']],
      );
    });
  }

  Future<List<CategoryModel>> getIncomeCategories(BuildContext context) async {
    final Database db = await initDB(context);
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return CategoryModel(
        id: maps[i]['id'],
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: CategoryType.values[maps[i]['type']],
      );
    });
  }

  Future<List<CategoryModel>> getConsumeCategories(BuildContext context) async {
    final Database db = await initDB(context);

    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return CategoryModel(
        id: maps[i]['id'],
        iconId: maps[i]['iconId'],
        label: maps[i]['label'],
        type: CategoryType.values[maps[i]['type']],
      );
    });
  }

  Future<int> deleteCategory(BuildContext context, int? iconId) async {
    final Database db = await initDB(context);

    return db.delete('categories', where: 'iconId = ?', whereArgs: [iconId]);
  }

  bool isExistFiled(doc, String filedName) {
    if (doc.data() != null) {
      Map data = doc.data();
      return data[filedName] != null;
    }
    return false;
  }
}
