import 'package:amazing_combination/Combination.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/models/Brand.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({Key key, @required this.initialIndex}) : super(key: key);
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    BrandController bc = Get.find<BrandController>();

    return DefaultTabController(
      initialIndex: initialIndex,
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: Text('브랜드'),
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            isScrollable: true,
            tabs: [
              Tab(
                text: '한식',
              ),
              Tab(text: '일식'),
              Tab(text: '중식'),
              Tab(text: '치킨'),
              Tab(text: '피자'),
              Tab(text: '햄버거'),
              Tab(text: '도시락'),
              Tab(text: '양식'),
              Tab(text: '야식'),
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

Widget BrandList(int brandIdx) {
  return GetX<BrandController>(builder: (BrandController brandController) {
    RxList<Brand> brandList;
    switch (brandIdx) {
      case 0:
        brandList = brandController.koreanList;
        break;
      case 1:
        brandList = brandController.japaneseList;
        break;
      case 2:
        brandList = brandController.chineseList;
        break;
      case 3:
        brandList = brandController.chickenList;
        break;
      case 4:
        brandList = brandController.pizzaList;
        break;
      case 5:
        brandList = brandController.hamburgerList;
        break;
      case 6:
        brandList = brandController.dosirakList;
        break;
      case 7:
        brandList = brandController.westernList;
        break;
      case 8:
        brandList = brandController.hungryList;
        break;
    }
    return (brandList == null)
        ? Align(child: CircularProgressIndicator())
        : brandList.isEmpty
            ? Container(
                alignment: Alignment.center, child: Text('아직 등록된 음식점이 없어요...'))
            : ListView.separated(
                itemBuilder: (context, int index) => _Brand(brandList, index),
                separatorBuilder: (context, int index) => const Divider(),
                itemCount: brandList.length,
              );
  });
}

Widget _Brand(List<Brand> brands, int idx) {
  return ListTile(
    leading: Image.asset('img/yee.PNG'),
    // leading: Icon(Icons.fastfood),
    title: Text(brands[idx].name),
    onTap: () {
      print(brands[idx].name);
      Get.to(() => CombinationPage(
            brand: brands[idx],
          ));
    },
  );
}
