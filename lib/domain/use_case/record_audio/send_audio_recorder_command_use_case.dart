import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recorder_command.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@singleton
class SendAudioRecorderCommandUseCase {
  SendAudioRecorderCommandUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Future<void> call(AudioRecorderCommand command) {
    return _recordAudioRepository.sendCommand(command);
  }
}
