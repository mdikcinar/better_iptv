import 'package:get/get.dart';

import '../../models/group_model.dart';

class LiveAndMoviesController extends GetxController {
  final RxList<Episode> _episodes = <Episode>[].obs;
  List<Episode> get episodes => _episodes.value;
  set episodes(List<Episode> val) => _episodes.value = val;

  final Rx<String> _pageTitle = ''.obs;
  String get pageTitle => _pageTitle.value;
  set pageTitle(String val) => _pageTitle.value = val;

  @override
  void onInit() {
    final episodesArgument = Get.arguments?['content'] as List<Episode>?;
    if (episodesArgument != null) episodes = episodesArgument;
    final pageTitleArgument = Get.arguments?['pageTitle'] as String?;
    if (pageTitleArgument != null) pageTitle = pageTitleArgument;
    super.onInit();
  }
}
