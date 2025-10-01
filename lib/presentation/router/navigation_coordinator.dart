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

  static Future<void> navigateToRecordAudio({
    required BuildContext context,
    required bool startImmediately,
  }) async {
    await context.pushRoute(
      RecordAudioRoute(startImmediately: startImmediately),
    );
    return;
  }

  static Future<void> navigateToSaveRecording({
    required BuildContext context,
    required String audioRecordingPath,
  }) async {
    navigatorPop(context: context);

    if (!context.mounted) return;

    await context.pushRoute(
      SaveAudioRecordingRoute(
        audioRecordingPath: audioRecordingPath,
      ),
    );
    return;
  }

  static Future<void> navigateToJournalTab({
    required BuildContext context,
  }) async {
    context.router.popUntilRoot();
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
}
