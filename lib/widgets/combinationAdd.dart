import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

import 'package:amazing_combination/controllers/MenuController.dart';
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
  List<Asset> imageList = [];
  List<String> imageUrls = [];
  @override
  Widget build(BuildContext context) {

    return  FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        combinationAddDialog();
      },
    );
  }
  Widget combinationAddDialog(){
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();
    showDialog(
      context: context,
      builder: (context){
      return StatefulBuilder(
        builder: (context, setState){
          return GetX<MenuController>(
            init: Get.put<MenuController>(MenuController(widget.brand)),
            builder: (MenuController menuController){
              return AlertDialog(
                title: Text('조합 추가'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      (imageList.isEmpty) ? Container(
                          child: Text("No Images")
                      ) :
                      Container(
                        height: 200,
                        width : MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Asset asset = imageList[index];
                              return AssetThumb(
                                  asset: asset, width: 300, height: 200);
                            }),
                      ),
                      Container(
                          child: IconButton(
                            icon: Icon(
                                Icons.add_a_photo
                            ),
                            onPressed: () async{
                              List<Asset> resultList;
                              resultList = await MultiImagePicker.pickImages(
                                maxImages: 10,
                                enableCamera: true,
                                selectedAssets: imageList,
                                cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat")
                              );
                              setState(() {
                                imageList = resultList;
                              });},
                          )
                      ),
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
                        imageList.clear();
                        imageUrls.clear();
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
                        imageList.clear();
                        imageUrls.clear();
                        Get.back();
                      }
                    },
                  )
                ],
              );
            },
          );
        },
      );

    }
    );
  }
  getImageFileFromAsset(String path) async{
    final file = File(path);

    return file;
  }
  Future<void> imageUploadToStorage(String name) async {
    if(imageList.isNotEmpty) {
      for(int i = 0 ; i < imageList.length ; i++){
        var path = await FlutterAbsolutePath.getAbsolutePath(imageList[i].identifier);
        var file = await getImageFileFromAsset(path);
        String imageName = name + "_" + Timestamp.now().toString();
        Reference storageReference =
        FirebaseStorage.instance.ref().child("combinations").child("${imageName}");

        UploadTask storageUploadTask = storageReference.putFile(file);
        imageUrls.add(await (await storageUploadTask).ref.getDownloadURL());
      }
    }
  }
  void addCombination(String name, String description, List<Menu> menus, MenuController menuController) async{
    await imageUploadToStorage(name);
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
