import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class GetAudioRecordingsByDateUseCase {
  GetAudioRecordingsByDateUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<List<AudioRecording>, FailureEntity>> call(DateTime date) {
    return _audioRecordingRepository.getRecordingsByDate(date);
  }
}
