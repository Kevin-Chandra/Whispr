import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class PrepareAudioUseCase {
  PrepareAudioUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<Either<PlayerController, FailureEntity>> call(
    String filePath, {
    bool playImmediately = false,
  }) {
    return _audioPlayerRepository.prepare(filePath,
        playImmediately: playImmediately);
  }
}
