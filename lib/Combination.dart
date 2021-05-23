
import 'package:amazing_combination/widgets/combinationList.dart';
import 'package:flutter/material.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('조합'),
      ),
      body: Column(
        children: [
          Image.asset('img/yee.PNG'),
          Expanded(
            child: CombinationList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TextEditingController nameController = TextEditingController();
          TextEditingController descController = TextEditingController();

          print('yee');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('조합 추가'),
                // TODO: tags and menus
                // TODO: image picker
                content: Column(
                  children: <Widget>[
                    Image.asset('img/yee.PNG'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '조합의 이름을 입력해보세요'
                      ),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '조합을 설명해보세요'
                      ),
                      controller: descController,
                    )
                  ],
                ),

                actions: <Widget>[
                  TextButton(
                    child: Text('취소'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text('추가'),
                    onPressed: () {
                      print('add new combination');
                      // TODO: add new combination, reload
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
}
