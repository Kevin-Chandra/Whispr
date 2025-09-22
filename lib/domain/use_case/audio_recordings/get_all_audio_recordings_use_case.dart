import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class GetAllAudioRecordingsUseCase {
  GetAllAudioRecordingsUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Stream<List<AudioRecording>> call() {
    return _audioRecordingRepository.getAllRecordings();
  }
}
