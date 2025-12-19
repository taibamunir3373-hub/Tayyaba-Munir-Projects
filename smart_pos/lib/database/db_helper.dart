import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    String path = join(await getDatabasesPath(), 'smart_pos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create Products Table
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            sku TEXT,
            price REAL,
            stock INTEGER,
            is_synced INTEGER DEFAULT 0
          )
        ''');
        
        // Create Sales Table
        await db.execute('''
          CREATE TABLE sales (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            total_amount REAL,
            sale_date TEXT,
            is_synced INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }
}