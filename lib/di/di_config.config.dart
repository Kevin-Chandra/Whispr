// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/adapters.dart' as _i170;
import 'package:injectable/injectable.dart' as _i526;
import 'package:whispr/data/local/audio_player/audio_player_service.dart'
    as _i392;
import 'package:whispr/data/local/file_service.dart' as _i13;
import 'package:whispr/data/local/hive/hive_db.dart' as _i1032;
import 'package:whispr/data/local/record_audio_service.dart' as _i883;
import 'package:whispr/data/models/audio_recording_model.dart' as _i708;
import 'package:whispr/data/repository/audio_player_repository_impl.dart'
    as _i146;
import 'package:whispr/data/repository/audio_recording_repository_impl.dart'
    as _i1020;
import 'package:whispr/data/repository/record_audio_repository_impl.dart'
    as _i962;
import 'package:whispr/di/app_module.dart' as _i96;
import 'package:whispr/domain/repository/audio_player_repository.dart' as _i480;
import 'package:whispr/domain/repository/audio_recording_repository.dart'
    as _i383;
import 'package:whispr/domain/repository/record_audio_repository.dart' as _i241;
import 'package:whispr/domain/use_case/audio_player/get_audio_player_position_stream_use_case.dart'
    as _i120;
import 'package:whispr/domain/use_case/audio_player/get_audio_player_state_stream_use_case.dart'
    as _i147;
import 'package:whispr/domain/use_case/audio_player/play_audio_use_case.dart'
    as _i379;
import 'package:whispr/domain/use_case/audio_player/send_audio_player_command_use_case.dart'
    as _i653;
import 'package:whispr/domain/use_case/audio_recordings/get_all_recordings_use_case.dart'
    as _i579;
import 'package:whispr/domain/use_case/audio_recordings/save_recording_use_case.dart'
    as _i549;
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_state_use_case.dart'
    as _i825;
import 'package:whispr/domain/use_case/record_audio/open_microphone_app_settings_use_case.dart'
    as _i703;
import 'package:whispr/domain/use_case/record_audio/send_audio_recorder_command_use_case.dart'
    as _i79;
import 'package:whispr/domain/use_case/record_audio/start_audio_recorder_use_case.dart'
    as _i72;
import 'package:whispr/domain/use_case/record_audio/stop_audio_recorder_use_case.dart'
    as _i711;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => appModule.secureStorage,
      preResolve: true,
    );
    gh.factory<_i13.FileService>(() => _i13.FileService());
    gh.singleton<_i883.RecordAudioService>(() => _i883.RecordAudioService());
    gh.singleton<_i392.AudioPlayerService>(
        () => _i392.AudioPlayerService(gh<_i13.FileService>()));
    gh.factory<_i383.AudioRecordingRepository>(() =>
        _i1020.AudioRecordingRepositoryImpl(
            gh<_i170.Box<_i708.AudioRecordingModel>>()));
    gh.singleton<_i241.RecordAudioRepository>(
        () => _i962.RecordAudioRepositoryImpl(
              gh<_i883.RecordAudioService>(),
              gh<_i13.FileService>(),
            ));
    gh.factory<_i711.StopAudioRecorderUseCase>(() =>
        _i711.StopAudioRecorderUseCase(gh<_i241.RecordAudioRepository>()));
    gh.factory<_i72.StartAudioRecorderUseCase>(() =>
        _i72.StartAudioRecorderUseCase(gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i703.OpenMicrophoneAppSettingsUseCase>(() =>
        _i703.OpenMicrophoneAppSettingsUseCase(
            gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i825.GetAudioRecorderStateUseCase>(() =>
        _i825.GetAudioRecorderStateUseCase(gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i79.SendAudioRecorderCommandUseCase>(() =>
        _i79.SendAudioRecorderCommandUseCase(
            gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i1032.HiveLocalStorage>(() => _i1032.HiveLocalStorage(
          gh<_i558.FlutterSecureStorage>(),
          gh<_i13.FileService>(),
        ));
    gh.singleton<_i480.AudioPlayerRepository>(
        () => _i146.AudioPlayerRepositoryImpl(gh<_i392.AudioPlayerService>()));
    gh.factory<_i579.GetAllRecordingsUseCase>(() =>
        _i579.GetAllRecordingsUseCase(gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i549.SaveRecordingUseCase>(
        () => _i549.SaveRecordingUseCase(gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i653.SendAudioPlayerCommandUseCase>(() =>
        _i653.SendAudioPlayerCommandUseCase(gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i120.GetAudioPlayerPositionStreamUseCase>(() =>
        _i120.GetAudioPlayerPositionStreamUseCase(
            gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i147.GetAudioPlayerStateStreamUseCase>(() =>
        _i147.GetAudioPlayerStateStreamUseCase(
            gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i379.PlayAudioUseCase>(
        () => _i379.PlayAudioUseCase(gh<_i480.AudioPlayerRepository>()));
    return this;
  }
}

class _$AppModule extends _i96.AppModule {}
