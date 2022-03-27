import 'package:get/get.dart';

import 'video_player_controller.dart';

class VideoPlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoPlayerController());
  }
}
