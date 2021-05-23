import 'package:amazing_combination/Brand.dart';
import 'package:amazing_combination/Combination.dart';
import 'package:amazing_combination/Home.dart';
import 'package:amazing_combination/Live.dart';
import 'package:amazing_combination/MyPage.dart';
import 'package:amazing_combination/Search.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/widgets/bottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/MultiBinding.dart';
import 'controllers/CounterController.dart';
import './models/Combination.dart';

void main() {
  MultiBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        //GetPage(name: '/next', page: () => NextPage()),
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
    // CombinationPage(),
    BrandPage(),
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
    final Color color = const Color(0xFFED794E);
    // final Color color = Colors.black;

    return BottomNavigationBar(
      showUnselectedLabels: true,
      unselectedItemColor: color,
      selectedItemColor: color,
      unselectedLabelStyle: TextStyle(color: color),
      selectedLabelStyle: TextStyle(color: color),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '브랜드'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: '실시간'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지'
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onTap,
    );
  }
}












class HomePagea extends StatelessWidget {
  CombinationController cbc = Get.find<CombinationController>();


  @override
  Widget build(BuildContext context) {
    cbc.init();
    List<Combination> combinations = cbc.combinationList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Amazing Combination"),
      ),
      body: GetBuilder<CombinationController>(
        builder: (value) {
          if (value.combinationList == null || value.combinationList.isEmpty) {
            return Container(
                child: Text("null")
            );
          }
          return Container(
            child: Text(
              value.combinationList[value.combinationList.length-1].id,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              maxLines: 1,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cbc.addCombination(
            Combination(
              name: "치킨피자피",
              brand: "치킨나라피자공주",
              menuList: ["피자", "치킨"],
              tag : ["피자", "치킨"],
              imageUrls: ["asd","we"],
              description: "asdasdasd",
              like : 0,
              likePerson: [],
              uid: "st",
              maker: "masd",
            )
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
