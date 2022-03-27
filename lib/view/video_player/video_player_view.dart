import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'video_player_controller.dart';
import 'widgets/vlc_player_with_controls.dart';

class VideoPlayerView extends GetView<VideoPlayerController> {
  const VideoPlayerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.videoPlayerController == null
              ? const Center(child: CircularProgressIndicator())
              : VlcPlayerWithControls(
                  controller: controller.videoPlayerController!,
                  showControls: !controller.isFullScreen,
                  onPressedFullScreen: controller.onPressedFullScreen,
                ),
        ),
      ),
    );
  }
}
