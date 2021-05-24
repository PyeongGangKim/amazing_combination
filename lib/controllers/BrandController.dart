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

class BrandController extends GetxController {
  UserController uc = Get.find<UserController>();
  CombinationController cbc = Get.find<CombinationController>();
  void loadBrand() {
    print("--------brand load----------");
    FirebaseFirestore.instance
        .collection('Brands')
        .snapshots()
        .listen((snapshots){
      brandList = [];
      snapshots.docs.forEach((brand) async {
        List<Menu> menuList = [];
        await FirebaseFirestore.instance
            .collection('Brands')
            .doc(brand.id)
            .collection('Menus')
            .snapshots()
            .listen((menus){
          menus.docs.forEach((menu){
            menuList.add(
                Menu(
                    id :menu.id,
                    name: menu.data()['name'],
                    price: menu.data()['price'],
                    imageUrl: menu.data()['imageUrl'],
                    tags: menu.data()['tags'].cast<String>(),
                )
            );
          });
        });
        List<Combination> combinationList = [];
        await FirebaseFirestore.instance
            .collection('Brands')
            .doc(brand.id)
            .collection('Combinations')
            .snapshots()
            .listen((combinations) {
          combinations.docs.forEach((combination) async {
            List<Comment> commentList = [];
            await FirebaseFirestore.instance
                .collection('Brands/$brand.id/Combinations/$combination.id/Comments')
                .snapshots()
                .listen((comments) {
              comments.docs.forEach((comment) {
                commentList.add(
                    Comment(
                        id: comment.id,
                        maker: comment.data()['maker'],
                        content: comment.data()['content']
                    )
                );
              });
            });
            combinationList.add(
                Combination(
                    id: combination.id,
                    name: combination.data()['name'],
                    brand: combination.data()['brand'],
                    menuList: combination.data()['menuList'].cast<String>(),
                    tags: combination.data()['tags'].cast<String>(),
                    imageUrls: combination.data()['imageUrls'].cast<String>(),
                    description: combination.data()['description'],
                    createdDateTime: combination.data()['createdDateTime']
                        .toDate()
                        .toString(),
                    like: combination.data()['like'],
                    likePerson: combination.data()['likePerson'].cast<String>(),
                    uid: combination.data()['uid'],
                    maker: combination.data()['maker'],
                    comments: commentList
                )
            );
          });
        });
        brandList.add(
            Brand(
                name: brand.data()['name'],
                menuList: menuList,
                tags: brand.data()['tags'].cast<String>(),
                imageUrl: brand.data()['imageUrl'],
                combinations: combinationList,
            )
        );
      });
      print("--------brand-----------");
      for(int i = 0 ; i < brandList.length ; i++){
        print(brandList[i].name);
        print(brandList[i].menuList[0].name);
        if(brandList[i].combinations != null){
          print(brandList[i].combinations[0].name);
        }
      }
      update();
    });
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
      cbc.addCombination(combination);
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
  List<Brand> brandList;
}