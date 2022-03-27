import 'package:get/get.dart';

import '../../core/storage/custom_storage_service.dart';
import '../../core/storage/storage_key_enums.dart';
import '../../models/group_model.dart';

class HomeController extends GetxController {
  final _storageService = Get.find<CustomStorageService>();

  final RxList<ChannelGroup> _allContent = <ChannelGroup>[].obs;
  List<ChannelGroup> get allContent => _allContent.value;
  set allContent(List<ChannelGroup> val) => _allContent.value = val;

  @override
  void onInit() {
    final argument = Get.arguments?['allContent'];
    if (argument != null) {
      allContent = argument;
    } else if (_storageService.isExist(StorageKeys.allContent)) {
      final readModel =
          _storageService.readModel<List<ChannelGroup>, ChannelGroup>(key: StorageKeys.allContent, parseModel: ChannelGroup());
      if (readModel != null) {
        allContent = readModel;
      }
    }
    super.onInit();
  }
}
