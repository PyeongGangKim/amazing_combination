
import 'package:amazing_combination/controllers/TagController.dart';
import 'package:amazing_combination/Brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Brand.dart';
import '../models/Menu.dart';
import '../models/Comment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Combination.dart';
import 'dart:async';
import 'CombinationController.dart';
import 'UserController.dart';
import 'package:amazing_combination/services/database.dart';

class BrandController extends GetxController {

  RxList<Brand> brandList = RxList<Brand>();
  List<Widget> brandTabs = [BrandList(), BrandList(), BrandList()];
  int _selectedBrand;
  int get selectedBrand => _selectedBrand;

    @override
  void onInit() {
      brandList.bindStream(Database().brandStream());
  }

  void addCombinationInBrand(Combination combination, String brandId){
    FirebaseFirestore.instance
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
    }).then((newCombination) {
      combination.id = newCombination.id;
      //uc.addCombinationInUser(combination);
      Get.find<CombinationController>().addCombination(combination);
      for(int i = 0 ; i < combination.tags.length ; i++) {
        Get.find<TagController>().addCombinationInTag(combination, combination.tags[i]);
      }
    });
  }
  void addCommentInBrandInCombination(Comment comment, String brandId, String combinationId){
    FirebaseFirestore.instance
        .collection('Brands')
        .doc(brandId)
        .collection('Combinations')
        .doc(combinationId)
        .collection('Comments')
        .add({
      'maker': comment.maker,
      'content': comment.content,
      'created_date_time' : FieldValue.serverTimestamp()
    });
  }
  void selectBrand(int idx){
    _selectedBrand = idx;
    print(_selectedBrand);
    update();
  }


}