import 'package:get/get.dart';

import 'series_detail_controller.dart';

class SeriesDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeriesDetailController());
  }
}
