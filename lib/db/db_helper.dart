import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'gstore.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE basket(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            imagePath TEXT,
            rating REAL,
            description TEXT,
            price REAL
          )
        ''');
      },
    );
  }

  Future<void> insertMovie(Movie movie) async {
    final db = await database;
    await db.insert(
      'basket',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getBasketMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('basket');
    return List.generate(
      maps.length,
          (i) => Movie.fromMap(maps[i]),
    );
  }

  Future<void> deleteMovie(int id) async {
    final db = await database;
    await db.delete('basket', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearBasket() async {
    final db = await database;
    await db.delete('basket');
  }
}
