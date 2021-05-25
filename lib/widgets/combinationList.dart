
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:get/get.dart';

class CombinationList extends StatelessWidget {
  const CombinationList({Key key}) : super(key: key);
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
  var combinationName = value.brandList[value.selectedBrand].combinations[idx].name;
  return ListTile(
    leading: Icon(Icons.fastfood),
    title: Text('$combinationName'),
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