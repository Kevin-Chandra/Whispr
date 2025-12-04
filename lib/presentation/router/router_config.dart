import 'package:auto_route/auto_route.dart';
import 'package:whispr/presentation/router/navigation_paths.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/navigation_transitions.dart';

@AutoRouterConfig()
class WhisprRouter extends RootStackRouter {
  WhisprRouter({required this.shouldShowOnboarding}) : super();

  final bool shouldShowOnboarding;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: shouldShowOnboarding,
          page: OnboardingRoute.page,
          path: WhisprNavigationPaths.onboardingPath,
          transitionsBuilder: NavigationTransitions.slideUpWithExit,
          duration: Duration(
            milliseconds: WhisprDuration.onboardingNavigationTransitionDuration,
          ),
        ),
        CustomRoute(
          initial: !shouldShowOnboarding,
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
        CustomRoute(
          page: EditRecordingRoute.page,
          path: WhisprNavigationPaths.saveAudioRecordingPath,
        ),
        CustomRoute(
          page: AppLockedRoute.page,
          path: WhisprNavigationPaths.lockedPath,
        ),
        CustomRoute(
          page: AppInactiveRoute.page,
          path: WhisprNavigationPaths.inactivePath,
          transitionsBuilder: TransitionsBuilders.noTransition,
          duration: Duration.zero,
        ),
        CustomRoute(
          page: BackupRoute.page,
          path: WhisprNavigationPaths.backupPath,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: RestoreRoute.page,
          path: WhisprNavigationPaths.restorePath,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: ClearAllDataRoute.page,
          path: WhisprNavigationPaths.clearAllDataPath,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
      ];
}
