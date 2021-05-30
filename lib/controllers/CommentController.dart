import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/models/Comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Combination combination;
  RxList<Comment> comments = RxList<Comment>();

  CommentController(this.combination);

  Future<void> addComment(String maker, String content) {
    FirebaseFirestore.instance
        .collection('Brands')
        .doc(combination.brand)
        .collection('Combinations')
        .doc(combination.id)
        .collection('Comments')
        .add({
      'id': '11',
      'maker': maker,
      'content': content,
      'createdTime': FieldValue.serverTimestamp(),
    });
  }

  @override
  void onInit() {
    comments.bindStream(FirebaseFirestore.instance
        .collection('Brands')
        .doc(combination.brand)
        .collection('Combinations')
        .doc(combination.id)
        .collection('Comments')
        .orderBy('createdTime', descending: true)
        .snapshots()
        .map((commentss) {
      List<Comment> ret = [];
      commentss.docs.forEach((comment) {
        print(comment.id);
        ret.add(Comment.fromFirebase(comment));
      });
      return ret;
    }));
    print('total: ' + comments.length.toString());
  }
}
