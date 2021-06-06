import 'package:amazing_combination/Brand.dart';
import 'package:amazing_combination/main.dart';
import 'package:amazing_combination/Map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
          TagButton('한식', 0, context),
          TagButton('일식', 1, context),
          TagButton('중식', 2, context),
          TagButton('치킨', 3, context),
          TagButton('피자', 4, context),
          TagButton('햄버거', 5, context),
          TagButton('도시락', 6, context),
          TagButton('양식', 7, context),
          TagButton('야식', 8, context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          Get.to(() => MapPage());
        },
      ),
    );
  }
}

Widget TagButton(String tag, int idx, BuildContext context) {
  // TODO: onPressed effect
  return Column(
    children: <Widget>[
      IconButton(
        iconSize: 80,
        icon: Icon(Icons.fastfood),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BrandPage(initialIndex: idx)));
        },
      ),
      Text(tag),
    ],
  );
}
