import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@singleton
class GetAudioRecorderTimerUseCase {
  ///
  /// A use case to get stream of current audio recording timer.
  ///
  GetAudioRecorderTimerUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Stream<Duration> call() {
    return _recordAudioRepository.getAudioRecorderTimerStream();
  }
}
