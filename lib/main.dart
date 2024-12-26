import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/routes/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:media_kit/media_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiManager.configureDependencies();
  MediaKit.ensureInitialized();

  return runApp(
    CupertinoApp.router(
      title: "Better IpTV",
      routerConfig: AppRouter.router,
    ),
  );
}
