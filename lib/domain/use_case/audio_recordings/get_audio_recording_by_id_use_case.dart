import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class GetAudioRecordingByIdUseCase {
  GetAudioRecordingByIdUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<AudioRecording, FailureEntity>> call(String id) {
    return _audioRecordingRepository.getAudioRecordingById(id);
  }
}
