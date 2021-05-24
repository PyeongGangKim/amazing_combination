import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../models/Combination.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class UserController extends GetxController {
  AuthenticationController ac = Get.find<AuthenticationController>();

  void loadUser() async {

    FirebaseFirestore.instance
        .collection('Users')
        .doc(ac.auth.uid)
        .snapshots()
        .listen((user){
        List<Combination> combinationList = [];
          FirebaseFirestore.instance
          .collection('Users')
          .doc(user.id)
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
          appUser = User(
            id: user.id,
            combinations: combinationList,
            nickname: user.data()["nickname"],
            imageUrl: user.data()["imageUrl"],
            description: user.data()["description"],

          );
        });
  }
  void addUser(){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(ac.auth.uid).
        set({
      'id' : ac.auth.uid,
      'nickname': ac.auth.displayName,
      'imageUrl': ac.auth.photoURL,
      'description': "",
    });
  }

  void updateUser(User changeUser){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(appUser.id)
        .update({
      'nickname' : changeUser.nickname,
      'imageUrl' : changeUser.imageUrl,
      'description' : changeUser.description,
    });
  }

  void addCombinationInUser(Combination combination){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(appUser.id)
        .collection('Combinations')
        .doc(combination.id)
        .set({
      'name': combination.name,
      'brand': combination.brand,
      'menuList': combination.menuList,
      'tags': combination.tags,
      'imageUrls': combination.imageUrls,
      'description': combination.description,
      'createdDateTime' : combination.createdDateTime,
      'like': combination.like,
      'likePerson' : combination.likePerson,
      'uid': combination.uid,
      'maker': combination.maker,
    });
  }
  User appUser;
}