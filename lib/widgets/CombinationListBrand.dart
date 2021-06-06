import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/widgets/combinationAdd.dart';

import 'package:amazing_combination/CombinationDetail.dart';
import 'package:amazing_combination/models/Combination.dart';

import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationsByBrandController.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/models/Brand.dart';

class CombinationListBrand extends StatelessWidget {
  final Brand brand;
  CombinationListBrand(this.brand);

  @override
  Widget build(BuildContext context) {
    return GetX<CombinationsByBrandController>(
        init: Get.put<CombinationsByBrandController>(
            CombinationsByBrandController(brand)),
        builder: (CombinationsByBrandController combinationController) {
          return combinationController == null
              ? Align(
                  child: CircularProgressIndicator(),
                )
              : combinationController.combinationList.isEmpty
                  ? Text('첫번째 조합을 등록하세요!!')
                  : ListView.separated(
                      itemBuilder: (context, int index) =>
                          _combination(combinationController, index),
                      separatorBuilder: (context, int index) => const Divider(),
                      itemCount: combinationController.combinationList.length,
                    );
        });
  }
}

Widget _combination(
    CombinationsByBrandController combinationController, int idx) {
  // TODO: Indicate 1st & 2nd most favorite combination
  Combination combination = combinationController.combinationList[idx];
  String menuList = "";
  if (combination.menuList.isNotEmpty) {
    menuList = combination.menuList[0];
    for (int i = 1; i < combination.menuList.length; ++i) {
      menuList += ', ' + combination.menuList[i];
    }
  }
  return ListTile(
    leading: combination.imageUrls.length == 0
        ? Icon(Icons.fastfood)
        : Container(
            width: 80,
            height: 50,
            child: Image.network(
              combination.imageUrls[0],
              fit: BoxFit.fill,
            ),
          ),
    title: Text(combination.name),
    subtitle: Text('$menuList'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text(combination.like.toString()),
          ],
        ),
        Column(
          children: [
            Icon(Icons.comment, color: Colors.yellow),
            Text(combination.numOfComments.toString()),
          ],
        )
      ],
    ),
    onTap: () {
      print(combination.name);
      Get.to(() => CombinationDetailPage(
            combinationId: combination.id,
          ));
    },
  );
}
