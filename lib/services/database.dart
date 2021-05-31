import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Brand.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/models/Menu.dart';
class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Stream<List<Brand>> brandStream() {
    return _firestore
        .collection("Brands")
        .snapshots()
        .map((brands) => brands.docs.map((brand) => Brand.fromFirebase(brand)).toList());
  }
  Stream<List<Combination>> combinationStream(String brandName) {
    return _firestore
        .collection("Brands")
        .doc(brandName)
        .collection("Combinations")
        .snapshots()
        .map((combinations) => combinations.docs.map((combination) => Combination.fromFirebase(combination)).toList());
  }
  Stream<List<Menu>> menuStream(String brandName) {
    return _firestore
        .collection("Brands")
        .doc(brandName)
        .collection("Menus")
        .snapshots()
        .map((menus) => menus.docs.map((menu) => Menu.fromFirebase(menu)).toList());
  }


}