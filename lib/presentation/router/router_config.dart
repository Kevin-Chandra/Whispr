import 'package:auto_route/auto_route.dart';
import 'package:whispr/presentation/router/navigation_paths.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';

@AutoRouterConfig()
class WhisprRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: WhisprNavigationPaths.homePath,
        ),
        CustomRoute(
          page: RecordAudioRoute.page,
          path: WhisprNavigationPaths.recordAudioPath,
        ),
      ];
}
