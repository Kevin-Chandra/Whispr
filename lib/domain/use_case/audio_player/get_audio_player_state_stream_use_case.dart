import 'package:injectable/injectable.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class GetAudioPlayerStateStreamUseCase {
  GetAudioPlayerStateStreamUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Stream<AudioPlayerState>? call() {
    return _audioPlayerRepository.getPlayerStateStream();
  }
}
