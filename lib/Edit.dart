
import 'dart:io';

import 'package:amazing_combination/controllers/EditController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatelessWidget {

  final String name;
  final String imageURL;
  final String description;

  const EditPage({Key key, @required this.name, @required this.imageURL, @required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController descController = TextEditingController(text: description);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('정보 수정'),
      ),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (userController) {
          return GetBuilder<EditController>(
            init: EditController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: '닉네임'
                    ),
                    controller: nameController,
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() => controller.selectedImage.value == ''
                        ? Image.network(imageURL, fit: BoxFit.fill)
                        : Image.file(File(controller.selectedImage.value))
                    ),
                  ),
                  SizedBox(height: 20,),
                  IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    onPressed: () async {
                      await controller.getImage();
                      print('image picked');
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: '소개'
                    ),
                    controller: descController,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      ),
                      child: Text('저장'),
                      onPressed: () {
                        userController.updateUser(nameController.text, descController.text, controller.selectedImage.value);
                        print('save');
                        Get.back();
                      },
                    ),
                  )
                ],
              );
            },
          );
        }
      ),
    );
  }
}
