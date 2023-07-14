import 'package:flutter/material.dart';
import 'pages/input_page.dart';
import 'pages/login_page.dart';
import 'pages/pictures_page.dart';
import 'pages/statistics_page.dart';
import 'src/my_data_types.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Top(),
        title: "My Super App",
        theme: ThemeData(primaryColor: Colors.cyan[100]));
  }
}

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TopState();
  }
}

//Anasayfa
class _TopState extends State<Top> {
  String titleText = "";
  bool girildiMi = false;
  int _currentPage = 0;


  final List<Widget?> _pages =  <Widget>[
    const PicturesPage(),
    const InputPage(),
    const StatisticsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavItem =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.photo_library),
      label: "receipts",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.edit),
      label: "entry",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timeline),
      label: "statistics",
    ),
  ];

  List<Receipt>? currentReceips;

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
        body: _pages[_currentPage],
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
