import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper extends ChangeNotifier {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'health.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    notifyListeners();
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade===========");
  }

  _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE health (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      systolic INTEGER NOT NULL,
      diastolic TEXT NOT NULL,
      pulse TEXT NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL
      
      )
      ''');
    notifyListeners();
    print("Create health DATABASE");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    notifyListeners();
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    notifyListeners();
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    notifyListeners();
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    notifyListeners();
    return response;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'health.db');
    await deleteDatabase(path);
    notifyListeners();
  }
}

// static Future<void> createTables(sql.Database database) async {
//   await database.execute("""CREATE TABLE items(
//       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//       systolic TEXT,
//       diastolic TEXT,
//       pulse TEXT,
//     );
//     """);
// }
//
// static Future<sql.Database> db() async {
//   return sql.openDatabase(
//     'health.db',
//     version: 1,
//     onCreate: (sql.Database database, int version) async {
//       print("...creating a table...");
//       await createTables(database);
//     },
//   );
// }
//
// static Future<int> createItem(String systolic, String? diastolic,String? pulse) async {
//   final db = await SQLHelper.db();
//
//   final data = {'systolic': systolic, 'diastolic': diastolic,'pulse':pulse};
//   final id = await db.insert('items', data,
//       conflictAlgorithm: sql.ConflictAlgorithm.replace);
//   return id;
// }
//
// static Future<List<Map<String, dynamic>>> getItems() async {
//   final db = await SQLHelper.db();
//   return db.query('items', orderBy: "id");
// }
//
// static Future<List<Map<String, dynamic>>> getItem(int id) async {
//   final db = await SQLHelper.db();
//   return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
// }
//
// static Future<void> deleteItem(int id) async {
//   final db = await SQLHelper.db();
//   try {
//     await db.delete("items", where: "id = ?", whereArgs: [id]);
//   } catch (err) {
//     debugPrint("Something went wrong when deleting an item: $err");
//   }
// }
