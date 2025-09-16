import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbAbstract {
  ///
  /// TODO: Constructor
  ///
  DbAbstract();

  Database? _db;

  ///
  /// TODO:
  ///
  late String _dbName;
  String get dbName => _dbName;
  void setDbName({required String value}) {
    _dbName = value;
  }

  ///
  /// TODO:
  ///
  late int _dbVersion;
  int get dbVersion => _dbVersion;
  void setDbVersion({required int value}) {
    _dbVersion = value;
  }

  ///
  /// TODO:
  ///
  late String _tableName;
  String get tableName => _tableName;
  void setTableName({required String value}) {
    _tableName = value;
  }

  ///
  /// TODO:
  ///
  Future<void> onCreate(Database db, int version);

  ///
  /// TODO:
  ///
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _onInitDB();
    return _db!;
  }

  ///
  /// TODO:
  ///
  Future<Database> _onInitDB() async {
    setDbName(value: 'product_demo.db');
    setDbVersion(value: 1);

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }
}
