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
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:whispr/data/local/audio_player/audio_player_service.dart'
    as _i392;
import 'package:whispr/data/local/audio_player/audio_player_waveform_service.dart'
    as _i954;
import 'package:whispr/data/local/audio_recorder/record_audio_service.dart'
    as _i864;
import 'package:whispr/data/local/database/audio_recording_local_indexable_database.dart'
    as _i310;
import 'package:whispr/data/local/file_service.dart' as _i13;
import 'package:whispr/data/local/hive/hive_db.dart' as _i1032;
import 'package:whispr/data/local/local_auth/local_auth.dart' as _i737;
import 'package:whispr/data/models/audio_recording_model.dart' as _i708;
import 'package:whispr/data/models/recording_tag_model.dart' as _i337;
import 'package:whispr/data/repository/archive_repository_impl.dart' as _i1063;
import 'package:whispr/data/repository/audio_player_repository_impl.dart'
    as _i146;
import 'package:whispr/data/repository/audio_recording_repository_impl.dart'
    as _i1020;
import 'package:whispr/data/repository/local_authentication_repository_impl.dart'
    as _i9;
import 'package:whispr/data/repository/record_audio_repository_impl.dart'
    as _i962;
import 'package:whispr/data/repository/recording_tag_repository_impl.dart'
    as _i597;
import 'package:whispr/data/repository/settings_repository_impl.dart' as _i799;
import 'package:whispr/di/app_module.dart' as _i96;
import 'package:whispr/domain/repository/archive_repository.dart' as _i331;
import 'package:whispr/domain/repository/audio_player_repository.dart' as _i480;
import 'package:whispr/domain/repository/audio_recording_repository.dart'
    as _i383;
import 'package:whispr/domain/repository/local_authentication_repository.dart'
    as _i221;
import 'package:whispr/domain/repository/record_audio_repository.dart' as _i241;
import 'package:whispr/domain/repository/recording_tag_repository.dart'
    as _i878;
import 'package:whispr/domain/repository/settings_repository.dart' as _i266;
import 'package:whispr/domain/use_case/archive/backup_recordings_use_case.dart'
    as _i980;
import 'package:whispr/domain/use_case/archive/get_recent_backup_use_case.dart'
    as _i539;
import 'package:whispr/domain/use_case/archive/get_recording_count_use_case.dart'
    as _i97;
import 'package:whispr/domain/use_case/archive/restore_recordings_use_case.dart'
    as _i837;
import 'package:whispr/domain/use_case/archive/save_file_to_directory_use_case.dart'
    as _i393;
import 'package:whispr/domain/use_case/audio_player/get_audio_player_position_stream_use_case.dart'
    as _i120;
import 'package:whispr/domain/use_case/audio_player/get_audio_player_state_stream_use_case.dart'
    as _i147;
import 'package:whispr/domain/use_case/audio_player/get_audio_wave_form_use_case.dart'
    as _i667;
import 'package:whispr/domain/use_case/audio_player/get_current_playing_file_use_case.dart'
    as _i163;
import 'package:whispr/domain/use_case/audio_player/get_waveform_extraction_progress_use_case.dart'
    as _i505;
import 'package:whispr/domain/use_case/audio_player/prepare_audio_use_case.dart'
    as _i342;
import 'package:whispr/domain/use_case/audio_player/send_audio_player_command_use_case.dart'
    as _i653;
import 'package:whispr/domain/use_case/audio_recordings/add_or_remove_audio_recording_favourite_use_case.dart'
    as _i165;
import 'package:whispr/domain/use_case/audio_recordings/delete_audio_recording_file_use_case.dart'
    as _i428;
import 'package:whispr/domain/use_case/audio_recordings/delete_audio_recording_use_case.dart'
    as _i30;
import 'package:whispr/domain/use_case/audio_recordings/get_all_audio_recordings_use_case.dart'
    as _i489;
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recording_by_id_use_case.dart'
    as _i825;
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recording_dates_use_case.dart'
    as _i924;
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recordings_by_date_use_case.dart'
    as _i648;
import 'package:whispr/domain/use_case/audio_recordings/get_favourite_audio_recordings_use_case.dart'
    as _i209;
import 'package:whispr/domain/use_case/audio_recordings/get_recording_first_and_last_date_use_case.dart'
    as _i765;
import 'package:whispr/domain/use_case/audio_recordings/save_audio_recording_use_case.dart'
    as _i319;
import 'package:whispr/domain/use_case/audio_recordings/update_audio_recording_use_case.dart'
    as _i185;
import 'package:whispr/domain/use_case/local_auth/authenticate_local_auth_use_case.dart'
    as _i720;
import 'package:whispr/domain/use_case/local_auth/check_device_support_local_auth_use_case.dart'
    as _i612;
import 'package:whispr/domain/use_case/local_auth/open_lock_screen_settings_use_case.dart'
    as _i900;
import 'package:whispr/domain/use_case/record_audio/cancel_audio_recorder_use_case.dart'
    as _i410;
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_amplitude_use_case.dart'
    as _i874;
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_state_use_case.dart'
    as _i825;
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_timer_use_case.dart'
    as _i403;
import 'package:whispr/domain/use_case/record_audio/open_microphone_app_settings_use_case.dart'
    as _i703;
import 'package:whispr/domain/use_case/record_audio/send_audio_recorder_command_use_case.dart'
    as _i79;
import 'package:whispr/domain/use_case/record_audio/start_audio_recorder_use_case.dart'
    as _i72;
import 'package:whispr/domain/use_case/record_audio/stop_audio_recorder_use_case.dart'
    as _i711;
import 'package:whispr/domain/use_case/recording_tags/get_all_recording_tags_use_case.dart'
    as _i166;
import 'package:whispr/domain/use_case/recording_tags/save_recording_tag_use_case.dart'
    as _i898;
import 'package:whispr/domain/use_case/settings/clear_all_data_use_case.dart'
    as _i520;
import 'package:whispr/domain/use_case/settings/complete_onboarding_use_case.dart'
    as _i823;
import 'package:whispr/domain/use_case/settings/get_has_completed_onboarding_use_case.dart'
    as _i523;
import 'package:whispr/domain/use_case/settings/get_is_app_lock_enabled_use_case.dart'
    as _i1022;
import 'package:whispr/domain/use_case/settings/get_settings_value_use_case.dart'
    as _i1049;
import 'package:whispr/domain/use_case/settings/set_app_lock_use_case.dart'
    as _i405;

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
    await gh.factoryAsync<_i655.PackageInfo>(
      () => appModule.packageInfo,
      preResolve: true,
    );
    gh.factory<_i737.LocalAuth>(() => _i737.LocalAuth());
    gh.factory<_i13.FileService>(() => _i13.FileService());
    gh.factory<_i393.SaveFileToDirectoryUseCase>(
        () => const _i393.SaveFileToDirectoryUseCase());
    gh.factory<_i900.OpenLockScreenSettingsUseCase>(
        () => _i900.OpenLockScreenSettingsUseCase());
    gh.singleton<_i864.RecordAudioService>(() => _i864.RecordAudioService());
    gh.singleton<_i241.RecordAudioRepository>(
        () => _i962.RecordAudioRepositoryImpl(
              gh<_i864.RecordAudioService>(),
              gh<_i13.FileService>(),
            ));
    gh.singleton<_i954.AudioPlayerWaveformService>(
        () => _i954.AudioPlayerWaveformService(gh<_i13.FileService>()));
    gh.singleton<_i392.AudioPlayerService>(
        () => _i392.AudioPlayerService(gh<_i13.FileService>()));
    gh.factory<_i266.SettingsRepository>(() => _i799.SettingsRepositoryImpl(
        gh<_i170.Box<String>>(instanceName: 'SETTINGS_BOX_KEY')));
    gh.factory<_i1049.GetSettingsValueUseCase>(
        () => _i1049.GetSettingsValueUseCase(gh<_i266.SettingsRepository>()));
    gh.factory<_i523.GetHasCompletedOnboardingUseCase>(() =>
        _i523.GetHasCompletedOnboardingUseCase(gh<_i266.SettingsRepository>()));
    gh.factory<_i1022.GetIsAppLockEnabledUseCase>(() =>
        _i1022.GetIsAppLockEnabledUseCase(gh<_i266.SettingsRepository>()));
    gh.factory<_i823.CompleteOnboardingUseCase>(
        () => _i823.CompleteOnboardingUseCase(gh<_i266.SettingsRepository>()));
    gh.factory<_i878.RecordingTagRepository>(() =>
        _i597.RecordingTagRepositoryImpl(gh<_i170.Box<_i337.RecordingTagModel>>(
            instanceName: 'RECORDING_TAG_BOX_KEY')));
    gh.factory<_i711.StopAudioRecorderUseCase>(() =>
        _i711.StopAudioRecorderUseCase(gh<_i241.RecordAudioRepository>()));
    gh.factory<_i72.StartAudioRecorderUseCase>(() =>
        _i72.StartAudioRecorderUseCase(gh<_i241.RecordAudioRepository>()));
    gh.factory<_i410.CancelAudioRecorderUseCase>(() =>
        _i410.CancelAudioRecorderUseCase(gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i703.OpenMicrophoneAppSettingsUseCase>(() =>
        _i703.OpenMicrophoneAppSettingsUseCase(
            gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i825.GetAudioRecorderStateUseCase>(() =>
        _i825.GetAudioRecorderStateUseCase(gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i403.GetAudioRecorderTimerUseCase>(() =>
        _i403.GetAudioRecorderTimerUseCase(gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i79.SendAudioRecorderCommandUseCase>(() =>
        _i79.SendAudioRecorderCommandUseCase(
            gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i874.GetAudioRecorderAmplitudeUseCase>(() =>
        _i874.GetAudioRecorderAmplitudeUseCase(
            gh<_i241.RecordAudioRepository>()));
    gh.singleton<_i1032.HiveLocalStorage>(() => _i1032.HiveLocalStorage(
          gh<_i558.FlutterSecureStorage>(),
          gh<_i13.FileService>(),
        ));
    gh.factory<_i221.LocalAuthenticationRepository>(
        () => _i9.LocalAuthenticationRepositoryImpl(gh<_i737.LocalAuth>()));
    gh.factory<_i310.AudioRecordingLocalIndexableDatabase>(
        () => _i310.AudioRecordingLocalIndexableDatabase(
              gh<_i170.Box<_i708.AudioRecordingModel>>(
                  instanceName: 'AUDIO_RECORDING_BOX_KEY'),
              gh<_i170.Box<Set<String>>>(
                  instanceName: 'AUDIO_RECORDING_DATE_INDEX_BOX_KEY'),
              gh<_i170.Box<Set<String>>>(
                  instanceName: 'AUDIO_RECORDING_IS_FAVOURITE_INDEX_BOX_KEY'),
            ));
    gh.singleton<_i480.AudioPlayerRepository>(() =>
        _i146.AudioPlayerRepositoryImpl(
            gh<_i954.AudioPlayerWaveformService>()));
    gh.factory<_i383.AudioRecordingRepository>(
        () => _i1020.AudioRecordingRepositoryImpl(
              gh<_i310.AudioRecordingLocalIndexableDatabase>(),
              gh<_i13.FileService>(),
            ));
    gh.factory<_i898.SaveRecordingTagUseCase>(() =>
        _i898.SaveRecordingTagUseCase(gh<_i878.RecordingTagRepository>()));
    gh.factory<_i166.GetAllRecordingTagsUseCase>(() =>
        _i166.GetAllRecordingTagsUseCase(gh<_i878.RecordingTagRepository>()));
    gh.factory<_i331.ArchiveRepository>(() => _i1063.ArchiveRepositoryImpl(
          gh<_i170.Box<_i337.RecordingTagModel>>(
              instanceName: 'RECORDING_TAG_BOX_KEY'),
          gh<_i310.AudioRecordingLocalIndexableDatabase>(),
          gh<_i13.FileService>(),
        ));
    gh.factory<_i520.ClearAllDataUseCase>(() => _i520.ClearAllDataUseCase(
          gh<_i383.AudioRecordingRepository>(),
          gh<_i878.RecordingTagRepository>(),
          gh<_i331.ArchiveRepository>(),
        ));
    gh.factory<_i505.GetWaveformExtractionProgressUseCase>(() =>
        _i505.GetWaveformExtractionProgressUseCase(
            gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i653.SendAudioPlayerCommandUseCase>(() =>
        _i653.SendAudioPlayerCommandUseCase(gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i120.GetAudioPlayerPositionStreamUseCase>(() =>
        _i120.GetAudioPlayerPositionStreamUseCase(
            gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i147.GetAudioPlayerStateStreamUseCase>(() =>
        _i147.GetAudioPlayerStateStreamUseCase(
            gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i163.GetCurrentPlayingFileUseCase>(() =>
        _i163.GetCurrentPlayingFileUseCase(gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i342.PrepareAudioUseCase>(
        () => _i342.PrepareAudioUseCase(gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i667.GetAudioWaveFormUseCase>(
        () => _i667.GetAudioWaveFormUseCase(gh<_i480.AudioPlayerRepository>()));
    gh.factory<_i980.BackupRecordingsUseCase>(
        () => _i980.BackupRecordingsUseCase(gh<_i331.ArchiveRepository>()));
    gh.factory<_i837.RestoreRecordingsUseCase>(
        () => _i837.RestoreRecordingsUseCase(gh<_i331.ArchiveRepository>()));
    gh.factory<_i539.GetRecentBackupUseCase>(
        () => _i539.GetRecentBackupUseCase(gh<_i331.ArchiveRepository>()));
    gh.factory<_i97.GetRecordingCountUseCase>(
        () => _i97.GetRecordingCountUseCase(gh<_i331.ArchiveRepository>()));
    gh.factory<_i825.GetAudioRecordingByIdUseCase>(() =>
        _i825.GetAudioRecordingByIdUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i319.SaveAudioRecordingUseCase>(() =>
        _i319.SaveAudioRecordingUseCase(gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i209.GetFavouriteAudioRecordingsUseCase>(() =>
        _i209.GetFavouriteAudioRecordingsUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i648.GetAudioRecordingsByDateUseCase>(() =>
        _i648.GetAudioRecordingsByDateUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i489.GetAllAudioRecordingsUseCase>(() =>
        _i489.GetAllAudioRecordingsUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i30.DeleteAudioRecordingUseCase>(() =>
        _i30.DeleteAudioRecordingUseCase(gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i428.DeleteAudioRecordingFileUseCase>(() =>
        _i428.DeleteAudioRecordingFileUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i185.UpdateAudioRecordingUseCase>(() =>
        _i185.UpdateAudioRecordingUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i765.GetRecordingFirstAndLastDateUseCase>(() =>
        _i765.GetRecordingFirstAndLastDateUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i924.GetAudioRecordingDatesUseCase>(() =>
        _i924.GetAudioRecordingDatesUseCase(
            gh<_i383.AudioRecordingRepository>()));
    gh.factory<_i720.AuthenticateLocalAuthUseCase>(() =>
        _i720.AuthenticateLocalAuthUseCase(
            gh<_i221.LocalAuthenticationRepository>()));
    gh.factory<_i612.CheckDeviceSupportLocalAuthUseCase>(() =>
        _i612.CheckDeviceSupportLocalAuthUseCase(
            gh<_i221.LocalAuthenticationRepository>()));
    gh.factory<_i405.SetAppLockUseCase>(() => _i405.SetAppLockUseCase(
          gh<_i266.SettingsRepository>(),
          gh<_i720.AuthenticateLocalAuthUseCase>(),
        ));
    gh.factory<_i165.AddOrRemoveAudioRecordingFavouriteUseCase>(
        () => _i165.AddOrRemoveAudioRecordingFavouriteUseCase(
              gh<_i185.UpdateAudioRecordingUseCase>(),
              gh<_i825.GetAudioRecordingByIdUseCase>(),
            ));
    return this;
  }
}

class _$AppModule extends _i96.AppModule {}
