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
          initial: true,
          page: OnboardingRoute.page,
          path: WhisprNavigationPaths.onboardingPath,
        ),
        CustomRoute(
            page: HomeRoute.page,
            path: WhisprNavigationPaths.homePath,
            children: [
              RedirectRoute(
                path: '',
                redirectTo: WhisprNavigationPaths.voiceRecordHomePath,
              ),
              CustomRoute(
                page: VoiceRecordHomeRoute.page,
                path: WhisprNavigationPaths.voiceRecordHomePath,
              ),
              CustomRoute(
                page: FavouriteRoute.page,
                path: WhisprNavigationPaths.favouritePath,
              ),
              CustomRoute(
                page: JournalRoute.page,
                path: WhisprNavigationPaths.journalPath,
              ),
              CustomRoute(
                page: SettingsRoute.page,
                path: WhisprNavigationPaths.settingsPath,
              ),
            ]),
        CustomRoute(
          page: RecordAudioRoute.page,
          path: WhisprNavigationPaths.recordAudioPath,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: SaveAudioRecordingRoute.page,
          path: WhisprNavigationPaths.saveAudioRecordingPath,
        ),
      ];
}
