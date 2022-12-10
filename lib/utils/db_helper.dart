import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wecount/models/ledger_item.dart';

final List<Category> initialCategory = [
  Category(iconId: 0, label: 'cafe', type: CategoryType.consume),
  Category(iconId: 1, label: 'drink', type: CategoryType.consume),
  Category(iconId: 2, label: 'snack', type: CategoryType.consume),
  Category(iconId: 3, label: 'meal', type: CategoryType.consume),
  Category(iconId: 4, label: 'dating', type: CategoryType.consume),
  Category(iconId: 5, label: 'movie', type: CategoryType.consume),
  Category(iconId: 6, label: 'pet', type: CategoryType.consume),
  Category(iconId: 7, label: 'transport', type: CategoryType.consume),
  Category(iconId: 8, label: 'exercise', type: CategoryType.consume),
  Category(iconId: 9, label: 'wear', type: CategoryType.consume),
  Category(iconId: 10, label: 'sleep', type: CategoryType.consume),
  Category(iconId: 11, label: 'baby', type: CategoryType.consume),
  Category(iconId: 12, label: 'gift', type: CategoryType.consume),
  Category(iconId: 13, label: 'electronic', type: CategoryType.consume),
  Category(iconId: 14, label: 'furniture', type: CategoryType.consume),
  Category(iconId: 15, label: 'travel', type: CategoryType.consume),
  Category(iconId: 16, label: 'mobileFee', type: CategoryType.consume),
  Category(iconId: 17, label: 'hospital', type: CategoryType.consume),
  Category(
    iconId: 18,
    label: 'walletMoney',
    type: CategoryType.income,
  ),
  Category(
    iconId: 19,
    label: 'salary',
    type: CategoryType.income,
  ),
  Category(
    iconId: 20,
    label: 'bonus',
    type: CategoryType.income,
  ),
  Category(
    iconId: 21,
    label: 'salesOfGood',
    type: CategoryType.income,
  ),
  Category(
    iconId: 22,
    label: 'award',
    type: CategoryType.income,
  ),
  Category(
    iconId: 23,
    label: 'present',
    type: CategoryType.income,
  ),
  Category(
    iconId: 24,
    label: 'extra',
    type: CategoryType.income,
  ),
  Category(iconId: 25, label: 'car', type: CategoryType.consume),
  Category(iconId: 26, label: 'culture', type: CategoryType.consume),
  Category(iconId: 27, label: 'education', type: CategoryType.consume),
  Category(iconId: 28, label: 'electronic', type: CategoryType.consume),
  Category(iconId: 29, label: 'insurance', type: CategoryType.consume),
  Category(iconId: 30, label: 'maintenance', type: CategoryType.consume),
  Category(iconId: 31, label: 'membership', type: CategoryType.consume),
  Category(iconId: 32, label: 'stuffs', type: CategoryType.consume),
  Category(iconId: 33, label: 'tax', type: CategoryType.consume),
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
