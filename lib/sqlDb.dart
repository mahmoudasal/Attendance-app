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
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print(
        "onupgrade===============================================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "studentList" (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "sPhone" INTEGER NOT NULL,
      "gPhone" INTEGER NOT NULL
    )
    ''');
    print("create DATABASE AND TABLE ============================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql, String name, int sPhone, int gPhone) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql, [name, sPhone, gPhone]);
    print("insert =============================================");
    return response;
  }

  updatetData(String sql, String name, int sPhone, int gPhone) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql, [name, sPhone, gPhone]);
    return response;
  }

  deleteData(String sql, String name, int sPhone, int gPhone) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql, [name, sPhone, gPhone]);
    return response;
  }
}
