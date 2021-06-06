import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/EditController.dart';
import 'package:amazing_combination/controllers/LiveController.dart';
import 'package:amazing_combination/controllers/SearchController.dart';
import 'package:amazing_combination/controllers/TagController.dart';
import './CombinationController.dart';
import 'package:get/get.dart';

class MultiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandController>(() => BrandController());
    Get.lazyPut<TagController>(() => TagController());
    Get.lazyPut<EditController>(() => EditController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<LiveController>(() => LiveController());
  }
}