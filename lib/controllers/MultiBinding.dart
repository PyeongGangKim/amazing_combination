import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/EditController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:amazing_combination/controllers/TagController.dart';
import './CombinationController.dart';
import 'package:get/get.dart';

class MultiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TagController>(TagController());
    Get.put<AuthenticationController>(AuthenticationController());
    Get.put<UserController>(UserController());
    Get.put<BrandController>(BrandController());
    Get.put<EditController>(EditController());
  }
}