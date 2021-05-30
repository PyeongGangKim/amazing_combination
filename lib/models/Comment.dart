import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String maker;
  String content;
  Timestamp createdTime;

  Comment({this.id, this.maker, this.content, this.createdTime});

  factory Comment.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Comment(
      id: data['id'],
      maker: data['maker'],
      content: data['content'],
      createdTime: data['createdTime'],
    );
  }
}
