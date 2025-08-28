import 'package:dartz/dartz.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class AudioPlayerRepository {
  Future<void> receiveCommand(AudioPlayerCommand command);

  Future<Either<Duration?, FailureEntity>> startAndPlay(String filePath);

  Stream<Duration>? getPlayerDurationStream();

  Stream<AudioPlayerState>? getAudioPlayerStateStream();
}
