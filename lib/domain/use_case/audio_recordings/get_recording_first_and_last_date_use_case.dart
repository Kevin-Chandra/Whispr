import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class GetRecordingFirstAndLastDateUseCase {
  ///
  /// A use case to get first and last date of recordings,
  /// returns null if no recording exist.
  ///
  GetRecordingFirstAndLastDateUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<(DateTime, DateTime)?> call() async {
    return _audioRecordingRepository.getRecordingFirstAndLastDate();
  }
}
