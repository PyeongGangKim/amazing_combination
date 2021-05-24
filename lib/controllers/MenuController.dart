import 'package:get/get.dart';
import '../models/Menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Comment.dart';
import '../models/Combination.dart';
import 'dart:async';

class MenuController extends GetxController {
  MenuController(){
    loadMenu();
  }
  void loadMenu() {
    print("--------Menu load----------");
    FirebaseFirestore.instance
        .collection('Menus')
        .snapshots()
        .listen((snapshots){
      menuList = [];
      snapshots.docs.forEach((menu) {
        menuList.add(
            Menu(
                id: menu.id,
                name: menu.data()['name'],
                price: menu.data()['price'],
                imageUrl: menu.data()['imageUrl'].cast<String>(),
                tags: menu.data()['tag'].cast<String>(),
            )
        );
      });
      update();
    });
  }
  List<Menu> menuList;
}