
import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/CommentController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CombinationDetailPage extends StatelessWidget {
  final Combination combination;
  static final _formKey = GlobalKey<FormState>();
  const CombinationDetailPage({Key key, @required this.combination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String menuList = combination.menuList[0];
    for(int i = 1; i < combination.menuList.length; ++i) {
      menuList += ', ' + combination.menuList[i];
    }

    return Scaffold(
      body: Column(
        children: [
          Image.asset('img/yee.PNG'),
          Text(combination.name + ' by ' + combination.maker),
          Text(combination.brand),
          Text('메뉴: ' + menuList),
          Column(
            children: [
              Icon(Icons.favorite, color: Colors.red,),
              Text(combination.like.toString()),
            ],
          ),
          Text('Comments'),
          GetX<CommentController>(
            init: Get.put<CommentController>(CommentController(combination)),
            builder: (CommentController commentController) {
              if(commentController != null && commentController.comments != null) {
                print('comments: ' + commentController.comments.length.toString());
                if(commentController.comments.isEmpty) {
                  return Text('No comments yet...');
                }
                else {
                  print('yee ' + commentController.comments.length.toString());
                  return Expanded(
                    child: ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (_, index) {
                        print(index.toString() + '   ' + commentController.comments[index].content);
                        return Text(commentController.comments[index].maker +
                            ' ' + commentController.comments[index].content);
                      },
                    ),
                  );
                }
              }
              else return CircularProgressIndicator();
            },

          )
          // Comment ListView
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TextEditingController commentController = TextEditingController();

          Get.defaultDialog(
            title: 'add comment',
            content: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: commentController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter comment';
                      }
                      return null;
                    },
                  ),
                ]
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  if(commentController.text == '') print('yeee');
                  else print(commentController.text);
                  Get.back();
                },
              ),
              TextButton(
                child: Text('추가'),
                onPressed: () {
                  if(!_formKey.currentState.validate()) {
                    Get.snackbar('X', 'Enter comment', snackPosition: SnackPosition.BOTTOM);
                  }
                  else {

                    AuthenticationController ac = Get.find<AuthenticationController>();
                    // print(ac.auth.uid);
                    if(ac.user.uid != null) {
                      print('logout');
                      commentController.clear();
                      Get.back();
                      Get.snackbar('Login Required', 'Please login to write comment', snackPosition: SnackPosition.BOTTOM);

                    }
                    else {
                      print('login');
                      Get.find<CommentController>().addComment(
                        ac.user.uid,
                          commentController.text
                      );
                      commentController.clear();
                      Get.back();
                    }
                  }
                },
              )

            ]
          );

        },
      ),
    );
  }
}
