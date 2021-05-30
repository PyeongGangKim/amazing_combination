
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/SearchController.dart';
import 'package:amazing_combination/controllers/SearchController.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/widgets/CombinationListSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key}) : super(key: key);

  List<Combination> result = [];
  Widget combinationList = CombinationListSearch();

  @override
  Widget build(BuildContext context) {

    TextEditingController textController = TextEditingController();
    SearchController searchController = Get.find<SearchController>();

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

                controller: textController,
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchController.searchByTag(textController.text);
                  },
                ),
              )
            ]
          ),
          Expanded(
              child: combinationList
          ),
        ],
      ),
    );
  }
}
