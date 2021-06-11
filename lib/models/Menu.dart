import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String id;
  String name;
  int price;
  List<String> tags;
  String brand;
  Menu({
    this.id,
    this.name,
    this.price,
    this.tags,
    this.brand,
  });
  factory Menu.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Menu(
      id: snapshot.id,
      name: data['name'],
      price: data['price'],
      tags: data['tags'].cast<String>(),
      brand: data['brand'],
    );
  }
}