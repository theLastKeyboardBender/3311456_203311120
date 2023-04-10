import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return StatisticsPageState();
  }
}

class StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    List<ListRow> myList = [];
    for (int i = 0; i < 40; i++) {
      myList.add(const ListRow());
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: myList,
    );
  }
}

class ListRow extends StatelessWidget {
  const ListRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MyPopupRoute<void>());
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(),
        ),
        height: 100,
        padding: const EdgeInsets.all(2),
        child: Row(
          children: const [Text("data")],
        ),
      ),
    );
  }
}

class MyPopupRoute<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black26;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "dialog";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      child: Container(
        color: Colors.cyan,
        height: 100,
        width: 100,
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);
}
