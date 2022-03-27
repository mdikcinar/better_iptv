import 'package:get/get.dart';

import 'live_and_movies_controller.dart';

class LiveAndMoviesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveAndMoviesController());
  }
}
