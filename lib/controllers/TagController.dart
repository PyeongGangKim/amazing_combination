import 'package:get/get.dart';
import '../models/Menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tag.dart';
import '../models/Combination.dart';
import 'dart:async';

class TagController extends GetxController {
  void loadTag() {
    print("--------load----------");
    FirebaseFirestore.instance
        .collection('Tags')
        .snapshots()
        .listen((snapshots){
      tagList = [];
      snapshots.docs.forEach((tag) {
        List<Combination> combinationList = [];
        FirebaseFirestore.instance
        .collection('Tags')
        .doc(tag.id)
        .collection('Combinations')
        .snapshots()
        .listen((combinations) {
          combinations.docs.forEach((combination) {
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
                )
            );
          });
        });
        tagList.add(
            Tag(
              name : tag.data()['name'],
              combinations: combinationList,
            )
        );
      });
      update();
    });
  }
  List<Tag> tagList;
}