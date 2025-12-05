import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class GetWaveformExtractionProgressUseCase {
  GetWaveformExtractionProgressUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Stream<double?> call() {
    return _audioPlayerRepository.getWaveformExtractionProgressStream();
  }
}
