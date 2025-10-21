import 'package:auto_route/auto_route.dart';
import 'package:whispr/presentation/router/navigation_paths.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/navigation_transitions.dart';

@AutoRouterConfig()
class WhisprRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: OnboardingRoute.page,
          path: WhisprNavigationPaths.onboardingPath,
          transitionsBuilder: NavigationTransitions.slideUpWithExit,
          duration: Duration(
            milliseconds: WhisprDuration.onboardingNavigationTransitionDuration,
          ),
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
          ],
          duration: Duration(
            milliseconds: WhisprDuration.onboardingNavigationTransitionDuration,
          ),
          transitionsBuilder: NavigationTransitions.slideUp,
        ),
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
