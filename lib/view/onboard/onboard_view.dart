import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/utils.dart';
import '../../core/utils/widgets/custom_elevated_button.dart';
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
        body: Padding(
          padding: EdgeInsets.all(Utils.normalPadding),
          child: SafeArea(
            child: Obx(
              () => controller.state == OnBoardState.Busy
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CustomText.high('Playlist Downloading..')],
                        ),
                        SizedBox(height: Utils.normalPadding),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText.extraHigh('Enter Your Playlist', bold: true),
                        SizedBox(height: Get.height * 0.05),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                label: 'Playlist Link',
                                hintText: 'http://host.com:8080/get.php?username=test&password=test&type=m3u_plus&output=mpegts',
                                onSaved: (value) {
                                  if (value != null) {
                                    controller.getPlaylist(value);
                                  }
                                },
                              ),
                              SizedBox(height: Utils.normalPadding),
                              CustomElevatedButton(
                                child: CustomText('Get Playlist', textColor: Colors.white),
                                onPressed: () {
                                  if (controller.formKey.currentState?.validate() ?? false) {
                                    controller.formKey.currentState?.save();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
