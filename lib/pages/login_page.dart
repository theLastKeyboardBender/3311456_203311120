import 'package:flutter/material.dart';

class PageGiris extends StatefulWidget {
  const PageGiris(this._onPressed,this._onChanged, {super.key});

  final void Function() _onPressed;
  final void Function(String) _onChanged; 

  @override
  State<PageGiris> createState() => _PageGirisState();
}

class _PageGirisState extends State<PageGiris> {
  String? inputText;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GIRIS"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                onChanged: widget._onChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  constraints: BoxConstraints(maxWidth: 300),
                  hintText: "name surname",
                  labelText: "identity",
                  icon: Icon(Icons.perm_identity,color: Colors.black)
                )),
            const SizedBox(height: 5),
            ElevatedButton(
                onPressed: widget._onPressed, child: const Text("gonder"))
          ],
        ),
      ),
    );
  }
}
