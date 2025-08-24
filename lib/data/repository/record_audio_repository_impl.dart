import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/record_audio_service.dart';
import 'package:whispr/data/mappers/failure_mapper.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@Injectable(as: RecordAudioRepository)
class RecordAudioRepositoryImpl extends RecordAudioRepository {
  RecordAudioRepositoryImpl(this._recordAudioService);

  final RecordAudioService _recordAudioService;

  @override
  Future<Either<void, FailureEntity>> requestMicrophonePermission() async {
    final response = await _recordAudioService.init();
    return response.fold((permissionGranted) {
      return const Left(null);
    }, (failure) {
      return Right(failure.mapToDomain());
    });
  }

  @override
  void openAppSettings() => _recordAudioService.openAppPermissionSettings();
}
