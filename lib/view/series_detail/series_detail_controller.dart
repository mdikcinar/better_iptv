import 'package:get/get.dart';

import '../../models/group_model.dart';

class SeriesDetailController extends GetxController {
  final RxList<Season> _seasons = <Season>[].obs;
  List<Season> get seasons => _seasons.value;
  set seasons(List<Season> val) => _seasons.value = val;

  final Rx<String> _pageTitle = ''.obs;
  String get pageTitle => _pageTitle.value;
  set pageTitle(String val) => _pageTitle.value = val;

  @override
  void onInit() {
    final seasonsArgument = Get.arguments?['seasons'] as List<Season>?;
    if (seasonsArgument != null) seasons = seasonsArgument;
    final pageTitleArgument = Get.arguments?['pageTitle'] as String?;
    if (pageTitleArgument != null) pageTitle = pageTitleArgument;
    super.onInit();
  }
}
