import 'package:flutter_application_1/src/my_data_types.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  static final DbUtils _dbUtils = DbUtils._internal();

  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), 'receipts.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE Receipts( imagePath TEXT, date TEXT, name TEXT,brand TEXT,price REAL,amount REAL,unit TEXT)");
  }

  Future<void> insertReceipt(Receipt rec) async {
    final Database? db = await this.db;
    Map<String, dynamic> mapToSend;
    for (int i = 0; i < rec.productList.length; i++) {
      mapToSend = {
        "imagePath": rec.imagePath,
        "date": rec.date.toString(),
        "name": rec.productList[i].name,
        "brand": rec.productList[i].brand,
        "price": rec.productList[i].price,
        "amount": rec.productList[i].amount.howMany,
        "unit": rec.productList[i].amount.unitToString()
      };
      await db?.insert("Receipts", mapToSend);
    }
  }

  Future<List<Product>> getTheReceiptList() async {
    final Database? db = await this.db;
    List<Product> listOfProduct = [];
    List<Map> list = await db!.query("Receipts");
    for (int i = 0; i < list.length; i++) {
      String name = list[i]["name"];
      Unit unit = list[i]["unit"] == "kg" ? Unit.kg : Unit.L;
      String imagePath = list[i]["imagePath"];
      DateTime date = DateTime.parse(list[i]["date"]);
      Amount amount = Amount(unit, list[i]["amount"]);
      double price = list[i]["price"];
      String brand = list[i]["brand"];

      listOfProduct.add(Product(
          amount: amount,
          brand: brand,
          price: price,
          date: date,
          imagePath: imagePath,
          name: name));
    }

    return listOfProduct;
  }

  Future<void> deleteDog(int id) async {
    final db = await this.db;
    await db?.delete(
      'dogs',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
