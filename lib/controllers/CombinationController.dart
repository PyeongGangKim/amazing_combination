import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amazing_combination/services/database.dart';
import '../models/Combination.dart';
import 'package:amazing_combination/models/Brand.dart';

class CombinationController extends GetxController {

  Brand brand;
  RxList<Combination> combinationList = RxList<Combination>();

  CombinationController(this.brand);
  @override
  void onInit () {
    combinationList.bindStream(Database().combinationStream(brand.name));
  }
    void addCombination(Combination combination){
    print("--------add----------");
      FirebaseFirestore.instance
          .collection('Combinations')
          .doc(combination.id)
          .set({
        'name': combination.name,
        'brand': combination.brand,
        'menuList': combination.menuList,
        'tags': combination.tags,
        'imageUrls': combination.imageUrls,
        'description': combination.description,
        'createdDateTime': FieldValue.serverTimestamp(),
        'like': combination.like,
        'likePerson': combination.likePerson,
        'uid': combination.uid,
        'maker': combination.maker,
      });
    }


}
