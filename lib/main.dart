import 'package:flutter/material.dart';
import 'imp/page.dart';
import 'giris/giris.dart';
import 'resimler.dart';
import 'istatistikler.dart';
//import 'imp/my_data_type.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

//Anasayfa
class _HomePageState extends State<HomePage> {
  String titleText = "";
  bool girildiMi = false;
  int _currentPage = 0;

  final List<Widget?> _widgetList = const <Widget>[
    ResimlerPage(),
    AppBody(pageIndex: 1),
    StatisticsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavItem =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.photo_library),
      label: "resimler",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.edit),
      label: "bilgi giris",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timeline),
      label: "istatistikler",
    ),
  ];

  //List<Receipt> currentReceips;


  void navigationFunction(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void girisFunction() {
    setState(() {
      girildiMi = true;
    });
  }

  void getTitle(String text) {
    titleText = text;
  }

  @override
  Widget build(BuildContext context) {
    Widget rootWidget;
    if (girildiMi) {
      rootWidget = Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[700],
          title: Text("hosgeldin $titleText"),
        ),
        body: _widgetList[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavItem,
          onTap: navigationFunction,
          currentIndex: _currentPage,
          selectedItemColor: Colors.deepOrange[300],
        ),
      );
    } else {
      rootWidget = PageGiris(girisFunction, getTitle);
    }
    return rootWidget;
  }
}
