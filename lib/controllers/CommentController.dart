import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/models/Comment.dart';
import 'package:amazing_combination/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Combination combination;
  RxList<Comment> comments = RxList<Comment>();

  CommentController(this.combination);

  Future<void> addComment(String content) {
    User user = Get.find<UserController>().user;
    FirebaseFirestore.instance
        .collection('Brands')
        .doc(combination.brand)
        .collection('Combinations')
        .doc(combination.id)
        .collection('Comments')
        .add({
      'id': user.id,
      'maker': user.nickname,
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
        .map((comments) {
      List<Comment> ret = [];
      comments.docs.forEach((comment) {
        ret.add(Comment.fromFirebase(comment));
      });
      return ret;
    }));
  }
}
