import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/CombinationController.dart';
import 'package:amazing_combination/controllers/EditController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/controllers/MenuController.dart';
import './CombinationController.dart';
import 'package:get/get.dart';

class MultiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CombinationController>(() => CombinationController());
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<BrandController>(() => BrandController());
    Get.lazyPut<EditController>(() => EditController());
  }
}