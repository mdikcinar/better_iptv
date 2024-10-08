import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/presentation/home/home_page.dart';
import 'package:betteriptv/features/presentation/landing/landing_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
// GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => HomePage(
              playlist: state.extra! as Playlist,
            ),
          ),
        ],
      ),
    ],
  );
}
