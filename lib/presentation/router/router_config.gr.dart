// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:whispr/presentation/screens/home/home_screen.dart' as _i1;
import 'package:whispr/presentation/screens/record_audio/record_audio_screen.dart'
    as _i2;
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_screen.dart'
    as _i3;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i4.WrappedRoute(child: const _i1.HomeScreen());
    },
  );
}

/// generated route for
/// [_i2.RecordAudioScreen]
class RecordAudioRoute extends _i4.PageRouteInfo<RecordAudioRouteArgs> {
  RecordAudioRoute({
    _i5.Key? key,
    required bool startImmediately,
    List<_i4.PageRouteInfo>? children,
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

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RecordAudioRouteArgs>(
        orElse: () => RecordAudioRouteArgs(
          startImmediately: pathParams.getBool('startImmediately'),
        ),
      );
      return _i4.WrappedRoute(
        child: _i2.RecordAudioScreen(
          key: args.key,
          startImmediately: args.startImmediately,
        ),
      );
    },
  );
}

class RecordAudioRouteArgs {
  const RecordAudioRouteArgs({this.key, required this.startImmediately});

  final _i5.Key? key;

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
/// [_i3.SaveAudioRecordingScreen]
class SaveAudioRecordingRoute
    extends _i4.PageRouteInfo<SaveAudioRecordingRouteArgs> {
  SaveAudioRecordingRoute({
    _i5.Key? key,
    required String audioRecordingPath,
    List<_i4.PageRouteInfo>? children,
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

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SaveAudioRecordingRouteArgs>(
        orElse: () => SaveAudioRecordingRouteArgs(
          audioRecordingPath: pathParams.getString('audioRecordingPath'),
        ),
      );
      return _i4.WrappedRoute(
        child: _i3.SaveAudioRecordingScreen(
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

  final _i5.Key? key;

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
