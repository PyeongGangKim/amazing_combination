
import 'package:amazing_combination/controllers/LiveController.dart';
import 'package:amazing_combination/widgets/CombinationListBrand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LivePage extends StatelessWidget {
  const LivePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveController liveController = Get.find<LiveController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('실시간'),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: '좋아요 많은 순',),
              Tab(text: '댓글 많은 순'),
            ],
          ),
        ),
        body: TabBarView(
          children: liveController.liveTabs
        ),
      ),
    );
  }
}
