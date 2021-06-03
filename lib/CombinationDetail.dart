import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/TagController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/CommentController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CombinationDetailPage extends StatefulWidget {
  final Combination combination;
  const CombinationDetailPage({
    Key key,
    @required this.combination
}) : super(key: key);
  @override
  _CombinationDetailState createState() => _CombinationDetailState();
}

class _CombinationDetailState extends State<CombinationDetailPage> {
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int like = widget.combination.like;
    List<String> likePerson = widget.combination.likePerson;
    UserController userController;
    if(Get.isRegistered<UserController>()){
      userController = Get.find<UserController>();
    }
    String menuList = widget.combination.menuList[0];
    for(int i = 1; i < widget.combination.menuList.length; ++i) {
      menuList += ', ' + widget.combination.menuList[i];
    }

    return Scaffold(
      body: Column(
        children: [
          (widget.combination.imageUrls.isNotEmpty) ?
          Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Swiper(
                itemBuilder: (BuildContext context,int idx){
                  return Image.network(widget.combination.imageUrls[idx],fit: BoxFit.fill,);
                },
                itemCount: widget.combination.imageUrls.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(),
              )
          ) : Container(),
          Row(
            children: [
              SizedBox( width: 15,),
              Expanded(
                  child: Text(
                    widget.combination.name,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700
                    ),
                  )
              ),

              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      (!Get.isRegistered<UserController>()) ?
                      IconButton(
                        icon : Icon(
                          Icons.favorite_border,
                        ),
                        iconSize: 30,
                        onPressed: (){
                          Get.snackbar("Login 필요", "Login이 필요한 서비스 입니다.");
                        },
                      ) :
                      GetX<TagController>
                        (
                          init: Get.put<TagController>(TagController()),
                          builder: (TagController tagController){
                            return IconButton(
                              icon : (likePerson.contains(userController.user.id)) ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ) : Icon(Icons.favorite_border),
                              iconSize: 30,
                              onPressed: (){
                                if(likePerson.contains(userController.user.id)){
                                  widget.combination.likePerson.remove(userController.user.id);
                                  widget.combination.like--;
                                  setState(() {
                                    like = widget.combination.like;
                                    likePerson = widget.combination.likePerson;
                                  });
                                  Get.find<CombinationController>().updateLike(widget.combination);
                                }
                                else{
                                  widget.combination.likePerson.add(userController.user.id);
                                  widget.combination.like++;
                                  setState(() {
                                    like = widget.combination.like;
                                    likePerson = widget.combination.likePerson;
                                  });
                                  Get.find<CombinationController>().updateLike(widget.combination);
                                }
                              },
                            );
                          }
                      ),
                      Text(like.toString()),
                    ],
                  )
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.topLeft,
            child: Text("combination maker: " + widget.combination.maker),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            child:Row(
              children: [
                Padding(
                  padding : EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.restaurant,
                    size: 30,
                  ),
                ),
                Text(
                  "brand: " + widget.combination.brand,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
            child:Row(
              children: [
                Padding(
                  padding : EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                  padding : EdgeInsets.fromLTRB(0, 0, 10, 0),
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
            init: Get.put<CommentController>(CommentController(widget.combination)),
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
                      if(ac.user.uid == null) {
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

