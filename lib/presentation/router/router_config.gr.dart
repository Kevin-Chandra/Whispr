// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:whispr/presentation/screens/app_lock/app_inactive_screen.dart'
    as _i1;
import 'package:whispr/presentation/screens/app_lock/app_locked_screen.dart'
    as _i2;
import 'package:whispr/presentation/screens/edit_recording/edit_recording_screen.dart'
    as _i3;
import 'package:whispr/presentation/screens/favourite/favourite_screen.dart'
    as _i4;
import 'package:whispr/presentation/screens/home/home_screen.dart' as _i5;
import 'package:whispr/presentation/screens/journal/journal_screen.dart' as _i6;
import 'package:whispr/presentation/screens/onboarding/onboarding_screen.dart'
    as _i7;
import 'package:whispr/presentation/screens/record_audio/record_audio_screen.dart'
    as _i8;
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_screen.dart'
    as _i9;
import 'package:whispr/presentation/screens/settings/settings_screen.dart'
    as _i10;
import 'package:whispr/presentation/screens/voice_record_home/voice_record_home_screen.dart'
    as _i11;

/// generated route for
/// [_i1.AppInactiveScreen]
class AppInactiveRoute extends _i12.PageRouteInfo<void> {
  const AppInactiveRoute({List<_i12.PageRouteInfo>? children})
      : super(AppInactiveRoute.name, initialChildren: children);

  static const String name = 'AppInactiveRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppInactiveScreen();
    },
  );
}

/// generated route for
/// [_i2.AppLockedScreen]
class AppLockedRoute extends _i12.PageRouteInfo<void> {
  const AppLockedRoute({List<_i12.PageRouteInfo>? children})
      : super(AppLockedRoute.name, initialChildren: children);

  static const String name = 'AppLockedRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppLockedScreen();
    },
  );
}

/// generated route for
/// [_i3.EditRecordingScreen]
class EditRecordingRoute extends _i12.PageRouteInfo<EditRecordingRouteArgs> {
  EditRecordingRoute({
    _i13.Key? key,
    required String audioRecordingId,
    List<_i12.PageRouteInfo>? children,
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

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EditRecordingRouteArgs>(
        orElse: () => EditRecordingRouteArgs(
          audioRecordingId: pathParams.getString('audioRecordingId'),
        ),
      );
      return _i12.WrappedRoute(
        child: _i3.EditRecordingScreen(
          key: args.key,
          audioRecordingId: args.audioRecordingId,
        ),
      );
    },
  );
}

class EditRecordingRouteArgs {
  const EditRecordingRouteArgs({this.key, required this.audioRecordingId});

  final _i13.Key? key;

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
/// [_i4.FavouriteScreen]
class FavouriteRoute extends _i12.PageRouteInfo<void> {
  const FavouriteRoute({List<_i12.PageRouteInfo>? children})
      : super(FavouriteRoute.name, initialChildren: children);

  static const String name = 'FavouriteRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.FavouriteScreen();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i5.HomeScreen());
    },
  );
}

/// generated route for
/// [_i6.JournalScreen]
class JournalRoute extends _i12.PageRouteInfo<void> {
  const JournalRoute({List<_i12.PageRouteInfo>? children})
      : super(JournalRoute.name, initialChildren: children);

  static const String name = 'JournalRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.JournalScreen();
    },
  );
}

/// generated route for
/// [_i7.OnboardingScreen]
class OnboardingRoute extends _i12.PageRouteInfo<void> {
  const OnboardingRoute({List<_i12.PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i7.OnboardingScreen());
    },
  );
}

/// generated route for
/// [_i8.RecordAudioScreen]
class RecordAudioRoute extends _i12.PageRouteInfo<RecordAudioRouteArgs> {
  RecordAudioRoute({
    _i13.Key? key,
    required bool startImmediately,
    List<_i12.PageRouteInfo>? children,
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

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RecordAudioRouteArgs>(
        orElse: () => RecordAudioRouteArgs(
          startImmediately: pathParams.getBool('startImmediately'),
        ),
      );
      return _i12.WrappedRoute(
        child: _i8.RecordAudioScreen(
          key: args.key,
          startImmediately: args.startImmediately,
        ),
      );
    },
  );
}

class RecordAudioRouteArgs {
  const RecordAudioRouteArgs({this.key, required this.startImmediately});

  final _i13.Key? key;

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
/// [_i9.SaveAudioRecordingScreen]
class SaveAudioRecordingRoute
    extends _i12.PageRouteInfo<SaveAudioRecordingRouteArgs> {
  SaveAudioRecordingRoute({
    _i13.Key? key,
    required String audioRecordingPath,
    List<_i12.PageRouteInfo>? children,
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

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SaveAudioRecordingRouteArgs>(
        orElse: () => SaveAudioRecordingRouteArgs(
          audioRecordingPath: pathParams.getString('audioRecordingPath'),
        ),
      );
      return _i12.WrappedRoute(
        child: _i9.SaveAudioRecordingScreen(
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

  final _i13.Key? key;

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
/// [_i10.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i10.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i11.VoiceRecordHomeScreen]
class VoiceRecordHomeRoute extends _i12.PageRouteInfo<void> {
  const VoiceRecordHomeRoute({List<_i12.PageRouteInfo>? children})
      : super(VoiceRecordHomeRoute.name, initialChildren: children);

  static const String name = 'VoiceRecordHomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.VoiceRecordHomeScreen();
    },
  );
}
