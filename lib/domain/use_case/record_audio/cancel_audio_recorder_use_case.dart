import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@injectable
class CancelAudioRecorderUseCase {
  ///
  /// A use case to stop and delete current audio recording.
  ///
  CancelAudioRecorderUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Future<Either<bool, FailureEntity>> call() {
    return _recordAudioRepository.cancelRecording();
  }
}
