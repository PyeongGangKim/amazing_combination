
import 'package:amazing_combination/widgets/combinationList.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('검색'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '찾고싶은 음식을 검색해보세요!'
                  ),

                controller: controller,
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print(controller.text);
                  },
                ),
              )
            ]
          ),
          Expanded(
              child: CombinationList()
          ),
        ],
      ),
    );
  }
}
