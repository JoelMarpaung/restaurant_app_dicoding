import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/favourite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'favourites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favourites_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavourite(Favourite fav) async {
    final Database db = await database;
    await db.insert(_tableName, fav.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getFavouriteById(String id) async {
    try {
      final Database db = await database;
      List<Map<String, dynamic>> results = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return results.first;
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteFavourite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
