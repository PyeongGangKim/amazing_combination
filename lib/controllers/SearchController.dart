import 'package:amazing_combination/models/Combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList<Combination> combinations = RxList<Combination>();

  Future<void> searchByTag(String tag) {

    combinations.bindStream(FirebaseFirestore.instance
        .collection('Combinations')
        .where('tags', arrayContains: tag)
        .snapshots()
        .map((combinations) {
      List<Combination> ret = [];
      combinations.docs.forEach((combination) {
        ret.add(Combination.fromFirebase(combination));
      });
      return ret;
    }));
  }
}
