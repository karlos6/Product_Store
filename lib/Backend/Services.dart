import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'Models/Product.dart';

class Services with ChangeNotifier {
  Database _db;
  static const String DBname = 'product_store';
  static const String Table = 'product';
  static const String ID = 'id';
  static const String Name = 'name';
  static const String Net_Cost = 'netCost';
  static const String Gross_Cost = 'grossCost';

  static const String Table2 = 'investment';
  static const String Quantity = 'quantity';

  static const String Table3 = 'sale';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  } // retorna la DataBase o llama la una funcion para crearla.

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBname);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    db.execute("PRAGMA foreign_keys=ON;");
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $Table ($ID INTEGER PRIMARY KEY, $Name TEXT, $Net_Cost INTEGER, $Gross_Cost INTEGER);");

    await db.execute(
        "CREATE TABLE $Table2 ($ID INTEGER, $Gross_Cost INTEGER, $Quantity INTEGER, FOREIGN KEY($ID) REFERENCES $Table($ID) ON DELETE CASCADE);");

    await db.execute(
        "CREATE TABLE $Table3 ($ID INTEGER, $Net_Cost INTEGER, $Quantity INTEGER, FOREIGN KEY($ID) REFERENCES $Table($ID));");
  }

  Future<Product> save(Product product, int quantity) async {
    var dbClient = await db;
    print(product.id);
    product.id = await dbClient.insert(Table, product.toMap());
    print(product.id);

    Map<String, dynamic> investment = {
      '$ID': product.id,
      '$Gross_Cost': product.valorBruto,
      '$Quantity': quantity
    };

    await dbClient.insert(Table2, investment);

    notifyListeners();

    return product;
  }

  Future<List<Product>> getProducts() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(Table, columns: [ID, Name, Net_Cost, Gross_Cost]);
    List<Product> products = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        int quantity = 0;
        await quantityProduct(maps[i]['id']).then((value) => quantity = value);
        products.add(Product.fromMap(maps[i], quantity));
      }
    }
    //notifyListeners();
    return products;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    notifyListeners();
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

  Future<int> quantityProduct(int id) async {
    int sum = 0;
    var dbClient = await db;
    var quantityInves = await dbClient.rawQuery(
        "select sum ($Quantity) as cantidad from $Table2 where $ID = $id;",
        null);

    var quantitySale = await dbClient.rawQuery(
        "select sum ($Quantity) as cantidad from $Table3 where $ID = $id;",
        null);

    if (quantityInves.toList()[0]['cantidad'] != null &&
        quantitySale.toList()[0]['cantidad'] != null) {
      sum = int.parse(quantityInves.toList()[0]['cantidad'].toString()) -
          int.parse(quantitySale.toList()[0]['cantidad'].toString());
      print('esta entrando');
    } else if (quantityInves.toList()[0]['cantidad'] != null &&
        quantitySale.toList()[0]['cantidad'] == null) {
      sum = int.parse(quantityInves.toList()[0]['cantidad'].toString());
    }
    return sum;
  }

  eliminar() async {
    await _db.execute("DROP TABLE $Table");
  }
}
