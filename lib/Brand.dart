
import 'package:amazing_combination/Combination.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:get/get.dart';

class BrandPage extends StatelessWidget {
  //const BrandPage({Key key}) : super(key: key);
  BrandController bc = Get.find<BrandController>();

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
  return GetBuilder<BrandController>(builder: (value){
    return ListView.separated(
      itemBuilder: (context, int index) => _Brand(context, value),
      separatorBuilder: (context, int index) => const Divider(),
      itemCount: 10,
    );
  });
}

Widget _Brand(BuildContext context, BrandController value) {
  var brandName = value.brandList[0].name;
  return ListTile(
    leading: Image.asset('img/yee.PNG'),
    // leading: Icon(Icons.fastfood),
    title: Text('brand name $brandName'),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CombinationPage())
      );
    },
  );
}