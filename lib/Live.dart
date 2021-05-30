
import 'package:amazing_combination/widgets/CombinationListBrand.dart';
import 'package:flutter/material.dart';

class LivePage extends StatelessWidget {
  const LivePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('실시간'),
          bottom: TabBar(
            tabs: [
              Tab(text: '좋아요 많은 순',),
              Tab(text: '평점 높은 순'),
              Tab(text: '정렬기준')   // ?
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CombinationListBrand(),
            CombinationListBrand(),
            CombinationListBrand(),
          ],
        ),
      ),
    );
  }
}
