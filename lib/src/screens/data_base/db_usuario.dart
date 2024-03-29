// ignore: file_names, depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "user_database.db";
  static const _databaseVersion = 1;

  static const tableUsers = "users";
  static const columnId = "id";
  static const columnNombre = "nombre";
  static const columnUsuario = "usuario";
  static const columnImagen = "imagen";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNombre TEXT NOT NULL,
        $columnUsuario TEXT NOT NULL,
        $columnImagen BLOB NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    await _database?.close();
  }
}