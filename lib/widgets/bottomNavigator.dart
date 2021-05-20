
import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({Key key}) : super(key: key);
//237 121 78
  final Color color = const Color(0xFFED794E);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
