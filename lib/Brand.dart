
import 'package:amazing_combination/Combination.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/models/Brand.dart';

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
        ),
      ),
    );
  }
}

Widget BrandList() {
  return GetX<BrandController>(
      builder: (BrandController brandController){
    return (brandController == null || brandController.brandList.isEmpty) ?
    Align(child: CircularProgressIndicator())
    : ListView.separated(
      itemBuilder: (context, int index) => _Brand(brandController.brandList, index),
      separatorBuilder: (context, int index) => const Divider(),
      itemCount: brandController.brandList.length,
    );
  });
}

Widget _Brand(List<Brand> brands, int idx) {


  return ListTile(
    leading: Image.asset('img/yee.PNG'),
    // leading: Icon(Icons.fastfood),
    title: Text(brands[idx].name  ),
    onTap: () {
      print(brands[idx].name);
      Get.to(() => CombinationPage(brand: brands[idx],));
    },
  );
}