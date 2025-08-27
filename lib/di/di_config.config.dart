// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:whispr/data/local/file_service.dart' as _i13;
import 'package:whispr/data/local/record_audio_service.dart' as _i883;
import 'package:whispr/data/repository/record_audio_repository_impl.dart'
    as _i962;
import 'package:whispr/domain/repository/record_audio_repository.dart' as _i241;
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
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i13.FileService>(() => _i13.FileService());
    gh.singleton<_i883.RecordAudioService>(() => _i883.RecordAudioService());
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
    return this;
  }
}
