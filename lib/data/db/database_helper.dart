import 'package:sqflite/sqflite.dart';
import 'package:workout_flutter/data/model/family_number.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  static String tblFamilyNumber = "tbl_family_number";

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
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tblFamilyNumber (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          number TEXT
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

  Future<void> insertContact(FamilyNumber familyNumber) async {
    final db = await database;
    await db.insert(tblFamilyNumber, familyNumber.toJson());
  }

  Future<List<FamilyNumber>> getContact() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(tblFamilyNumber);

    return results
        .map((res) => FamilyNumber.fromJson(res))
        .toList()
        .reversed
        .toList();
  }

  Future<Map> getContactByName(String name) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tblFamilyNumber,
      where: 'name = ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> removeContact(int id) async {
    final db = await database;
    await db.delete(
      tblFamilyNumber,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
