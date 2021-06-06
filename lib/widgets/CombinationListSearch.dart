import 'package:amazing_combination/CombinationDetail.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/SearchController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CombinationListSearch extends StatelessWidget {
  const CombinationListSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SearchController>(
      init: Get.put<SearchController>(SearchController()),
      builder: (searchController) {
        return ListView.separated(
          itemBuilder: (context, int index) =>
              _combination(searchController, index),
          separatorBuilder: (context, int index) => const Divider(),
          itemCount: searchController.combinations == null
              ? 0
              : searchController.combinations.length,
        );
      },
    );
  }
}

Widget _combination(SearchController searchController, int idx) {
  Combination combination = searchController.combinations[idx];

  String menuList = combination.menuList[0];
  for (int i = 1; i < combination.menuList.length; ++i) {
    menuList += ', ' + combination.menuList[i];
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
    title: Text('${combination.name}'),
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
