import 'package:get/get.dart';

import '../../core/storage/custom_storage_service.dart';
import 'onboard_controller.dart';

class OnBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardController());
    Get.lazyPut(() => CustomStorageService());
  }
}
