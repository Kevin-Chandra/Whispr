import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class SendAudioPlayerCommandUseCase {
  SendAudioPlayerCommandUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call(AudioPlayerCommand command) {
    return _audioPlayerRepository.receiveCommand(command);
  }
}
