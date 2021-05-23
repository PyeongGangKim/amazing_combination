
import 'package:amazing_combination/Combination.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('브랜드'),
          bottom: TabBar(
            tabs: [
              Tab(text: '햄버거',),
              Tab(text: '치킨'),
              Tab(text: '피자')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BrandList(),
            BrandList(),
            BrandList(),
          ],
        ),
      ),
    );
  }
}

Widget BrandList() {
  return ListView.separated(
    itemBuilder: (context, int index) => _Brand(context, index),
    separatorBuilder: (context, int index) => const Divider(),
    itemCount: 10,
  );
}

Widget _Brand(BuildContext context, int index) {
  return ListTile(
    leading: Image.asset('img/yee.PNG'),
    // leading: Icon(Icons.fastfood),
    title: Text('brand name $index'),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CombinationPage())
      );
    },
  );
}