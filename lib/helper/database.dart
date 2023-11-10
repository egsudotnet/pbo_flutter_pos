import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/master_barang.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'barangs.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Barang (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        harga REAL
      )
    ''');
  }



  Future<int> insertBarang(Barang barang) async {
    Database db = await instance.database;
    return await db.insert('Barang', barang.toMap());
  }

  Future<List<Barang>> queryAllBarangs() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('Barang');
    return List<Barang>.from(result.map((map) => Barang.fromMap(map)));
  }

  Future<int> updateBarang(Barang barang) async {
    Database db = await instance.database;
    return await db.update('Barang', barang.toMap(), where: 'id = ?', whereArgs: [barang.id]);
  }

  Future<int> deleteBarang(int id) async {
    Database db = await instance.database;
    return await db.delete('Barang', where: 'id = ?', whereArgs: [id]);
  }
}