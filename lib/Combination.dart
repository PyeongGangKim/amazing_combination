import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/widgets/combinationList.dart';
import 'package:amazing_combination/models/Combination.dart';

import 'package:amazing_combination/models/Brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/widgets/menuList.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({Key key}) : super(key: key);
  static final idx = Get.arguments['idx'];
  static final BrandController bc = Get.find<BrandController>();
  static final CombinationController cbc = Get.find<CombinationController>();
  static final MenuController mc = Get.find<MenuController>();
  static final UserController uc = Get.find<UserController>();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('조합'),
      ),
      body: Column(
        children: [
          Image.asset('img/yee.PNG'),
          Expanded(
            child: CombinationList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TextEditingController nameController = TextEditingController();
          TextEditingController descController = TextEditingController();

          print('yee');
          showDialog(
            context: context,
            builder: (context) {
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
                        validator: (value){
                          if(value == null || value.isEmpty){
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
                      Container(
                        child: MenuList(),
                        width: 400,
                        height: 100,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      child: Text('취소'),
                      onPressed: () {
                        mc.clearSelectedMenu();
                        Get.back();
                      }
                  ),
                  TextButton
                    (
                    child: Text('추가'),
                    onPressed: () {
                      print('add new combination');
                      if(!_formKey.currentState.validate() || mc.selectedMenu.isEmpty){
                        Get.snackbar('Can not', 'Fill Name and Select Menu',snackPosition: SnackPosition.BOTTOM);
                      }
                      // TODO: add new combination, reload
                      else {
                        addCombination(nameController.text, descController.text);
                        Get.back();
                      }
                    },
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
  void addCombination(String name, String description){
    List<String> menuList = [];
    List<String> tags = [];
    Brand curBrand = bc.brandList[bc.selectedBrand];
    for(int i = 0 ; i < mc.selectedMenu.length ; i++){
      menuList.add(curBrand.menuList[i].name);
      for(int j = 0 ; j < curBrand.menuList[i].tags.length ; j++){
        if(tags.contains(curBrand.menuList[i].tags[j])) continue;
        else{
          tags.add(curBrand.menuList[i].tags[j]);
        }
      }
    }
    Combination newCombination = Combination(
      brand: curBrand.name,
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
    bc.addCombinationInBrand(newCombination, bc.brandList[bc.selectedBrand].name);
  }
}
