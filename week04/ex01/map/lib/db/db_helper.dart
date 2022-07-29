import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:map/db/locate_model.dart';

const String tableName = 'location';

class DBHelper {
  var _db;

  // create
  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'locate2.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE LOCATION(id INTEGER PRIMARY KEY, year INTEGER, month INTEGER, day INTEGER, hour INTEGER, minute INTEGER, latitude REAL, longitude REAL)',
        );
      },
      version: 1,
    );
    return _db;
  }

  // insert
  Future<void> insertLocate(Location location) async {
    final db = await database;

    await db.insert(
      tableName,
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // delete
  Future<void> deleteLocate(int id) async {
    final db = await database;

    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //update
  Future<void> updateLocate(Location location) async {
    final db = await database;

    await db.update(
      tableName,
      location.toMap(),
      where: 'time = ?',
      whereArgs: [
        location.year,
        location.month,
        location.day,
        location.hour,
        location.minute
      ],
    );
  }

  Future<List<Location>> getAllLocation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('location');
    return List.generate(maps.length, (i) {
      return Location(
        id: maps[i]['id'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
        hour: maps[i]['hour'],
        minute: maps[i]['minute'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
      );
    });
  }
}
