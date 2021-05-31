import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/models/Menu.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/models/Brand.dart';

class CombinationAdd extends StatefulWidget {
  final Brand brand;
  CombinationAdd(
      this.brand
      );
  @override
  _CombinationAddState createState() => _CombinationAddState();
}

class _CombinationAddState extends State<CombinationAdd> {
  static final BrandController bc = Get.find<BrandController>();
  List<bool> _isChecked = [false, false];
  List<int> selectedMenu = [];
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        print("add button");
        combinationAdd();
      },
    );
  }
  Widget combinationAdd(){
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    print('yee');
    showDialog(
        context: context,
        builder: (context){
        return GetX<MenuController>(
          init: Get.put<MenuController>(MenuController(widget.brand)),
          builder: (MenuController menuController){
            return AlertDialog(
              title: Text('조합 추가'),
              // TODO: tags and menus
              // TODO: image picker
              content: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset('img/yee.PNG'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: '조합의 이름을 입력해보세요'
                      ),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: '조합을 설명해보세요'
                      ),
                      controller: descController,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                      child: Text("메뉴를 선택하시오."),
                    ),
                    (menuController.menuList.isNotEmpty) ?
                    Container(
                      child: menuList(menuController.menuList),
                      width: 400,
                      height: 100,
                    ) : Align(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                    child: Text('취소'),
                    onPressed: () {
                      Get.back();
                      selectedMenu.clear();
                    }
                ),
                TextButton
                  (
                  child: Text('추가'),
                  onPressed: () {
                    print('add new combination');
                    if (!_formKey.currentState.validate() ||
                        selectedMenu.isEmpty) {
                      Get.snackbar('Can not', 'Fill Name and Select Menu',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                    // TODO: add new combination, reload
                    else {
                      addCombination(nameController.text, descController.text, menuController.menuList);
                      Get.back();
                    }
                  },
                )
              ],
            );
          },
        );
      }
    );
  }
  Widget menuList(List<Menu> menus) {
    /*for(int i = 0 ; i < menus.length ; i++){
      _isChecked.add(false);
    }*/
    return ListView.separated(
      itemBuilder: ( _, int index) => _menu(menus, index),
      separatorBuilder: (_, int index) => const Divider(),
      itemCount: menus.length,
    );
  }
  Widget _menu(List<Menu> menus, int idx){

    return CheckboxListTile(
      selected: _isChecked[idx],
      value : _isChecked[idx],
      title: Text(menus[idx].name),
      checkColor: Color(0xFFED794E),
      onChanged: (curState) {
        setState(() {
          print("change");
          print(_isChecked[idx]);
          _isChecked[idx] = curState;
        });
        if (_isChecked[idx]) {
          selectedMenu.add(idx);
        }
        else {
          selectedMenu.remove(idx);
        }
      }
    );
  }
  void addCombination(String name, String description, List<Menu> menus){
    List<String> menuList = [];
    List<String> tags = [];
    for(int i = 0 ; i < selectedMenu.length ; i++){
      menuList.add(menus[selectedMenu[i]].name);
      for(int j = 0 ; j < menus[selectedMenu[i]].tags.length ; j++){
        if(!tags.contains(menus[selectedMenu[i]].tags[j])) tags.add(menus[selectedMenu[i]].tags[j]);
      }
    }
    Combination newCombination = Combination(
      brand:widget.brand.name,
      name: name,
      description : description,
      tags: tags,
      menuList: menuList,
      uid: "aaa",//uc.id,
      maker : "peace", //uc.name
      like : 0,
      likePerson: <String>[],
      imageUrls: <String>[],
    );
    bc.addCombinationInBrand(newCombination, widget.brand.name);
  }

}
