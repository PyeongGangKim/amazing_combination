import 'package:cloud_firestore/cloud_firestore.dart';


class Brand {
  String name;

  //List<Menu> menuList;
  //List<Combination> combinations;
  String imageUrl;
  List<String> tags;

  Brand({
    this.name,
    //this.menuList,
    //this.combinations,
    this.imageUrl,
    this.tags,
  });

  factory Brand.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Brand(
      name: data['name'],
      imageUrl: data['imageUrl'],
      tags: data['tags'].cast<String>(),
    );
  }
}