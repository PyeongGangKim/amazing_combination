
import 'package:amazing_combination/Live.dart';
import 'package:amazing_combination/widgets/combinationList.dart';
import 'package:flutter/material.dart';

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
          TagButton('치킨'),
          TagButton('햄버거'),
          TagButton('피자'),
          TagButton('중식'),
        ],
      ),
    );
  }
}

Widget TagButton(String tag) {
  // TODO: onPressed effect
  return Column(
    children: <Widget>[
      IconButton(
        iconSize: 80,
        icon: Icon(Icons.fastfood),
        onPressed: () {
          // navigate
          // TODO: navigate - push? replace?
          print(tag);
        },
      ),
      Text(tag),
    ],
  );
}

