
import 'package:amazing_combination/CombinationDetail.dart';
import 'package:amazing_combination/controllers/SearchController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CombinationList extends StatelessWidget {
  const CombinationList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SearchController>(
      init: Get.put<SearchController>(SearchController()),
      builder: (searchController) {
        return ListView.separated(
          itemBuilder: (context, int index) => _combination(searchController, index),
          separatorBuilder: (context, int index) => const Divider(),
          itemCount: searchController.combinations == null ? 0 : searchController.combinations.length,
        );
      },
    );
  }
}

Widget _combination(SearchController searchController, int idx) {
  Combination combination = searchController.combinations[idx];

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
