import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Sales Table for Offline Mode
    await db.execute('''
      CREATE TABLE sales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total REAL,
        items TEXT,
        timestamp TEXT,
        isSynced INTEGER DEFAULT 0
      )
    ''');
  }

  // Offline Sale Save karne ka function
  Future<int> insertSale(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('sales', row);
  }

  // Wo sales nikalna jo abhi tak Firebase par nahi gayin (Sync Logic)
  Future<List<Map<String, dynamic>>> getUnsyncedSales() async {
    final db = await instance.database;
    return await db.query('sales', where: 'isSynced = 0');
  }
}