
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

class BrandController extends GetxController {

  UserController uc = Get.find<UserController>();
  CombinationController cbc = Get.find<CombinationController>();

  TagController tc = Get.find<TagController>();

    List<Brand> brandList;
    List<Widget> brandTabs = [BrandList(), BrandList(), BrandList()];
    int _selectedBrand;
    int get selectedBrand => _selectedBrand;

  BrandController() {
    loadBrand();
  }

  void loadBrand() {
    print("--------brand load----------");
    FirebaseFirestore.instance
        .collection('Brands')
        .get()
        .then((brands) {
          brands.docs.forEach((brand) async {
            print(brand.data()['name']);
        brandList = [];
            List<Menu> menuList = [];
            List<Combination> combinationList = [];
        await FirebaseFirestore.instance
            .collection('Brands')
            .doc(brand.id)
            .collection('Menus')
            .get()
            .then((menus){
            menus.docs.forEach((menu) {
                menuList.add(
                    Menu(
                      id :menu.id,
                      name: menu.data()['name'],
                      price: menu.data()['price'],
                      imageUrl: menu.data()['imageUrl'],
                      tags: menu.data()['tags'].cast<String>().toList(),
                      brand: menu.data()['brand'],
                    )
                );
              });
          });
        combinationList = [];
        await FirebaseFirestore.instance
            .collection('Brands')
            .doc(brand.id)
            .collection('Combinations')
            .get()
            .then((combinations) {
            combinations.docs.forEach((combination) async {
            print(combination.data()['name']);
            List<Comment> commentList = [];
            await FirebaseFirestore.instance
                .collection('Brands')
                .doc(brand.id)
                .collection("Combinations")
                .doc(combination.id)
                .collection("Comments")
                .get()
                .then((comments) {
              commentList = [];
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
                    menuList: combination.data()['menuList'].cast<String>().toList(),
                    tags: combination.data()['tags'].cast<String>().toList(),
                    imageUrls: combination.data()['imageUrls'].cast<String>().toList(),
                    description: combination.data()['description'],
                    createdDateTime: combination.data()['createdDateTime']
                        .toDate()
                        .toString(),
                    like: combination.data()['like'],
                    likePerson: combination.data()['likePerson'].cast<String>().toList(),
                    uid: combination.data()['uid'],
                    maker: combination.data()['maker'],
                    comments: commentList
                )
            );
            print("--------brand Combination");
            print(combinationList[0].name);
            update();
          });
        });
        brandList.add(
            Brand(
              name: brand.data()['name'],
              menuList: menuList,
              tags: brand.data()['tags'].cast<String>().toList(),
              imageUrl: brand.data()['imageUrl'],
              combinations: combinationList,
            )
        );
            update();
      });
          print("--------brand-----------");

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
      loadBrand();
      combination.id = newCombination.id;
      //uc.addCombinationInUser(combination);
      cbc.addCombination(combination);
      for(int i = 0 ; i < combination.tags.length ; i++) {
        tc.addCombinationInTag(combination, combination.tags[i]);
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