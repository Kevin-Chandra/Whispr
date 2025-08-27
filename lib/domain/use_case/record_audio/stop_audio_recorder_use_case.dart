import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@injectable
class StopAudioRecorderUseCase {
  StopAudioRecorderUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Future<Either<String, FailureEntity>> call() {
    return _recordAudioRepository.stopRecording();
  }
}
