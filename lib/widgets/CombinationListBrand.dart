
import 'package:amazing_combination/CombinationDetail.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:get/get.dart';

class CombinationListBrand extends StatelessWidget {
  const CombinationListBrand({Key key}) : super(key: key);
  static final BrandController bc = Get.find<BrandController>();
  static final CombinationController cbc = Get.find<CombinationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandController>(builder: (value){
      return ListView.separated(
        itemBuilder: (context, int index) => _combination(value, index),
        separatorBuilder: (context, int index) => const Divider(),
        itemCount: (value.brandList[value.selectedBrand].combinations == null) ? 0 : value.brandList[value.selectedBrand].combinations.length
      );
    });
  }
}

Widget _combination(BrandController value, int idx) {
  // TODO: Indicate 1st & 2nd most favorite combination

  Combination combination = value.brandList[value.selectedBrand].combinations[idx];
  String menuList = combination.menuList[0];
  for(int i = 1; i < combination.menuList.length; ++i) {
    menuList += ', ' + combination.menuList[i];
  }

  return ListTile(
    leading: Icon(Icons.fastfood),
    title: Text('${combination.name}'),
    subtitle: Text('$menuList'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Icon(Icons.favorite, color: Colors.red,),
            Text(combination.like.toString()),
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
    onTap: () {
      print(combination.name);
      Get.to(() => CombinationDetailPage(combination: combination));
    },
  );
}