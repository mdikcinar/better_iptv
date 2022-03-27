import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/widgets/custom_text.dart';
import '../common/content_card.dart';
import 'series_detail_controller.dart';

class SeriesDetailView extends GetView<SeriesDetailController> {
  const SeriesDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => CustomText.high(
              controller.pageTitle,
              textColor: Colors.white,
            )),
      ),
      body: Obx(() {
        return GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Platform.isWindows ? Get.width ~/ 150 : Get.width ~/ 100),
          itemCount: controller.seasons.length,
          itemBuilder: (context, index) {
            final season = controller.seasons[index];

            return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.liveAndMovies,
                    arguments: {
                      'content': season.episodes,
                      'pageTitle': season.title,
                    },
                  );
                },
                child: ContentCard(
                  imgUrl: season.imgUrl,
                  title: season.title,
                ));
          },
        );
      }),
    );
  }
}
