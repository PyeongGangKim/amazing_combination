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
                imageUrl: menu.data()['imageUrl'],
                tags: menu.data()['tag'],
                brand: menu.data()['brand'],
            )
        );
      });
      update();
    });
  }
  void selectMenu(int idx){
    _selectedMenu.add(idx);
  }
  void cancelMenu(int idx){
    _selectedMenu.remove(idx);
  }
  void clearSelectedMenu(){
    _selectedMenu.clear();
  }

  List<Menu> menuList =[];
  List<int> _selectedMenu = [];
  List<int> get selectedMenu => _selectedMenu;
}