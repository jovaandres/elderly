import 'package:sqflite/sqflite.dart';
import 'package:workout_flutter/data/model/alarm.dart';

class AlarmDatabase {
  static AlarmDatabase? _databaseHelper;
  static Database? _database;
  static String tblAlarm = "tbl_alarm";

  AlarmDatabase._createObject();

  factory AlarmDatabase() {
    if (_databaseHelper == null) {
      _databaseHelper = AlarmDatabase._createObject();
    }

    return _databaseHelper as AlarmDatabase;
  }

  Future<Database> _initializeDb() async {
    var path = getDatabasesPath();
    var db = openDatabase(
      '$path/alarm.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tblAlarm (
          id INTEGER PRIMARY KEY,
          name TEXT,
          time TEXT,
          isScheduled INTEGER
        )''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertAlarm(AlarmData alarmData) async {
    final db = await database;
    await db?.insert(tblAlarm, alarmData.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<AlarmData>?> getAllAlarmData() async {
    final db = await database;

    List<Map<String, dynamic>>? results = await db?.query(tblAlarm);

    return results?.map((res) => AlarmData.fromJson(res)).toList();
  }

  Future<AlarmData?> getAlarmDataByName(String name) async {
    final db = await database;

    List<Map<String, dynamic>>? results =
        await db?.query(tblAlarm, where: 'name = ?', whereArgs: [name]);

    return results?.map((res) => AlarmData.fromJson(res)).first;
  }

  Future<bool> isAlarmExists(String name) async {
    final db = await database;
    final alarm =
        await db?.query(tblAlarm, where: 'name = ?', whereArgs: [name]);
    return alarm?.isNotEmpty == true;
  }

  Future<void> updateAlarm(int value, int id) async {
    final db = await database;
    await db?.rawUpdate('''
    UPDATE $tblAlarm 
    SET isScheduled = ? 
    WHERE id = ?
    ''', [value, id]);
  }
}
