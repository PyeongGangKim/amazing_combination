import 'package:amazing_combination/Brand.dart';
import 'package:amazing_combination/Edit.dart';
import 'package:amazing_combination/Home.dart';
import 'package:amazing_combination/Live.dart';
import 'package:amazing_combination/MyPage.dart';
import 'package:amazing_combination/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/MultiBinding.dart';
import 'constants/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    MultiBinding().dependencies();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //237 121 78
      theme: ThemeData(
        primaryColor: Color(0xFFED794E),
        accentColor: Color(0xFFED794E),
      ),
      title: 'Amazing_Combination',
      home: MainPage(),
      getPages: [
        GetPage(name: '/brand', page: () => BrandPage()),
        GetPage(name: '/live', page: () => LivePage()),
        GetPage(name: '/search', page: () => SearchPage()),
        GetPage(name: '/mypage', page: () => MyPage()),
        GetPage(name: '/edit', page: () => EditPage()),
        //GetPage(name: '/map', page: () => MapPage()),
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> pages = <Widget>[
    // BrandPage(),
    LivePage(),
    HomePage(),
    SearchPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: bottomNavigator(),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget bottomNavigator() {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      unselectedItemColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      items: <BottomNavigationBarItem>[
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.favorite),
        //     label: '브랜드'
        // ),
        BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: '실시간'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onTap,
    );
  }
}
