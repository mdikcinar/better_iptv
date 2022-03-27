import 'package:get/get.dart';

import 'home_controller.dart';
import 'home_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeService());
    Get.lazyPut(() => HomeController());
  }
}
