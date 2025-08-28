import 'package:flutter/material.dart';
import 'package:whispr/data/local/record_audio_exception.dart';
import 'package:whispr/util/extensions.dart';

extension RecordAudioExceptionUtil on RecordAudioException {
  String toLocalisedRecordAudioTitle(BuildContext context) => switch (this) {
        MicrophonePermissionDenied() =>
          context.strings.microphonePermissionDeniedTitle,
        MicrophonePermissionDeniedForever() =>
          context.strings.microphonePermissionDeniedForeverTitle,
      };

  String? toLocalisedRecordAudioDescription(BuildContext context) =>
      switch (this) {
        MicrophonePermissionDenied() =>
          context.strings.microphonePermissionDeniedMessage,
        MicrophonePermissionDeniedForever() =>
          context.strings.microphonePermissionDeniedForeverMessage,
      };

  String primaryButtonLabel(BuildContext context) => switch (this) {
        MicrophonePermissionDenied() => context.strings.allow,
        MicrophonePermissionDeniedForever() => context.strings.goToSettings,
      };

  bool requiresShortcutToAppSettings() =>
      this is MicrophonePermissionDeniedForever;

  bool requiresPermissionRetry() => this is MicrophonePermissionDenied;
}
