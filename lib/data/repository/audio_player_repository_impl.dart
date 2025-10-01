import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/audio_player/audio_player_waveform_service.dart';
import 'package:whispr/data/mappers/failure_mapper.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_player_repository.dart';

@Singleton(as: AudioPlayerRepository)
class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl(this._audioPlayerService);

  final AudioPlayerWaveformService _audioPlayerService;

  @override
  Future<void> receiveCommand(AudioPlayerCommand command) async {
    switch (command) {
      case AudioPlayerCommand.play:
        {
          _audioPlayerService.play();
        }
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
  Future<Either<PlayerController, FailureEntity>> prepare(
    String filePath, {
    bool playImmediately = false,
  }) async {
    final response = await _audioPlayerService.initPlayer(filePath);

    return response.fold((controller) async {
      if (playImmediately) {
        _audioPlayerService.play();
      }

      return left(controller);
    }, (failure) {
      return right(failure.mapToDomain());
    });
  }

  @override
  Stream<Duration>? getPlayerPositionStream() =>
      _audioPlayerService.getPlayerPositionStream();

  @override
  Stream<AudioPlayerState>? getPlayerStateStream() =>
      _audioPlayerService.getPlayerStateStream();

  @override
  Future<Either<List<double>, FailureEntity>> getAudioWaveform(
    String filePath, {
    int? noOfSamples,
  }) async {
    final response = await _audioPlayerService.getWaveFormData(filePath,
        noOfSamples: noOfSamples);
    return response.fold((waveform) {
      return left(waveform);
    }, (failure) {
      return right(failure.mapToDomain());
    });
  }

  @override
  String? getCurrentPlayingFile() =>
      _audioPlayerService.getCurrentPlayingFile();
}
