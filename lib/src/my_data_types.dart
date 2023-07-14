
import "dart:core";

enum Unit { kg, L }

class Amount {
  Unit unit;
  double howMany;

  Amount(this.unit, this.howMany);

  Amount.fromJson(Map<String, dynamic> pMap)
      : unit = pMap["unit"] == "kg" ? Unit.kg : Unit.L,
        howMany = pMap["Amount"];

  Map<String, dynamic> toJson() {
    String stringUnit = "";
    if (unit == Unit.kg) {
      stringUnit = "kg";
    }
    return {"Unit": stringUnit, "HowMany": howMany};
  }

  String unitToString() {
    return unit == Unit.kg ? "kg" : "L";
  }

  @override
  String toString() {
    return "amount:$howMany $unit";
  }
}

class Product {
  String imagePath;
  DateTime date;
  Amount amount;
  String brand;
  double price;
  String name;

  Product(
      {required this.amount,
      required this.brand,
      required this.price,
      required this.date,
      required this.imagePath,
      required this.name});

  /*Product.fromJson(Map<String, dynamic> pMap)
      : amount = Amount.fromJson(pMap["Amount"]),
        brand = pMap["Brand"],
        name = pMap["Name"],
        price = pMap["Price"];*/

  Map<String, dynamic> toJson() {
    return {
      "Amount": amount.toJson(),
      "Brand": brand,
      "Name": name,
      "Price": price
    };
  }

  @override
  String toString() {
    return "$name brand:$brand ${amount.toString()} price:$price";
  }
}

class Receipt {
  List<Product> productList = <Product>[];
  String imagePath;
  DateTime date;

  Receipt({required this.imagePath, required this.productList})
      : date = DateTime.now();

  /*Receipt.fromJson(Map<String, dynamic> pMap)
      : imagePath = pMap["Path of image"],
        date = DateTime.parse(pMap["Date"]) {
    List<Product> listOfProducts = <Product>[];
    for (int i = 0; i < pMap["List of products"].length; i++) {
      listOfProducts.add(Product.fromJson(pMap["List of products"][i]));
    }
  }*/

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> listOfMap = <Map<String, dynamic>>[];
    for (int i = 0; i < productList.length; i++) {
      listOfMap.add(productList[i].toJson());
    }
    return {
      "List of products": listOfMap,
      "Path of image": imagePath,
      "Date": date.toString()
    };
  }

  @override
  String toString() {
    String receipt = "";
    for (int i = 0; i < productList.length; i++) {
      // ignore: prefer_interpolation_to_compose_strings
      receipt = receipt + productList[i].toString() + "\n";
    }

    return receipt;
  }
}
