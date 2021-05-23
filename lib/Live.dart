
import 'package:amazing_combination/widgets/combinationList.dart';
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
              Tab(text: 'ee',),
              Tab(text: 'eeeee'),
              Tab(text: '정렬')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CombinationList(),
            CombinationList(),
            CombinationList(),
          ],
        ),
      ),
    );
  }
}
