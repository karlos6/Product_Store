import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'Models/Product.dart';

class Services {
  Database _db;
  static const String DBname = 'product_store';
  static const String Table = 'product';
  static const String ID = 'id';
  static const String Name = 'name';
  static const String Net_Cost = 'netCost';
  static const String Gross_Cost = 'grossCost';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  } // retorna la DataBase o llama la una funcion para crearla.

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBname);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $Table ($ID INTEGER PRIMARY KEY, $Name TEXT, $Net_Cost INTEGER, $Gross_Cost INTEGER)");
  }

  Future<Product> save(Product product) async {
    var dbClient = await db;
    product.id = await dbClient.insert(Table, product.toMap());
    return product;
  }

  Future<List<Product>> getProducts() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(Table, columns: [ID, Name, Net_Cost, Gross_Cost]);
    List<Product> products = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        products.add(Product.fromMap(maps[i]));
      }
    }
    return products;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(Table, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Product product) async {
    var dbClient = await db;
    return await dbClient.update(Table, product.toMap(),
        where: '$ID = ?', whereArgs: [product.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
