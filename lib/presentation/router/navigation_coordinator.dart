import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';

abstract class NavigationCoordinator {
  /// Navigation wrapper for Atlas navigation.
  /// Only use when navigation parameter is needed,
  /// or on special cases.
  /// otherwise use [context.router.pushNamed()] and
  /// [context.router.maybePop()]
  ///

  static void navigatorPop({required BuildContext context}) =>
      Navigator.pop(context);

  static void navigatorPopWithRefreshResult({required BuildContext context}) =>
      Navigator.pop(context, true);

  static Future<bool?> navigateToRecordAudio({
    required BuildContext context,
    required bool startImmediately,
  }) async {
    return await context.pushRoute<bool?>(
      RecordAudioRoute(startImmediately: startImmediately),
    );
  }

  static Future<bool?> navigateToSaveRecording({
    required BuildContext context,
    required String audioRecordingPath,
  }) async {
    return context.router.push<bool?>(
      SaveAudioRecordingRoute(
        audioRecordingPath: audioRecordingPath,
      ),
    );
  }

  static Future<void> navigateToJournalTab({
    required BuildContext context,
  }) async {
    await context.router.navigate(
      const HomeRoute(children: [JournalRoute()]),
    );
  }

  static Future<void> navigateToHomeTab({
    required BuildContext context,
  }) async {
    await context.router.navigate(
      const HomeRoute(children: [VoiceRecordHomeRoute()]),
    );
  }

  static Future<void> navigateHomeFromOnboarding({
    required BuildContext context,
  }) async {
    await context.router.replace(
      const HomeRoute(),
    );
  }
}
