import 'package:get/get.dart';

import '../../view/home/home_binding.dart';
import '../../view/home/home_view.dart';
import '../../view/live_and_movies/live_and_movies_binding.dart';
import '../../view/live_and_movies/live_and_movies_view.dart';
import '../../view/onboard/onboard_binding.dart';
import '../../view/onboard/onboard_view.dart';
import '../../view/series/series_binding.dart';
import '../../view/series/series_view.dart';
import '../../view/series_detail/series_detail_binding.dart';
import '../../view/series_detail/series_detail_view.dart';
import '../../view/video_player/video_player_view.dart';
import '../../view/video_player/view_player_binding.dart';
import 'app_routes.dart';

class AppPages {
  static var pages = [
    GetPage(
      name: AppRoutes.onBoard,
      page: () => const OnBoardView(),
      binding: OnBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.liveAndMovies,
      page: () => const LiveAndMoviesView(),
      binding: LiveAndMoviesBinding(),
    ),
    GetPage(
      name: AppRoutes.series,
      page: () => const SeriesView(),
      binding: SeriesBinding(),
    ),
    GetPage(
      name: AppRoutes.seriesDetail,
      page: () => const SeriesDetailView(),
      binding: SeriesDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.videoPlayer,
      page: () => const VideoPlayerView(),
      binding: VideoPlayerBinding(),
    ),
  ];
}
