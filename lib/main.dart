import 'package:amazing_combination/controllers/CombinationController.dart';
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
      title: 'Amazing_Combination',
      home: HomePage(),
      getPages: [
        //GetPage(name: '/next', page: () => NextPage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
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
