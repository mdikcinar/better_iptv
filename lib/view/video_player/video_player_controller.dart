import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerController extends GetxController {
  final Rx<VlcPlayerController?> _videoPlayerController = Rx(null);
  VlcPlayerController? get videoPlayerController => _videoPlayerController.value;
  set videoPlayerController(VlcPlayerController? val) => _videoPlayerController.value = val;

  final Rx<bool> _isFullScreen = false.obs;
  bool get isFullScreen => _isFullScreen.value;
  set isFullScreen(bool val) => _isFullScreen.value = val;

  @override
  void onInit() {
    final url = Get.arguments['url'] as String?;
    if (url != null) {
      videoPlayerController = VlcPlayerController.network(
        url,
        hwAcc: HwAcc.full,
        autoPlay: true,
        autoInitialize: true,
        options: VlcPlayerOptions(
          extras: [
            '--subsdec-encoding=ISO-8859-9',
          ],
        ),
      );
    }
    super.onInit();
  }

  @override
  void onClose() async {
    await videoPlayerController?.stopRendererScanning();
    Wakelock.disable();
    if (Get.mediaQuery.orientation != Orientation.portrait) {
      SystemChrome.restoreSystemUIOverlays();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    super.onClose();
  }

  void onPressedFullScreen() {
    Wakelock.enable();
    isFullScreen = true;
    if (Get.mediaQuery.orientation == Orientation.portrait) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.restoreSystemUIOverlays();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    }
  }
}
