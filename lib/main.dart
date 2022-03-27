import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/storage/custom_storage_service.dart';
import 'core/storage/storage_key_enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(CustomStorageService());
  final _storageService = Get.find<CustomStorageService>();
  final isContentExist = _storageService.isExist(StorageKeys.allContent);
  return runApp(
    GetMaterialApp(
      title: "Better IpTV",
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: isContentExist ? AppRoutes.home : AppRoutes.onBoard,
    ),
  );
}
