import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/utils.dart';
import '../../core/utils/widgets/custom_text.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.high(
          'Better IpTV',
          textColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.allContent.length,
        itemBuilder: (context, index) {
          final channelGroup = controller.allContent[index];

          return InkWell(
            onTap: () {
              if (channelGroup.contentList.isNotEmpty) {
                Get.toNamed(
                  AppRoutes.liveAndMovies,
                  arguments: {
                    'content': channelGroup.contentList,
                    'pageTitle': channelGroup.groupTitle,
                  },
                );
              } else if (channelGroup.tvSerie.isNotEmpty) {
                Get.toNamed(
                  AppRoutes.series,
                  arguments: {
                    'tvSeries': channelGroup.tvSerie,
                    'pageTitle': channelGroup.groupTitle,
                  },
                );
              }
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(Utils.normalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      '${channelGroup.groupTitle} (${channelGroup.contentList.isNotEmpty ? channelGroup.contentList.length : channelGroup.tvSerie.isNotEmpty ? channelGroup.tvSerie.length : 0})',
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: Utils.normalIconSize,
                      color: Get.theme.primaryColor,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
