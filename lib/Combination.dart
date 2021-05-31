import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/widgets/CombinationListBrand.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/widgets/combinationAdd.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({Key key}) : super(key: key);

  static final brand = Get.arguments['brand'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('조합'),
      ),
      body: Column(
        children: [
          Image.asset('img/yee.PNG'),
          Expanded(
            child: CombinationListBrand(brand),
          )
        ],
      ),
      floatingActionButton: CombinationAdd(brand),

    );
  }
}