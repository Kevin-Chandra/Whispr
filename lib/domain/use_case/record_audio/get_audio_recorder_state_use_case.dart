import 'package:injectable/injectable.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@singleton
class GetAudioRecorderStateUseCase {
  GetAudioRecorderStateUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Stream<AudioRecorderState> call() {
    return _recordAudioRepository.audioRecorderStateStream;
  }
}
