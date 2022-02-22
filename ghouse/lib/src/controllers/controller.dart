import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  var json = ''.obs;

  increment() => count++;
  change(c) => json = c;
}
