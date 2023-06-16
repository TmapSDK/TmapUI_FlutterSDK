import 'package:go_router/go_router.dart';
import 'package:tmap_ui_sdk_example/pages/drive/drive_page.dart';
import 'package:tmap_ui_sdk_example/pages/root/root_page.dart';

class AppRoutes {
  static const initialPage = AppRoutes.rootPage;

  static const rootPage = '/';
  static const drivePage = '/drive';
}

GoRouter router() {
  return GoRouter(
    initialLocation: AppRoutes.initialPage,
    routes: [
      GoRoute(
        path: AppRoutes.rootPage,
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'drive',
            builder: (context, state) => const DrivePage(),
          ),
        ]
      ),
    ],
  );
}
