import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Comment.dart';
import '../models/Combination.dart';
import 'dart:async';

class CombinationController extends GetxController {
  Future<void> init() async {

    await loadCombination();
  }
  Future<void> loadCombination() async{
    print("--------load----------");
    FirebaseFirestore.instance
        .collection('Combinations')
        .snapshots()
        .listen((snapshots){
          combinationList = [];
      snapshots.docs.forEach((combination) {
        /*List<Comment> commentList = [];
          FirebaseFirestore.instance
              .collection('Combination/$combination.id/Comments')
              .snapshots()
              .listen((comments){
                comments.docs.forEach((comment){
                  commentList.add(
                    Comment(
                      id :comment.id,
                      maker: comment.data()['maker'],
                      content: comment.data()['content']
                    )
                  );
                });
          });*/
        combinationList.add(
          Combination(
            id: combination.id,
            name: combination.data()['name'],
            brand: combination.data()['brand'],
            menuList: combination.data()['menuList'].cast<String>(),
            tags: combination.data()['tags'].cast<String>(),
            imageUrls: combination.data()['imageUrls'].cast<String>(),
            description: combination.data()['description'],
            createdDateTime: combination.data()['createdDateTime'].toDate().toString(),
            like: combination.data()['like'],
            likePerson: combination.data()['likePerson'].cast<String>(),
            uid: combination.data()['uid'],
            maker: combination.data()['maker'],
          )
        );
       });
      print("-----combination------");
      for(int i = 0 ; i < combinationList.length ; i++){
        combinationList[i].name;
      }
      update();
    });
    }

    void addCombination(Combination combination){
    print("--------add----------");
      FirebaseFirestore.instance
          .collection('Combinations')
          .doc(combination.id)
          .set({
        'name': combination.name,
        'brand': combination.brand,
        'menuList': combination.menuList,
        'tags': combination.tags,
        'imageUrls': combination.imageUrls,
        'description': combination.description,
        'createdDateTime': FieldValue.serverTimestamp(),
        'like': combination.like,
        'likePerson': combination.likePerson,
        'uid': combination.uid,
        'maker': combination.maker,
      });
    }

    List<Combination> combinationList;
}
