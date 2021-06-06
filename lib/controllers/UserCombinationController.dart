
import 'package:amazing_combination/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/Combination.dart';


class UserCombinationController extends GetxController {
  RxList<Combination> combinations = RxList<Combination>();
  String userId;
  UserCombinationController(this.userId);
  @override
  void onInit() {
    combinations.bindStream(Database().userCombinationStream(userId));
  }

  void updateLike(Combination combination) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Combinations')
        .doc(combination.id)
        .update({
      'like': combination.like,
      'likePerson': combination.likePerson,
    });
  }

  void updateComment(Combination combination) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Combinations')
        .doc(combination.id)
        .update({
      'numOfComments': combination.numOfComments
    });
  }
}
