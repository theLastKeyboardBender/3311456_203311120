import 'package:flutter/material.dart';

enum Unit { kg, L }

class Amount {
  Unit unit;
  double howMany;

  Amount(this.unit, this.howMany);
}

class Product {
  Amount amount;
  String brand;
  double price;

  Product(this.amount, this.brand, this.price);
}

class Receipt {
  List<Product>? productList;
  Image receiptImage;

  Receipt({required this.receiptImage, this.productList});
}
