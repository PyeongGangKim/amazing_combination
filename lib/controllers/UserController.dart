import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../models/Combination.dart';

class UserController extends GetxController {
  AuthenticationController ac = Get.find<AuthenticationController>();
/*
  void LoadUser(){
  FirebaseFirestore.instance
      .collection('product')
      .snapshots()
      .listen((snapshot){
  snapshot.docs.forEach((document) {

      });
    });
  }*/
  void loadUser() async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(ac.auth.uid)
        .get().then((DocumentSnapshot ds){
          user = User(
            ds.id,
            ds.data()["nickname"],
            ds.data()["imageUrl"],
            ds.data()["description"],
            ds.data()["combinations"],
          );
        }
    );
  }
  void addUser(){
    FirebaseFirestore.instance
        .collection('user')
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
        .collection('user')
        .doc(user.id)
        .update({
      'nickname' : changeUser.nickname,
      'imageUrl' : changeUser.imageUrl,
      'descrpition' : changeUser.description,
      'combinations' : changeUser.combinations,
    });
    user = changeUser;
    update();
  }

  void addUserCombination(Combination combination){
    FirebaseFirestore.instance
        .collection('user')
        .doc(user.id)
        .collection('combinations')
        .doc(combination.id)
        .set({
      'name': combination.name,
      'brand': combination.brand,
      'menuList': combination.menuList,
      'tag': combination.tag,
      'imageUrls': combination.imageUrls,
      'description': combination.description,
      'createdDateTime' : combination.createdDateTime,
      'like': combination.like,
      'likePerson' : combination.likePerson,
      'uid': combination.uid,
      'maker': combination.maker,
    });

  }
  User user;
}