import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class GetAudioPlayerPositionStreamUseCase {
  GetAudioPlayerPositionStreamUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Stream<Duration>? call() {
    return _audioPlayerRepository.getPlayerDurationStream();
  }
}
