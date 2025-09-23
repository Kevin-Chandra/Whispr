import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/audio_player/audio_player_service.dart';
import 'package:whispr/data/mappers/failure_mapper.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@Singleton(as: AudioPlayerRepository)
class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerService);

  final AudioPlayerService _audioPlayerService;

  @override
  Future<void> receiveCommand(AudioPlayerCommand command) async {
    switch (command) {
      case AudioPlayerCommand.pause:
        {
          await _audioPlayerService.pause();
        }
      case AudioPlayerCommand.resume:
        {
          _audioPlayerService.resume();
        }
      case AudioPlayerCommand.stop:
        {
          await _audioPlayerService.stop();
        }
    }
  }

  @override
  Future<Either<Duration?, FailureEntity>> startAndPlay(String filePath) async {
    final response = await _audioPlayerService.initPlayer(filePath);

    return response.fold((d) async {
      _audioPlayerService.play();
      return left(d);
    }, (failure) {
      return right(failure.mapToDomain());
    });
  }

  @override
  Stream<Duration>? getPlayerDurationStream() =>
      _audioPlayerService.getPlayerPositionStream();

  @override
  Stream<AudioPlayerState>? getAudioPlayerStateStream() =>
      _audioPlayerService.getPlayerStateStream();
}
