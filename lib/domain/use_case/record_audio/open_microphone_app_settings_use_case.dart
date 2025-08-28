import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@singleton
class OpenMicrophoneAppSettingsUseCase {
  OpenMicrophoneAppSettingsUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  void call() => _recordAudioRepository.openAppSettings();
}
