
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditController extends GetxController {

  final selectedImage = ''.obs;

  Future<void> getImage() async {
    print('pick image');
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    print('picked');
    if(pickedFile != null) {
      selectedImage.value = pickedFile.path;
      print('updated');
    }
    else {
      print('not picked');
    }
  }
}