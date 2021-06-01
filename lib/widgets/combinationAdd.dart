import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/models/Menu.dart';
import 'package:amazing_combination/models/Combination.dart';
import 'package:amazing_combination/models/Brand.dart';
import 'package:amazing_combination/widgets/MenuList.dart';

class CombinationAdd extends StatefulWidget {
  final Brand brand;
  CombinationAdd(
      this.brand
      );
  @override
  _CombinationAddState createState() => _CombinationAddState();
}

class _CombinationAddState extends State<CombinationAdd> {
  static final BrandController brandController = Get.find<BrandController>();
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        print("add button");
        combinationAddDialog();
      },
    );
  }
  Widget combinationAddDialog(){
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
                      child: MenuList(List<bool>.filled(menuController.menuList.length, false)),
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
                      menuController.selectedMenu.clear();
                    }
                ),
                TextButton
                  (
                  child: Text('추가'),
                  onPressed: () {
                    print('add new combination');
                    if (!_formKey.currentState.validate() ||
                        menuController.selectedMenu.isEmpty) {
                      Get.snackbar('Can not', 'Fill Name and Select Menu',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                    else {
                      addCombination(nameController.text, descController.text, menuController.menuList, menuController);
                      menuController.selectedMenu.clear();
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

  void addCombination(String name, String description, List<Menu> menus, MenuController menuController){
    List<String> menuList = [];
    List<String> tags = [];
    for(int i = 0 ; i < menuController.selectedMenu.length ; i++){
      menuList.add(menus[menuController.selectedMenu[i]].name);
      for(int j = 0 ; j < menus[menuController.selectedMenu[i]].tags.length ; j++){
        if(!tags.contains(menus[menuController.selectedMenu[i]].tags[j])) tags.add(menus[menuController.selectedMenu[i]].tags[j]);
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
    brandController.addCombinationInBrand(newCombination, widget.brand.name);
  }

}
