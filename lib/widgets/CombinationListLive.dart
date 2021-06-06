import 'package:amazing_combination/CombinationDetail.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:amazing_combination/controllers/LiveController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class CombinationListLive extends StatelessWidget {
  final bool byLikes;
  const CombinationListLive({Key key, @required this.byLikes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<LiveController>(
      init: Get.put<LiveController>(LiveController()),
      builder: (liveController) {
        List<Combination> combinations = byLikes
            ? liveController.combinationsByLikes
            : liveController.combinationsByComments;
        return ListView.separated(
          itemBuilder: (context, int index) =>
              _combination(liveController, index, combinations[index]),
          separatorBuilder: (context, int index) => const Divider(),
          itemCount: combinations == null ? 0 : combinations.length,
        );
      },
    );
  }
}

Widget _combination(
    LiveController liveController, int idx, Combination combination) {
  String menuList = combination.menuList[0];
  for (int i = 1; i < combination.menuList.length; ++i) {
    menuList += ', ' + combination.menuList[i];
  }

  if (idx < 2) {
    return Stack(
      children: [
        CombinationTile(menuList: menuList, combination: combination),
        Transform.rotate(
          angle: 30 * math.pi / 180,
          child: Icon(
            Feather.award,
            size: 60,
            color: idx == 0 ? Color(0xffffd700) : Color(0xffc0c0c0),
          ),
        )
      ],
    );
  } else
    return CombinationTile(menuList: menuList, combination: combination);
}

class CombinationTile extends StatelessWidget {
  const CombinationTile(
      {Key key, @required this.menuList, @required this.combination})
      : super(key: key);

  final String menuList;
  final Combination combination;

  @override
  Widget build(BuildContext context) {
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
}
