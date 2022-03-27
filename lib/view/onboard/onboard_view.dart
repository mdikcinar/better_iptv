import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/utils.dart';
import '../../core/utils/widgets/custom_elevated_button.dart';
import '../../core/utils/widgets/custom_inkwell.dart';
import '../../core/utils/widgets/custom_text.dart';
import '../../core/utils/widgets/custom_text_form_field.dart';
import 'onboard_controller.dart';

class OnBoardView extends GetView<OnBoardController> {
  const OnBoardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText.high(
            'Better IpTV',
            textColor: Colors.white,
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: Utils.highIconSize),
          onPressed: () => _showAddPlaylistDialog(),
        ),
        body: Padding(
          padding: EdgeInsets.all(Utils.normalPadding),
          child: SafeArea(
            child: Obx(() => controller.allPlaylists != null
                ? ListView.separated(
                    itemCount: controller.allPlaylists!.length,
                    separatorBuilder: (context, index) => SizedBox(height: Utils.normalPadding),
                    itemBuilder: (context, index) {
                      final playlist = controller.allPlaylists![index];
                      return CustomInkwell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.home,
                            arguments: {'playlist': playlist},
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(Utils.normalPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText((playlist.name ?? '').toUpperCase()),
                                      SizedBox(height: Utils.extraLowPadding),
                                      Text(
                                        playlist.url,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: Utils.lowTextSize, color: getTextColor.withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomInkwell(
                                      padding: EdgeInsets.all(Utils.lowPadding),
                                      onTap: () {
                                        Get.defaultDialog(
                                          title: 'Delete playlist',
                                          middleText: 'Do you want to delete ${playlist.name}?',
                                          confirmTextColor: getReversedTextColor,
                                          onCancel: () => Get.back(),
                                          onConfirm: () {
                                            controller.deletePlaylist(playlist.id);
                                            Get.back();
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: Utils.highIconSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CustomElevatedButton(
                      padding: Platform.isWindows ? EdgeInsets.all(Utils.highPadding) : null,
                      child: CustomText(
                        'Add Playlist',
                        textColor: Colors.white,
                      ),
                      onPressed: () => _showAddPlaylistDialog(),
                    ),
                  )),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddPlaylistDialog() async {
    Get.defaultDialog(
      title: 'Add New Playlist',
      content: _addPlaylistForm(),
    );
  }

  Form _addPlaylistForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Playlist Name',
            hintText: 'My playlist',
            onSaved: (value) {
              if (value != null) {
                controller.playlistName = value;
              }
            },
          ),
          SizedBox(height: Utils.normalPadding),
          CustomTextFormField(
            label: 'Playlist Link(M3U)',
            hintText: 'http://host.com:8080/get.php?username=test&password=test&type=m3u_plus&output=mpegts',
            canBeEmpty: false,
            onSaved: (value) {
              if (value != null) {
                controller.playlistUrl = value;
              }
            },
          ),
          SizedBox(height: Utils.normalPadding),
          CustomElevatedButton(
            padding: Platform.isWindows ? EdgeInsets.all(Utils.highPadding) : null,
            child: CustomText('Add Playlist', textColor: Colors.white),
            onPressed: () {
              if (controller.formKey.currentState?.validate() ?? false) {
                controller.formKey.currentState?.save();
                controller.addPlaylist();
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }
}
