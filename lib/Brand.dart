
import 'package:amazing_combination/Combination.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:get/get.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({Key key}) : super(key: key);
  static final BrandController bc = Get.find<BrandController>();

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
          children: bc.brandTabs,
          // children: [
          //   BrandList(),
          //   BrandList(),
          //   BrandList(),
          // ],
        ),
      ),
    );
  }
}

Widget BrandList() {
  return GetBuilder<BrandController>(builder: (value){
    return ListView.separated(
      itemBuilder: (context, int index) => _Brand(value, index),
      separatorBuilder: (context, int index) => const Divider(),
      itemCount: (value.brandList == null) ? 0 : value.brandList.length,
    );
  });
}

Widget _Brand(BrandController value, int idx) {
  var brandName = value.brandList[idx].name;

  return ListTile(
    leading: Image.asset('img/yee.PNG'),
    // leading: Icon(Icons.fastfood),
    title: Text('$brandName'),
    onTap: () {
      value.selectBrand(idx);
      Get.toNamed(
          '/combination',
      );
    },
  );
}