import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/db_util.dart';
import '../src/my_data_types.dart';
import "package:image_picker/image_picker.dart";

class InputPage extends StatefulWidget {
  const InputPage({
    super.key,
  });

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String productName = "";
  double amount = 0;
  double price = 0;
  String brand = "";
  String date = "";
  Unit unit = Unit.kg;
  String path = "";

  List<Product> productList = <Product>[];
  Receipt? currentReceipt;

  void imageGetter() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFileImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    path = xFileImage!.path;
  }

  void sendReceipt() async {
    DbUtils Dbobject = DbUtils();
    Dbobject.insertReceipt(currentReceipt!);
  }

  final Widget frameForReceipt = const Center(
    child: Text("lutfen bir resim seciniz"),
  );

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: GestureDetector(
              onTap: () {
                imageGetter();
              },
              child: frameForReceipt),
        ),
        Expanded(
          flex: 2,
          child: Form(
            key: _key,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: "",
                          onSaved: (newValue) {
                            productName = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "you can not leave here empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(labelText: "name"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: "",
                          onSaved: (newValue) {
                            brand = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "you can not leave here empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(labelText: "brand"),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: "",
                          onSaved: (String? newValue) {
                            amount = double.parse(newValue!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "you can not leave here empty";
                            } else if (null == double.tryParse(value)) {
                              return "please enter an floating point number";
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              const InputDecoration(labelText: "amount"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: "",
                          onSaved: (newValue) {
                            price = double.parse(newValue!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "you can not leave here empty";
                            } else if (null == double.tryParse(value)) {
                              return "please enter an floating point number";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(labelText: "price"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: FormField<Unit>(
                        onSaved: (newValue) {},
                        builder: (FormFieldState<Unit> state) {
                          return DropdownButton(
                              value: unit,
                              hint: const Text("unit"),
                              items: const <DropdownMenuItem<Unit>>[
                                DropdownMenuItem<Unit>(
                                  value: Unit.kg,
                                  child: Text("kg"),
                                ),
                                DropdownMenuItem<Unit>(
                                  value: Unit.L,
                                  child: Text("L"),
                                )
                              ],
                              onChanged: (Unit? un) {
                                setState(() {
                                  unit = un!;
                                });
                              });
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate() && path != "") {
                    _key.currentState?.save();
                    _key.currentState?.reset();
                    productList.add(Product(
                        amount: Amount(unit, amount),
                        date: DateTime.now(),
                        imagePath: path,
                        brand: brand,
                        price: price,
                        name: productName));
                  }
                },
                child: const Text("next product")),
            ElevatedButton(
                onPressed: () {
                  if (path == "") {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('pls enter your receipt picture'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (_key.currentState!.validate()) {
                      _key.currentState?.save();
                      _key.currentState?.reset();
                      productList.add(Product(
                          date: DateTime.now(),
                          imagePath: path,
                          amount: Amount(unit, amount),
                          brand: brand,
                          price: price,
                          name: productName));
                      currentReceipt =
                          Receipt(imagePath: path, productList: productList);
                      path = "";
                      sendReceipt();
                      print(currentReceipt.toString());
                    } else if (productList.isEmpty) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Warning'),
                          content: const Text('please enter some products'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      _key.currentState?.reset();
                      currentReceipt =
                          Receipt(imagePath: path, productList: productList);
                      path = "";
                      sendReceipt();
                    }
                  }
                },
                child: const Text("submit"))
          ]),
        )
      ],
    );
  }
}
