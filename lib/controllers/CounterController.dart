import 'package:get/get.dart';

//test class
class CountController extends GetxController {

  int counter = 0;

  void incrementCounter() {
    counter++;
    print(counter);
    update();
  }
}