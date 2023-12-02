import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/master_barang.dart';
import '../model/master_supplier.dart';
import '../model/transaksi.dart';
import '../page/transaksi_penjualan/index.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE barang(
            id INTEGER PRIMARY KEY,
            nama TEXT,
            harga REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE supplier(
            id INTEGER PRIMARY KEY,
            nama TEXT,
            alamat TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE transaksi(
            id INTEGER PRIMARY KEY,
            barangId INTEGER,
            jumlah INTEGER,
            harga REAL,
            FOREIGN KEY (barangId) REFERENCES barang (id)
          )
        ''');
      },
    );
  }


  ///Barang
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

  ///Supplier
  Future<int> insertSupplier(Supplier supplier) async {
    Database db = await instance.database;
    return await db.insert('Supplier', supplier.toMap());
  }

  Future<List<Supplier>> queryAllSuppliers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('Supplier');
    return List<Supplier>.from(result.map((map) => Supplier.fromMap(map)));
  }

  Future<int> updateSupplier(Supplier supplier) async {
    Database db = await instance.database;
    return await db.update('Supplier', supplier.toMap(), where: 'id = ?', whereArgs: [supplier.id]);
  }

  Future<int> deleteSupplier(int id) async {
    Database db = await instance.database;
    return await db.delete('Supplier', where: 'id = ?', whereArgs: [id]);
  }

  
  ///Transaksi
  Future<int> insertTransaksi(Transaksi transaksi) async {
    final Database db = await database;
    return await db.insert(
      'transaksi',
      transaksi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}