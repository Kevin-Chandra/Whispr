import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class GetAudioRecordingDatesUseCase {
  GetAudioRecordingDatesUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<List<DateTime>, FailureEntity>> call() {
    return _audioRecordingRepository.getRecordingDates();
  }
}
