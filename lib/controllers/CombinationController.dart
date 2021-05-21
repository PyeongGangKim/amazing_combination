import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Comment.dart';
import '../models/Combination.dart';
import 'dart:async';

class CombinationController extends GetxController {
  CombinationController(){

    init();
  }
  Future<void> init() async {
    print("----------------init---------------");
    await Firebase.initializeApp();
    await loadCombination();
  }
  Future<void> loadCombination() async{
    print("--------load----------");
    FirebaseFirestore.instance
        .collection('combination')
        .get()
        .then((snapshots){
          combinationList = [];
      snapshots.docs.forEach((combination) {
        List<Comment> commentList = [];
          FirebaseFirestore.instance
              .collection('combination/$combination.id/comments')
              .get()
              .then((comments){
                comments.docs.forEach((comment){
                  commentList.add(
                    Comment(
                      id :comment.id,
                      maker: comment.data()['maker'],
                      content: comment.data()['content']
                    )
                  );
                });
          });
        combinationList.add(
          Combination(
            id: combination.id,
            name: combination.data()['name'],
            brand: combination.data()['brand'],
            menuList: combination.data()['menuList'].cast<String>(),
            tag: combination.data()['tag'].cast<String>(),
            imageUrls: combination.data()['imageUrls'].cast<String>(),
            description: combination.data()['description'],
            createdDateTime: combination.data()['createdDateTime'].toDate().toString(),
            like: combination.data()['like'],
            likePerson: combination.data()['likePerson'].cast<String>(),
            uid: combination.data()['uid'],
            maker: combination.data()['maker'],
            comments: commentList
          )
        );
       });
      update();
      for(int i = 0 ; i < combinationList.length ; i++){
        print(combinationList[i].id);
      }
    });
    }

    void addCombination(Combination combination){
    print("--------add----------");
      FirebaseFirestore.instance
          .collection('combination')
          .add({
        'name': combination.name,
        'brand': combination.brand,
        'menuList': combination.menuList,
        'tag': combination.tag,
        'imageUrls': combination.imageUrls,
        'description': combination.description,
        'createdDateTime': FieldValue.serverTimestamp(),
        'like': combination.like,
        'likePerson': combination.likePerson,
        'uid': combination.uid,
        'maker': combination.maker,
      }).then((value) {
        value.get().then((result){
          List<Comment> commentList = [];
          combination.id = result.id;
          combination.comments = commentList;
          combination.createdDateTime = result.data()["createdDateTime"].toDate.toString();
        combinationList.add(combination);
        update();
        for(int i = 0 ; i < combinationList.length ; i++){
          print(combinationList[i].id);
        }
        });
      });
    }
    List<Combination> combinationList;
}
