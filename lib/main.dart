import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/MultiBinding.dart';
import 'models/Combination.dart';
import 'models/Brand.dart';
import 'constants/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value){
    MultiBinding().dependencies();

  });
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
  BrandController bc = Get.find<BrandController>();

  @override
  Widget build(BuildContext context) {
    bc.loadBrand();
    return Scaffold(
      appBar: AppBar(
        title: Text("Amazing Combination"),
      ),
      body: GetBuilder<BrandController>(
        builder: (value) {
          if (value.brandList == null || value.brandList.isEmpty) {
            return Container(
                child: Text("null")
            );
          }
          return Container(
            child: Text(
              value.brandList[0].menuList[0].name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              maxLines: 1,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bc.addCombinationInBrand(
            Combination(
              name: "육고",
              brand: "육대장",
              menuList: ["육계장"],
              tags : ["한식"],
              imageUrls: ["asd","we"],
              description: "asdasdasd",
              like : 0,
              likePerson: [],
              uid: "st",
              maker: "masd",
            ),
            bc.brandList[0].name,
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
