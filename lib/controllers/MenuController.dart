import 'package:get/get.dart';
import '../models/Menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Comment.dart';
import 'package:amazing_combination/models/Brand.dart';
import 'package:amazing_combination/services/database.dart';
import 'dart:async';

class MenuController extends GetxController {
  final Brand brand;
  RxList<Menu> menuList = RxList<Menu>();
  MenuController(this.brand);
  @override
  void onInit() {
    // TODO: implement onInit
    menuList.bindStream(Database().menuStream(brand.name));
  }


}