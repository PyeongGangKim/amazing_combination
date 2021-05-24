
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
            alignment: Alignment.center,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text('닉네임: Peace'),
                  Divider(),
                  Image.asset('img/yee.PNG'),
                  Divider(),
                  Text('description'),
                ],
              ),
              elevation: 10,
            ),
          ),
          Text('내가 쓴 조합'),
          // TODO: User's list of combinations
          // Combinations liked?

        ],
      ),
    );
  }
}
