import 'package:restonest/data/model/restaurants.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _instance;
  static Database? _database;

  DbHelper._internal() {
    _instance = this;
  }

  factory DbHelper() => _instance ?? DbHelper._internal();

  static const String _favorite = 'favorite';

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restonest.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_favorite(
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating float
        )''');
    }, version: 1);
    return db;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;

    await db!.insert(_favorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favorite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _favorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(_favorite, where: 'id = ?', whereArgs: [id]);
  }
}
