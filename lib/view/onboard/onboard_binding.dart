import 'package:get/get.dart';

import 'onboard_controller.dart';
import 'onboard_service.dart';

class OnBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardService());
    Get.lazyPut(() => OnBoardController());
  }
}
