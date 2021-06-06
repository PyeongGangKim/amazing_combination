
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/UserCombinationController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CombinationController extends GetxController {
  String combinationId;
  Rx<Combination> combination = Combination().obs;
  CombinationController(this.combinationId);

  @override
  void onInit() {
    combination.bindStream(Database().combinationStream(combinationId));
  }

  void updateLike(Combination combination) {
    FirebaseFirestore.instance
        .collection('Combinations')
        .doc(combination.id)
        .update({
      'like': combination.like,
      'likePerson': combination.likePerson,
    });
    Get.find<BrandController>().updateLike(combination);
    Get.find<UserCombinationController>().updateLike(combination);
  }

  void updateComment(Combination combination) {
    FirebaseFirestore.instance
        .collection('Combinations')
        .doc(combination.id)
        .update({'numOfComments': combination.numOfComments});
    Get.find<BrandController>().updateComment(combination);
    Get.find<UserCombinationController>().updateComment(combination);
  }
}