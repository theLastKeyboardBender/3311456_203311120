import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/my_data_types.dart';
import 'package:sqflite/sqflite.dart';
import '../src/db_util.dart';
import 'dart:async';

class PicturesPage extends StatefulWidget {
  const PicturesPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return PicturesPageState();
  }
}

class PicturesPageState extends State<PicturesPage> {
  DbUtils DbObject = DbUtils();
  List<Product> listOfProducts = [];

  @override
  Widget build(BuildContext context) {
    DbObject.getTheReceiptList().then((value) {
      listOfProducts = value;
    });
    List<Widget> receipts = [];

    receipts.add(
      FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          child: const Text("refresh")),
    );

    if (listOfProducts.isNotEmpty) {
      List<String> paths = [];
      int j = 0;
      paths.add(listOfProducts[0].imagePath);
      for (var i = 1; i < listOfProducts.length; i++) {
        if (paths[j] == listOfProducts[i].imagePath) {
          continue;
        } else {
          paths.add(listOfProducts[i].imagePath);
          j++;
        }
      }

      for (var i = 0; i < paths.length; i++) {
        receipts.add(Image.file(File(paths[i])));
      }
    }
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: GridView.count(crossAxisCount: 3, children: receipts),
    );
  }
}
