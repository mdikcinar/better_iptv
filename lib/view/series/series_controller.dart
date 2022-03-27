import 'package:get/get.dart';

import '../../models/group_model.dart';

class SeriesController extends GetxController {
  final RxList<TvSerie> _series = <TvSerie>[].obs;
  List<TvSerie> get series => _series.value;
  set series(List<TvSerie> val) => _series.value = val;

  final Rx<String> _pageTitle = ''.obs;
  String get pageTitle => _pageTitle.value;
  set pageTitle(String val) => _pageTitle.value = val;

  @override
  void onInit() {
    final seriesArgument = Get.arguments?['tvSeries'] as List<TvSerie>?;
    if (seriesArgument != null) series = seriesArgument;
    final pageTitleArgument = Get.arguments?['pageTitle'] as String?;
    if (pageTitleArgument != null) pageTitle = pageTitleArgument;
    super.onInit();
  }
}
