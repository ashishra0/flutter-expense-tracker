import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:alfredexpensetracker/databasehelper.dart';

class Item {
  final int id;
  final String name;
  final int cost;
  static const String TABLENAME = "items";

  Item({this.id, this.name, this.cost});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = this.id;
    map['name'] = this.name;
    map['cost'] = this.cost;

    return map;
  }

  // ignore: missing_return
  static Future<String> insertItem(Item item) async {
    final Database db = await DatabaseHelper.instance.database;

    await db.insert(
      TABLENAME,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.rawQuery('SELECT * FROM items ORDER BY id DESC');
  }
}
