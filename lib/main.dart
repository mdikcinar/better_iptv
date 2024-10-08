import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/routes/app_router.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiManager.configureDependencies();
  return runApp(
    CupertinoApp.router(
      title: "Better IpTV",
      routerConfig: AppRouter.router,
    ),
  );
}
