import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class DeleteAudioRecordingUseCase {
  DeleteAudioRecordingUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<bool, FailureEntity>> call({required String audioRecordingId}) {
    return _audioRecordingRepository.deleteAudioRecording(audioRecordingId);
  }
}
