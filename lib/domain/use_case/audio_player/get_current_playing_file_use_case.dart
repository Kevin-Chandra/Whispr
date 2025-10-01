import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class GetCurrentPlayingFileUseCase {
  GetCurrentPlayingFileUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  String? call() => _audioPlayerRepository.getCurrentPlayingFile();
}
