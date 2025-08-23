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
import 'package:whispr/data/local/record_audio_service.dart' as _i883;
import 'package:whispr/data/repository/record_audio_repository_impl.dart'
    as _i962;
import 'package:whispr/domain/repository/record_audio_repository.dart' as _i241;
import 'package:whispr/domain/use_case/record_audio/request_microphone_access_use_case.dart'
    as _i28;

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
    gh.factory<_i883.RecordAudioService>(() => _i883.RecordAudioService());
    gh.factory<_i241.RecordAudioRepository>(
        () => _i962.RecordAudioRepositoryImpl(gh<_i883.RecordAudioService>()));
    gh.singleton<_i28.RequestMicrophoneAccessUseCase>(() =>
        _i28.RequestMicrophoneAccessUseCase(gh<_i241.RecordAudioRepository>()));
    return this;
  }
}
