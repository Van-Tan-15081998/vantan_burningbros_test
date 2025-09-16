import 'package:product_demo/services/database/abstracts/db_abstract.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProductDB extends DbAbstract {

  ///
  /// TODO: Constructor
  ///
  FavoriteProductDB() : super() {
    setTableName(value: 'favorites');
  }

  ///
  /// TODO:
  ///
  Future<List<int>> onGetAllFavorites() async {
    final db = await database;
    final result = await db.query(tableName);
    return result.map((row) => row['id'] as int).toList();
  }

  ///
  /// TODO:
  ///
  Future<void> onAddFavorite(int id) async {
    final db = await database;
    await db.insert('favorites', {'id': id}, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  ///
  /// TODO:
  ///
  Future<void> onRemoveFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  ///
  /// TODO:
  ///
  Future<void> onClearFavorites() async {
    final db = await database;
    await db.delete('favorites');
  }

  ///
  /// TODO:
  ///
  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY
      )
    ''');
  }
}
