import 'package:get/get.dart';

import 'series_controller.dart';

class SeriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeriesController());
  }
}
