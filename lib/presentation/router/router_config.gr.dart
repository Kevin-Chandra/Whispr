// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:whispr/presentation/screens/app_lock/app_inactive_screen.dart'
    as _i1;
import 'package:whispr/presentation/screens/app_lock/app_locked_screen.dart'
    as _i2;
import 'package:whispr/presentation/screens/backup/backup_screen.dart' as _i3;
import 'package:whispr/presentation/screens/clear_all_data/clear_all_data_screen.dart'
    as _i4;
import 'package:whispr/presentation/screens/edit_recording/edit_recording_screen.dart'
    as _i5;
import 'package:whispr/presentation/screens/favourite/favourite_screen.dart'
    as _i6;
import 'package:whispr/presentation/screens/home/home_screen.dart' as _i7;
import 'package:whispr/presentation/screens/journal/journal_screen.dart' as _i8;
import 'package:whispr/presentation/screens/onboarding/onboarding_screen.dart'
    as _i9;
import 'package:whispr/presentation/screens/record_audio/record_audio_screen.dart'
    as _i10;
import 'package:whispr/presentation/screens/restore/restore_screen.dart'
    as _i11;
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_screen.dart'
    as _i12;
import 'package:whispr/presentation/screens/settings/settings_screen.dart'
    as _i13;
import 'package:whispr/presentation/screens/voice_record_home/voice_record_home_screen.dart'
    as _i14;

/// generated route for
/// [_i1.AppInactiveScreen]
class AppInactiveRoute extends _i15.PageRouteInfo<void> {
  const AppInactiveRoute({List<_i15.PageRouteInfo>? children})
      : super(AppInactiveRoute.name, initialChildren: children);

  static const String name = 'AppInactiveRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppInactiveScreen();
    },
  );
}

/// generated route for
/// [_i2.AppLockedScreen]
class AppLockedRoute extends _i15.PageRouteInfo<void> {
  const AppLockedRoute({List<_i15.PageRouteInfo>? children})
      : super(AppLockedRoute.name, initialChildren: children);

  static const String name = 'AppLockedRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppLockedScreen();
    },
  );
}

/// generated route for
/// [_i3.BackupScreen]
class BackupRoute extends _i15.PageRouteInfo<void> {
  const BackupRoute({List<_i15.PageRouteInfo>? children})
      : super(BackupRoute.name, initialChildren: children);

  static const String name = 'BackupRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i15.WrappedRoute(child: const _i3.BackupScreen());
    },
  );
}

/// generated route for
/// [_i4.ClearAllDataScreen]
class ClearAllDataRoute extends _i15.PageRouteInfo<void> {
  const ClearAllDataRoute({List<_i15.PageRouteInfo>? children})
      : super(ClearAllDataRoute.name, initialChildren: children);

  static const String name = 'ClearAllDataRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i15.WrappedRoute(child: const _i4.ClearAllDataScreen());
    },
  );
}

/// generated route for
/// [_i5.EditRecordingScreen]
class EditRecordingRoute extends _i15.PageRouteInfo<EditRecordingRouteArgs> {
  EditRecordingRoute({
    _i16.Key? key,
    required String audioRecordingId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          EditRecordingRoute.name,
          args: EditRecordingRouteArgs(
            key: key,
            audioRecordingId: audioRecordingId,
          ),
          rawPathParams: {'audioRecordingId': audioRecordingId},
          initialChildren: children,
        );

  static const String name = 'EditRecordingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EditRecordingRouteArgs>(
        orElse: () => EditRecordingRouteArgs(
          audioRecordingId: pathParams.getString('audioRecordingId'),
        ),
      );
      return _i15.WrappedRoute(
        child: _i5.EditRecordingScreen(
          key: args.key,
          audioRecordingId: args.audioRecordingId,
        ),
      );
    },
  );
}

class EditRecordingRouteArgs {
  const EditRecordingRouteArgs({this.key, required this.audioRecordingId});

  final _i16.Key? key;

  final String audioRecordingId;

  @override
  String toString() {
    return 'EditRecordingRouteArgs{key: $key, audioRecordingId: $audioRecordingId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditRecordingRouteArgs) return false;
    return key == other.key && audioRecordingId == other.audioRecordingId;
  }

  @override
  int get hashCode => key.hashCode ^ audioRecordingId.hashCode;
}

/// generated route for
/// [_i6.FavouriteScreen]
class FavouriteRoute extends _i15.PageRouteInfo<void> {
  const FavouriteRoute({List<_i15.PageRouteInfo>? children})
      : super(FavouriteRoute.name, initialChildren: children);

  static const String name = 'FavouriteRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.FavouriteScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i15.WrappedRoute(child: const _i7.HomeScreen());
    },
  );
}

/// generated route for
/// [_i8.JournalScreen]
class JournalRoute extends _i15.PageRouteInfo<void> {
  const JournalRoute({List<_i15.PageRouteInfo>? children})
      : super(JournalRoute.name, initialChildren: children);

  static const String name = 'JournalRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.JournalScreen();
    },
  );
}

/// generated route for
/// [_i9.OnboardingScreen]
class OnboardingRoute extends _i15.PageRouteInfo<void> {
  const OnboardingRoute({List<_i15.PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i15.WrappedRoute(child: const _i9.OnboardingScreen());
    },
  );
}

/// generated route for
/// [_i10.RecordAudioScreen]
class RecordAudioRoute extends _i15.PageRouteInfo<RecordAudioRouteArgs> {
  RecordAudioRoute({
    _i16.Key? key,
    required bool startImmediately,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          RecordAudioRoute.name,
          args: RecordAudioRouteArgs(
            key: key,
            startImmediately: startImmediately,
          ),
          rawPathParams: {'startImmediately': startImmediately},
          initialChildren: children,
        );

  static const String name = 'RecordAudioRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RecordAudioRouteArgs>(
        orElse: () => RecordAudioRouteArgs(
          startImmediately: pathParams.getBool('startImmediately'),
        ),
      );
      return _i15.WrappedRoute(
        child: _i10.RecordAudioScreen(
          key: args.key,
          startImmediately: args.startImmediately,
        ),
      );
    },
  );
}

class RecordAudioRouteArgs {
  const RecordAudioRouteArgs({this.key, required this.startImmediately});

  final _i16.Key? key;

  final bool startImmediately;

  @override
  String toString() {
    return 'RecordAudioRouteArgs{key: $key, startImmediately: $startImmediately}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecordAudioRouteArgs) return false;
    return key == other.key && startImmediately == other.startImmediately;
  }

  @override
  int get hashCode => key.hashCode ^ startImmediately.hashCode;
}

/// generated route for
/// [_i11.RestoreScreen]
class RestoreRoute extends _i15.PageRouteInfo<void> {
  const RestoreRoute({List<_i15.PageRouteInfo>? children})
      : super(RestoreRoute.name, initialChildren: children);

  static const String name = 'RestoreRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i15.WrappedRoute(child: const _i11.RestoreScreen());
    },
  );
}

/// generated route for
/// [_i12.SaveAudioRecordingScreen]
class SaveAudioRecordingRoute
    extends _i15.PageRouteInfo<SaveAudioRecordingRouteArgs> {
  SaveAudioRecordingRoute({
    _i16.Key? key,
    required String audioRecordingPath,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SaveAudioRecordingRoute.name,
          args: SaveAudioRecordingRouteArgs(
            key: key,
            audioRecordingPath: audioRecordingPath,
          ),
          rawPathParams: {'audioRecordingPath': audioRecordingPath},
          initialChildren: children,
        );

  static const String name = 'SaveAudioRecordingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SaveAudioRecordingRouteArgs>(
        orElse: () => SaveAudioRecordingRouteArgs(
          audioRecordingPath: pathParams.getString('audioRecordingPath'),
        ),
      );
      return _i15.WrappedRoute(
        child: _i12.SaveAudioRecordingScreen(
          key: args.key,
          audioRecordingPath: args.audioRecordingPath,
        ),
      );
    },
  );
}

class SaveAudioRecordingRouteArgs {
  const SaveAudioRecordingRouteArgs({
    this.key,
    required this.audioRecordingPath,
  });

  final _i16.Key? key;

  final String audioRecordingPath;

  @override
  String toString() {
    return 'SaveAudioRecordingRouteArgs{key: $key, audioRecordingPath: $audioRecordingPath}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SaveAudioRecordingRouteArgs) return false;
    return key == other.key && audioRecordingPath == other.audioRecordingPath;
  }

  @override
  int get hashCode => key.hashCode ^ audioRecordingPath.hashCode;
}

/// generated route for
/// [_i13.SettingsScreen]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return _i15.WrappedRoute(child: const _i13.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i14.VoiceRecordHomeScreen]
class VoiceRecordHomeRoute extends _i15.PageRouteInfo<void> {
  const VoiceRecordHomeRoute({List<_i15.PageRouteInfo>? children})
      : super(VoiceRecordHomeRoute.name, initialChildren: children);

  static const String name = 'VoiceRecordHomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.VoiceRecordHomeScreen();
    },
  );
}
