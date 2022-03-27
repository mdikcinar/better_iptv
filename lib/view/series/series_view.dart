import 'dart:io';

import 'package:betteriptv/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../common/content_card.dart';
import 'series_controller.dart';

class SeriesView extends GetView<SeriesController> {
  const SeriesView({Key? key}) : super(key: key);
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
        itemCount: controller.series.length,
        itemBuilder: (context, index) {
          final tvSerie = controller.series[index];

          return InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.seriesDetail,
                arguments: {
                  'seasons': tvSerie.seasons,
                  'pageTitle': tvSerie.title,
                },
              );
            },
            child: ContentCard(
              imgUrl: tvSerie.imgUrl,
              title: tvSerie.title,
            ),
          );
        },
      ),
    );
  }
}
