import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:get/get.dart';

class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  static final BrandController bc = Get.find<BrandController>();
  static final MenuController mc = Get.find<MenuController>();
  List<bool> _isChecked = List<bool>.filled(bc.brandList[bc.selectedBrand].menuList.length, false);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandController>(builder: (value){
      return ListView.separated(
          itemBuilder: ( _, int index) => _menu(value, index),
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: (value.brandList[value.selectedBrand].menuList.length == null) ? 0 : value.brandList[value.selectedBrand].menuList.length,
      );
    });
  }
  Widget _menu(BrandController value, int idx){
    var menuName = value.brandList[value.selectedBrand].menuList[idx].name;
    return CheckboxListTile(
      selected: _isChecked[idx],
      value : _isChecked[idx],
      title: Text('$menuName'),
      checkColor: Color(0xFFED794E),
      onChanged: (curState) {
        setState(() {
          _isChecked[idx] = !_isChecked[idx];
        });
        if(_isChecked[idx]){
          mc.selectMenu(idx);
        }
        else{
          mc.cancelMenu(idx);
        }
      },
    );
  }
}
