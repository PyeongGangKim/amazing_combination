import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/controllers/MenuController.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import './CombinationController.dart';
import 'package:get/get.dart';

class MultiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CombinationController>(CombinationController());
    Get.put<AuthenticationController>(AuthenticationController());
    Get.put<MenuController>(MenuController());
    Get.put<UserController>(UserController());
    Get.put<BrandController>(BrandController());
  }
}