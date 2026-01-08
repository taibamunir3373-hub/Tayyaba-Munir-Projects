import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // 'join' aur 'getDatabasesPath' ab kaam karenge agar path package install ho gaya
    String path = join(await getDatabasesPath(), 'smart_pos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY AUTO_INCREMENT, name TEXT, price REAL, stock INTEGER)',
        );
      },
    );
  }
}