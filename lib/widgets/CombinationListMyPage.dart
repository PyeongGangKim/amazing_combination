import 'package:amazing_combination/CombinationDetail.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';

import 'package:amazing_combination/controllers/UserCombinationController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CombinationListMyPage extends StatelessWidget {
  final String userId;
  const CombinationListMyPage({Key key, @required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("userId" + userId);
    return GetX<UserCombinationController>(
        init: Get.put(UserCombinationController(userId)),
        builder: (UserCombinationController userCombinationController) {
          return (userCombinationController.combinations == null)
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) => _combination(
                      userCombinationController.combinations, index),
                  separatorBuilder: (context, int index) => const Divider(),
                  itemCount: userCombinationController.combinations.length,
                );
        });
  }
}

Widget _combination(List<Combination> combinations, int idx) {
  Combination combination = combinations[idx];

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
