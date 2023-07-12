import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[100],
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Container(
                  color: Colors.brown,
                  child: const Text("sayfa"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  color: Colors.amber,
                  child: const Text("naber"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
