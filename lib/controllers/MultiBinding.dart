import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/BrandController.dart';
import 'package:amazing_combination/controllers/EditController.dart';
import 'package:amazing_combination/controllers/LiveController.dart';
import 'package:amazing_combination/controllers/SearchController.dart';

import './CombinationsByBrandController.dart';
import 'package:get/get.dart';

class MultiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BrandController>(BrandController());
    Get.lazyPut<EditController>(() => EditController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<LiveController>(() => LiveController());
  }
}