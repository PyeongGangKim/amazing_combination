
import 'package:amazing_combination/Edit.dart';
import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: GetBuilder<AuthenticationController>(
        builder: (authenticationController) {
          return GetBuilder<UserController>(
            builder: (userController) {
              if(authenticationController.loginState == ApplicationLoginState.loggedOut) {
                return Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      await authenticationController.signInWithGoogle();
                      userController.identifyUser();
                      print('done');
                    },
                    child: Text('구글 로그인하기'),
                  ),
                );
              }
              else {
                print(userController.appUser.value.id);
                if(userController.appUser.value.id == null) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                  );
                }
                else{
                  return Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 50),
                        alignment: Alignment.center,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(' 안녕하세요, ' + userController.appUser.value.nickname + '님!'),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        print('edit');
                                        // Get.toNamed(
                                        //     '/edit',
                                        //     arguments: {
                                        //       'name': userController.appUser.value.nickname,
                                        //       'imageURL': userController.appUser.value.imageUrl,
                                        //       'description': userController.appUser.value.description
                                        //     }
                                        // );
                                        Get.to(() => EditPage(
                                            name: userController.appUser.value.nickname,
                                            imageURL: userController.appUser.value.imageUrl,
                                            description: userController.appUser.value.description)
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                    userController.appUser.value.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                                child: Text(userController.appUser.value.description)
                              ),
                            ],
                          ),
                          elevation: 10,
                        ),
                      ),
                      Text('내가 쓴 조합'),
                      // TODO: User's list of combinations
                      // Combinations liked?
                    ],
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
