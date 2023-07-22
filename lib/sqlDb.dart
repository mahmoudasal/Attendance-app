import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    databaseFactory = databaseFactoryFfi;

    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'student.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print(
        "onupgrade===============================================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE 'satwtue1' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue2' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue3' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue4' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue5' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue6' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue7' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue8' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue9' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue10' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue11' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue12' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue13' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue14' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE 'satwtue15' (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" TEXT NOT NULL,
      "gPhone" TEXT NOT NULL
    )
    ''');
    print("create DATABASE AND TABLE ============================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    print("readdata =============================================");
    return response;
  }

  Future<int> insertData(
      String sql, String name, String sPhone, String gPhone) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql, [name, sPhone, gPhone]);
    return response;
  }

  Future<int> updatetData(String sql, int id, String name, String sPhone,
      String gPhone, void pop) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql, [name, sPhone, gPhone, id]);
    return response;
  }

  Future<int> deleteData(String tableName, int id) async {
    Database? mydb = await db;
    int response =
        await mydb!.rawDelete("DELETE FROM '$tableName' WHERE id = ?", [id]);
    return response;
  }
}
