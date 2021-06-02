import 'dart:io';

import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../models/Combination.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class UserController extends GetxController {
  AuthenticationController ac = Get.find<AuthenticationController>();

  Rx<User> _appUser = User().obs;
  User get user => _appUser.value;
  set user(User value) => this._appUser.value = value;

  @override
  void onInit() {
    if(!ac.user.isBlank){
    _appUser.bindStream(Database().userStream(ac.user.uid));
    }
  }

  void clear() {
    _appUser.value = User();
  }
  bool isUserNull(){
    if(_appUser.value.isBlank) return true;
    else return false;
  }
  // Future<void> loadUser() async {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc('ac.auth.uid')
  //       .snapshots()
  //       .listen((user) {
  //     List<Combination> combinationList = [];
  //     FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(user.id)
  //         .collection('Combinations')
  //         .snapshots()
  //         .listen((combinations) {
  //       combinations.docs.forEach((combination) {
  //         combinationList.add(Combination(
  //           id: combination.id,
  //           name: combination.data()['name'],
  //           brand: combination.data()['brand'],
  //           menuList: combination.data()['menuList'].cast<String>(),
  //           tags: combination.data()['tags'].cast<String>(),
  //           imageUrls: combination.data()['imageUrls'].cast<String>(),
  //           description: combination.data()['description'],
  //           createdDateTime:
  //               combination.data()['createdDateTime'].toDate().toString(),
  //           like: combination.data()['like'],
  //           likePerson: combination.data()['likePerson'].cast<String>(),
  //           uid: combination.data()['uid'],
  //           maker: combination.data()['maker'],
  //         ));
  //       });
  //     });
  //     _appUser.value.id = user.id;
  //     _appUser.value.combinations = combinationList;
  //     _appUser.value.nickname = user.data()["nickname"];
  //     _appUser.value.imageUrl = user.data()["imageUrl"];
  //     _appUser.value.description = user.data()["description"];
  //     update();
  //   });
  // }
  //
  // Future<void> addUser() async {
  //   FirebaseFirestore.instance.collection('Users').doc(ac.auth.uid).set({
  //     'id': ac.auth.uid,
  //     'nickname': ac.auth.displayName,
  //     'imageUrl': ac.auth.photoURL,
  //     'description': "자신에 대해 알려주세요!",
  //   });
  //   update();
  // }
  //
  void updateUser(String nickname, String desc, String selectedImage) async {
    if (selectedImage == '') {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(_appUser.value.id)
          .update({
        'nickname': nickname,
        'description': desc,
      });
    } else {
      print('filename: ' + _appUser.value.id);
      String filename = _appUser.value.id;
      Reference reference =
          FirebaseStorage.instance.ref().child('users/$filename');
      await reference.putFile(File(selectedImage));

      String imageURL = await reference.getDownloadURL();
      print('fileURL: ' + imageURL);

      FirebaseFirestore.instance
          .collection('Users')
          .doc(_appUser.value.id)
          .update({
        'nickname': nickname,
        'imageUrl': imageURL,
        'description': desc,
      });
    }
  }
  //
  // void addCombinationInUser(Combination combination) {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(_appUser.value.id)
  //       .collection('Combinations')
  //       .doc(combination.id)
  //       .set({
  //     'name': combination.name,
  //     'brand': combination.brand,
  //     'menuList': combination.menuList,
  //     'tags': combination.tags,
  //     'imageUrls': combination.imageUrls,
  //     'description': combination.description,
  //     'createdDateTime': combination.createdDateTime,
  //     'like': combination.like,
  //     'likePerson': combination.likePerson,
  //     'uid': combination.uid,
  //     'maker': combination.maker,
  //   });
  // }
}
