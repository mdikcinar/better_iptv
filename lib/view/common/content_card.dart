import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/utils.dart';
import '../../core/utils/widgets/custom_text.dart';

class ContentCard extends StatelessWidget {
  final String? imgUrl;
  final String title;
  final int? contentCount;
  const ContentCard({Key? key, this.imgUrl, required this.title, this.contentCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.lowRadius))),
      child: Stack(
        children: [
          if (imgUrl != null)
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Utils.lowRadius),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl!,
                    placeholder: (context, val) => Padding(
                      padding: EdgeInsets.all(Utils.normalPadding),
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, imgUrl, err) => Padding(
                      padding: EdgeInsets.only(top: Utils.highPadding),
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: Utils.highIconSize,
                      ),
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Utils.lowRadius),
                    bottomRight: Radius.circular(Utils.lowRadius),
                  )),
              padding: EdgeInsets.symmetric(vertical: Utils.lowPadding),
              height: Platform.isWindows ? Get.width * 0.025 : Get.width * 0.1,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      title,
                      minFontSize:
                          Platform.isWindows ? Utils.lowTextSize.roundToDouble() : Utils.extraLowTextSize.roundToDouble(),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Utils.highTextSize),
                    ),
                  ),
                  if (contentCount != null) CustomText(contentCount.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
