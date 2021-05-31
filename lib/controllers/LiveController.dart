import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/widgets/CombinationListBrand.dart';
import 'package:amazing_combination/widgets/CombinationListLive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveController extends GetxController {
  RxList<Combination> combinationsByLikes = RxList();
  // RxList<Combination> combinationsByComments = RxList();

  List<Widget> liveTabs = [CombinationListLive(), CombinationListLive()];

  @override
  void onInit() {
    combinationsByLikes.bindStream(FirebaseFirestore.instance
        .collection('Combinations')
        .orderBy('like', descending: true)
        .snapshots()
        .map((combinations) {
      List<Combination> ret = [];
      combinations.docs.forEach((combination) {
        ret.add(Combination.fromFirebase(combination));
      });
      return ret;
    }));

    // TODO: rating
    // Sorted by number of comments?
  }
}
