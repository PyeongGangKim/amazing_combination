import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/CombinationsByBrandController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/CommentController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CombinationDetailPage extends StatelessWidget {
  final String combinationId;
  const CombinationDetailPage({Key key, @required this.combinationId})
      : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserController userController;
    if (Get.isRegistered<UserController>()) {
      userController = Get.find<UserController>();
    }

    return GetX<CombinationController>(
        init: Get.put<CombinationController>(
            CombinationController(combinationId)),
        builder: (combinationController) {
          Combination combination = combinationController.combination.value;

          String menuList;
          if (combination.menuList == null) {
            menuList = '';
          } else {
            // for(int i = 0; i < combination.menuList.length; ++i) {
            //   print(combination.menuList[i]);
            // }
            // print('yeeeeeee');
            menuList = combination.menuList[0];
            for (int i = 1; i < combination.menuList.length; ++i) {
              menuList += ', ' + combination.menuList[i];
            }
          }

          return combination == null || combination.imageUrls == null
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  body: Column(
                    children: [
                      (combination.imageUrls.isNotEmpty)
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 350,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int idx) {
                                  return Image.network(
                                    combination.imageUrls[idx],
                                    fit: BoxFit.fill,
                                  );
                                },
                                itemCount: combination.imageUrls.length,
                                pagination: new SwiperPagination(),
                                control: new SwiperControl(),
                              ))
                          : Container(),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Text(
                            combination.name,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          )),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              alignment: Alignment.topRight,
                              child: Row(children: [
                                Column(
                                  children: [
                                    (!Get.isRegistered<UserController>())
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.favorite_border,
                                            ),
                                            iconSize: 30,
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text('로그인이 필요한 서비스입니다.'),
                                              ));
                                            },
                                          )
                                        : IconButton(
                                            icon: (combination.likePerson
                                                    .contains(
                                                        userController.user.id))
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(Icons.favorite_border),
                                            iconSize: 30,
                                            onPressed: () {
                                              if (combination.likePerson
                                                  .contains(
                                                      userController.user.id)) {
                                                combination.likePerson.remove(
                                                    userController.user.id);
                                                combination.like--;
                                                Get.find<
                                                        CombinationController>()
                                                    .updateLike(combination);
                                              } else {
                                                combination.likePerson.add(
                                                    userController.user.id);
                                                combination.like++;
                                                Get.find<
                                                        CombinationController>()
                                                    .updateLike(combination);
                                              }
                                            },
                                          ),
                                    Text(combination.like.toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      color: Colors.yellow,
                                    ),
                                    Text(combination.numOfComments.toString()),
                                  ],
                                )
                              ])),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text("combination maker: " + combination.maker),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                Icons.restaurant,
                                size: 30,
                              ),
                            ),
                            Text(
                              "brand: " + combination.brand,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                Icons.menu_book,
                                size: 30,
                              ),
                            ),
                            Text(
                              'Menu: ' + menuList,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                Icons.comment,
                                size: 30,
                              ),
                            ),
                            Text(
                              'Comments',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        color: Color(0xFFED794E),
                      ),
                      GetX<CommentController>(
                        init: Get.put<CommentController>(
                            CommentController(combination)),
                        builder: (CommentController commentController) {
                          if (commentController != null &&
                              commentController.comments != null) {
                            if (commentController.comments.isEmpty) {
                              return Text('No comments yet...');
                            } else {
                              // print('yee ' + commentController.comments.length.toString());
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: commentController.comments.length,
                                  itemBuilder: (_, index) {
                                    // print(index.toString() + '   ' + commentController.comments[index].content);
                                    return Text(commentController
                                            .comments[index].maker +
                                        ':     ' +
                                        commentController
                                            .comments[index].content);
                                  },
                                ),
                              );
                            }
                          } else
                            return CircularProgressIndicator();
                        },
                      )
                      // Comment ListView
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      if (!Get.isRegistered<UserController>()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('로그인이 필요한 서비스입니다.'),
                        ));
                      } else {
                        TextEditingController commentController =
                            TextEditingController();

                        Get.defaultDialog(
                            title: 'add comment',
                            content: Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                TextFormField(
                                  controller: commentController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter comment';
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('취소'),
                                onPressed: () {
                                  if (commentController.text == '')
                                    print('yeee');
                                  else
                                    print(commentController.text);
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: Text('추가'),
                                onPressed: () {
                                  if (!_formKey.currentState.validate()) {
                                    Get.snackbar('X', 'Enter comment',
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    AuthenticationController ac =
                                        Get.find<AuthenticationController>();
                                    // print(ac.auth.uid);
                                    if (ac.user.uid == null) {
                                      print('logout');
                                      commentController.clear();
                                      Get.back();
                                      Get.snackbar('Login Required',
                                          'Please login to write comment',
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else {
                                      Get.find<CommentController>()
                                          .addComment(commentController.text);
                                      combination.numOfComments++;
                                      Get.find<CombinationController>()
                                          .updateComment(combination);
                                      commentController.clear();
                                      Get.back();
                                    }
                                  }
                                },
                              )
                            ]);
                      }
                    },
                  ),
                );
        });
  }
}
