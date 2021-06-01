import 'package:cloud_firestore/cloud_firestore.dart';

import 'Combination.dart';

class User {
  String id;
  String nickname;
  String imageUrl;
  String description;
  List<Combination> combinations;

  User({
      this.id,
      this.nickname,
      this.imageUrl,
      this.description,
      this.combinations
  });

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return User(
      id: data['id'],
      nickname: data['nickname'],
      imageUrl: data['imageUrl'],
      description: data['description']
    );
  }
}