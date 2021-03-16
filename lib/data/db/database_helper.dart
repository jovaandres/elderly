import 'package:sqflite/sqflite.dart';
import 'package:workout_flutter/data/model/user_data.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  static String tblUserData = "tbl_user_data";

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  Future<Database> _initializeDb() async {
    var path = getDatabasesPath();
    var db = openDatabase(
      '$path/elderly.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tblUserData (
          email TEXT PRIMARY KEY,
          name TEXT,
          role TEXT,
          age TEXT,
          weight TEXT,
          height TEXT
        )''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertUserData(UserData userData) async {
    final db = await database;
    await db.insert(tblUserData, userData.toJson());
  }

  Future<UserData> getUserData(String email) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db.query(tblUserData, where: 'email = ?', whereArgs: [email]);

    return results.map((res) => UserData.fromJson(res)).first;
  }

  Future<void> removeData(String email) async {
    final db = await database;
    await db.delete(
      tblUserData,
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
