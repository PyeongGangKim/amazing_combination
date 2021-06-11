import 'package:amazing_combination/Edit.dart';
import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/widgets/CombinationListMyPage.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('마이페이지'),
      ),
      body: SingleChildScrollView(
        child: GetX<AuthenticationController>(
          init: Get.put<AuthenticationController>(AuthenticationController()),
          builder: (authenticationController) {
            return authenticationController.user == null
                ? Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        await authenticationController.signInWithGoogle();
                      },
                      child: Text('구글 로그인하기'),
                    ),
                  )
                : GetX<UserController>(
                    init: Get.put<UserController>(UserController()),
                    builder: (userController) {
                      return userController.user.nickname == null
                          ? Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () async {
                                    await authenticationController.signOut();
                                  },
                                  child: Text('로그아웃'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 30, 10, 50),
                                  alignment: Alignment.center,
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Row(
                                            children: <Widget>[
                                              Text(' 안녕하세요, ' +
                                                  userController.user.nickname +
                                                  '님!'),
                                              Spacer(),
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  print('edit');
                                                  Get.to(() => EditPage(
                                                      name: userController
                                                          .user.nickname,
                                                      imageURL: userController
                                                          .user.imageUrl,
                                                      description:
                                                          userController.user
                                                              .description));
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 300,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                            userController.user.imageUrl,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 30, 10, 10),
                                            child: Text(userController
                                                .user.description)),
                                      ],
                                    ),
                                    elevation: 10,
                                  ),
                                ),
                                Text('내가 쓴 조합'),
                                CombinationListMyPage(
                                  userId: userController.user.id,
                                )
                              ],
                            );
                    });
          },
        ),
      ),
    );
  }
}
