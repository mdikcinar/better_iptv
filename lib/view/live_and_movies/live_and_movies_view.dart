import 'dart:io';

import 'package:betteriptv/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:process_run/shell.dart';

import '../../core/routes/app_routes.dart';
import '../common/content_card.dart';
import 'live_and_movies_controller.dart';

class LiveAndMoviesView extends GetView<LiveAndMoviesController> {
  const LiveAndMoviesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => CustomText.high(
              controller.pageTitle,
              textColor: Colors.white,
            )),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Platform.isWindows ? Get.width ~/ 150 : Get.width ~/ 100),
        itemCount: controller.episodes.length,
        itemBuilder: (context, index) {
          final content = controller.episodes[index];

          return InkWell(
              onTap: () async {
                if (content.link != null) {
                  if (Platform.isWindows) {
                    try {
                      var shell = Shell();
                      final programfiles = await shell.run("echo %PROGRAMFILES%");
                      final url = programfiles.first.stdout.toString().replaceAll('\r\n', '') + '\\VideoLAN\\VLC\\vlc.exe';
                      final Uri uri = Uri.file(url, windows: true);
                      final file = File(uri.toFilePath(windows: true));
                      if (await file.exists()) {
                        final shellUrl = 'start ${uri.toString()} --open "${content.link}"';
                        final result = await shell.run(shellUrl);
                        if (result.first.exitCode != 0) {
                          debugPrint('An error happended please specify location of VLC');
                        }
                      }
                      {
                        debugPrint('VLC is not installed');
                      }
                    } catch (e) {
                      debugPrint('Error: $e');
                    }
                  } else {
                    Get.toNamed(
                      AppRoutes.videoPlayer,
                      arguments: {'url': content.link},
                    );
                  }
                }
              },
              child: ContentCard(imgUrl: content.imgUrl, title: content.title));
        },
      ),
    );
  }
}
