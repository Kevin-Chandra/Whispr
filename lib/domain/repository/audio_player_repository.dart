import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dartz/dartz.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class AudioPlayerRepository {
  Future<Either<PlayerController, FailureEntity>> prepare(
    String filePath, {
    bool playImmediately = false,
  });

  Future<void> receiveCommand(AudioPlayerCommand command);

  Stream<Duration>? getPlayerPositionStream();

  Stream<AudioPlayerState>? getPlayerStateStream();

  Stream<double?> getWaveformExtractionProgressStream();

  Future<Either<List<double>, FailureEntity>> getAudioWaveform(
    String filePath, {
    int? noOfSamples,
  });

  String? getCurrentPlayingFile();
}
