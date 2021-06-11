import 'package:flutter/material.dart';
import 'package:amazing_combination/models/Menu.dart';
import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:get/get.dart';

class MenuList extends StatefulWidget {
  List<bool> isChecked;
  MenuList(
      this.isChecked
      );
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  MenuController menuController = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return menuList();
  }
  Widget menuList() {

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: ( _, int index) => _menu(index),
      separatorBuilder: (_, int index) => const Divider(),
      itemCount: menuController.menuList.length,
    );
  }
  Widget _menu(int idx){
    return CheckboxListTile(
        selected: widget.isChecked[idx],
        value : widget.isChecked[idx],
        title: Text(menuController.menuList[idx].name),
        checkColor: Color(0xFFED794E),
        onChanged: (curState) {
          setState(() {
            widget.isChecked[idx] = curState;
          });
          if (widget.isChecked[idx]) {
            menuController.selectedMenu.add(idx);
          }
          else {
            menuController.selectedMenu.remove(idx);
          }
        }
    );
  }
}

