import 'package:amazing_combination/Brand.dart';
import 'package:amazing_combination/main.dart';
import 'package:amazing_combination/Map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("홈"),
      ),
      body:
      Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height*0.2,
            alignment: Alignment.center,
            child: Text(
                "광고",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Expanded(
          child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                TagButton('피자', 4, context,'img/pizza.png', Colors.redAccent ),
                TagButton('일식', 1, context,'img/sushi.png', Colors.deepOrangeAccent ),
                TagButton('중식', 2, context, 'img/chinese.png', Color(0xffFBCEB1)),
                TagButton('양식', 7, context, 'img/pasta.png', Colors.orangeAccent),
                TagButton('한식', 0, context, 'img/rice.png', Colors.black26),
                TagButton('햄버거', 5, context, 'img/hamburger.png', Colors.amberAccent),
                TagButton('도시락', 6, context, 'img/dosirak.png', Colors.lime),
                TagButton('치킨', 3, context, 'img/chicken.png', Color(0xffDB9662)),
                TagButton('디저트', 8, context, 'img/cake.png', Colors.pinkAccent),
              ],
            ),
          )
        ],
      )

       // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.map),
      //   onPressed: () {
      //     Get.to(() => MapPage());
      //   },
      // ),
    );
  }
}

Widget TagButton(String tag, int idx, BuildContext context, String foodIcon, Color foodColor) {
  // TODO: onPressed effect
  return Column(
    children: <Widget>[
      IconButton(
        iconSize: 80,
        icon: Image.asset(
          foodIcon,
          color: foodColor,
        ),
        // icon: Image.asset('img/sushi.svg'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BrandPage(initialIndex: idx)));
        },
      ),
      Text(tag),
    ],
  );
}
