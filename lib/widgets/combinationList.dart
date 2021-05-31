
import 'package:amazing_combination/widgets/combinationAdd.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/services/database.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/models/Brand.dart';

class CombinationList extends StatelessWidget {
  final Brand brand;
  CombinationList(this.brand);
  static final BrandController bc = Get.find<BrandController>();
  static final CombinationController cbc = Get.find<CombinationController>();

  @override
  Widget build(BuildContext context) {
    return GetX<CombinationController>(
        init: Get.put<CombinationController>(CombinationController(brand)),
        builder: (CombinationController combinationController){
          return (combinationController == null || combinationController.combinationList.isEmpty) ? Align(child: CircularProgressIndicator(),)
          : ListView.separated(
              itemBuilder: (context, int index) => _combination(combinationController.combinationList, index),
              separatorBuilder: (context, int index) => const Divider(),
              itemCount: combinationController.combinationList.length,
          );
        }
    );
  }
}

Widget _combination(List<Combination> combination, int idx) {
  // TODO: Indicate 1st & 2nd most favorite combination
  /*String menuList = combination.menuList[0];
  for(int i = 1; i < combination.menuList.length; ++i) {
    menuList += ', ' + combination.menuList[i];
  }*/
  return ListTile(
    leading: Icon(Icons.fastfood),
    title: Text(combination[idx].name),
    subtitle: Text('menu 1 + menu 2'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Icon(Icons.favorite, color: Colors.red,),
            Text('11'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Text('22'),
          ],
        )
      ],
    ),
  );
}
