import 'package:product_demo/services/database/abstracts/db_abstract.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProductDB extends DbAbstract {
  FavoriteProductDB() : super() {
    setTableName(value: 'favorites');
  }

  Future<List<int>> getAllFavorites() async {
    final db = await database;
    final result = await db.query(tableName);
    return result.map((row) => row['id'] as int).toList();
  }

  Future<void> addFavorite(int id) async {
    final db = await database;
    await db.insert('favorites', {'id': id}, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> removeFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearFavorites() async {
    final db = await database;
    await db.delete('favorites');
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY
      )
    ''');
  }
}
