import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@singleton
class GetAudioRecorderAmplitudeUseCase {
  ///
  /// A use case to get stream of current audio recording amplitude.
  ///
  GetAudioRecorderAmplitudeUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Stream<double> call() {
    return _recordAudioRepository.getAudioRecorderAmplitudeStream();
  }
}
