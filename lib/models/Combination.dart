import 'package:cloud_firestore/cloud_firestore.dart';

class Combination {
  String id;
  String name;
  String brand;
  List<String> menuList;
  List<String> tags;
  List<String> imageUrls;
  String description;
  String createdDateTime;
  int like;
  List<String> likePerson;
  String uid;
  String maker;
  //List<Comment> comments;

  Combination({
    this.id,
    this.name,
    this.brand,
    this.menuList,
    this.tags,
    this.imageUrls,
    this.description,
    this.createdDateTime,
    this.like,
    this.likePerson,
    this.uid,
    this.maker,
    //this.comments,

});
  factory Combination.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Combination(
      id: snapshot.id,
      name: data['name'],
      brand: data['brand'],
      menuList: data['menuList'].cast<String>(),
      tags: data['tags'].cast<String>(),
      imageUrls: data['imageUrls'].cast<String>(),
      description: data['description'],
      createdDateTime: data['createdDateTime'].toDate().toString(),
      like: data['like'],
      likePerson: data['likePerson'].cast<String>(),
      uid: data['uid'],
      maker: data['maker'],
    );
  }
}