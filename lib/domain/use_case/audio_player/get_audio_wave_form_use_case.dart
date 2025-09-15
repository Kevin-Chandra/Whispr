import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@injectable
class GetAudioWaveFormUseCase {
  GetAudioWaveFormUseCase(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<Either<List<double>, FailureEntity>> call(String filePath) {
    return _audioPlayerRepository.getAudioWaveform(filePath);
  }
}
