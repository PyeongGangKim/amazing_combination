
import 'package:amazing_combination/Brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Brand.dart';
import '../models/Comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Combination.dart';
import 'CombinationsByBrandController.dart';
import 'UserController.dart';
import 'package:amazing_combination/services/database.dart';

class BrandController extends GetxController {
  RxList<Brand> brandList = RxList<Brand>();

  RxList<Brand> koreanList = RxList<Brand>();
  RxList<Brand> japaneseList = RxList<Brand>();
  RxList<Brand> chineseList = RxList<Brand>();
  RxList<Brand> chickenList = RxList<Brand>();
  RxList<Brand> pizzaList = RxList<Brand>();
  RxList<Brand> hamburgerList = RxList<Brand>();
  RxList<Brand> dosirakList = RxList<Brand>();
  RxList<Brand> westernList = RxList<Brand>();
  RxList<Brand> hungryList = RxList<Brand>();

  List<Widget> brandTabs = [
    BrandList(0),
    BrandList(1),
    BrandList(2),
    BrandList(3),
    BrandList(4),
    BrandList(5),
    BrandList(6),
    BrandList(7),
    BrandList(8),
  ];

  int _selectedBrand;
  int get selectedBrand => _selectedBrand;

  @override
  void onInit() {
    brandList.bindStream(Database().brandStream());
    koreanList.bindStream(Database().brandTagStream('한식'));
    japaneseList.bindStream(Database().brandTagStream('일식'));
    chineseList.bindStream(Database().brandTagStream('중식'));
    chickenList.bindStream(Database().brandTagStream('치킨'));
    pizzaList.bindStream(Database().brandTagStream('피자'));
    hamburgerList.bindStream(Database().brandTagStream('햄버거'));
    dosirakList.bindStream(Database().brandTagStream('도시락'));
    westernList.bindStream(Database().brandTagStream('양식'));
    hungryList.bindStream(Database().brandTagStream('야식'));
  }

  void addCombinationInBrand(Combination combination, String brandId) async {
    await FirebaseFirestore.instance
        .collection('Brands')
        .doc(brandId)
        .collection('Combinations')
        .add({
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
      'numOfComments': 0,
    }).then((newCombination) async {
      combination.id = newCombination.id;
      Get.find<UserController>().addCombinationInUser(combination);
      Get.find<CombinationsByBrandController>().addCombination(combination);
    });
  }

  void addCommentInBrandInCombination(
      Comment comment, String brandId, String combinationId) {
    FirebaseFirestore.instance
        .collection('Brands')
        .doc(brandId)
        .collection('Combinations')
        .doc(combinationId)
        .collection('Comments')
        .add({
      'maker': comment.maker,
      'content': comment.content,
      'created_date_time': FieldValue.serverTimestamp()
    });
  }

  void updateLike(Combination combination) {
    FirebaseFirestore.instance
        .collection('Brands')
        .doc(combination.brand)
        .collection('Combinations')
        .doc(combination.id)
        .update({
      'like': combination.like,
      'likePerson': combination.likePerson,
    });
  }

  void updateComment(Combination combination) {
    FirebaseFirestore.instance
        .collection('Brands')
        .doc(combination.brand)
        .collection('Combinations')
        .doc(combination.id)
        .update({'numOfComments': combination.numOfComments});
  }

  void selectBrand(int idx) {
    _selectedBrand = idx;
    print(_selectedBrand);
    update();
  }
}
