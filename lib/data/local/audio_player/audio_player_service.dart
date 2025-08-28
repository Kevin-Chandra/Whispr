import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:whispr/data/local/audio_player/audio_player_exception.dart';
import 'package:whispr/data/local/file_service.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/data/models/service_failure_model.dart';

@singleton
class AudioPlayerService {
  final FileService _fileService;
  StreamController<AudioPlayerState>? _audioPlayerStateStreamController;
  AudioPlayer? _player;

  AudioPlayerService(this._fileService);

  Future<Either<Duration?, ServiceFailureModel>> initPlayer(
    String filePath,
  ) async {
    // Stop any ongoing player if new play is requested.
    await stop();

    // Check if file exist.
    if (!(await _fileService.isFileExist(filePath))) {
      return right(ServiceFailureModel(
        message: 'File not found!',
        serviceException: AudioFileNotFoundException(),
      ));
    }

    _audioPlayerStateStreamController = StreamController();
    _player = AudioPlayer();
    final duration = await _player!.setFilePath(filePath);
    _subscribePlayerState();

    return left(duration);
  }

  void play() {
    _player?.play();
  }

  void resume() {
    play();
  }

  Future<void> pause() async {
    await _player?.pause();
  }

  Future<void> stop() async {
    await _player?.stop();
    _reset();
  }

  Stream<AudioPlayerState>? getPlayerStateStream() {
    return _audioPlayerStateStreamController?.stream;
  }

  Stream<Duration>? getPlayerPositionStream() {
    return _player?.positionStream;
  }

  void _reset() {
    _audioPlayerStateStreamController?.add(AudioPlayerState.stopped);
    _player?.dispose();
    _player = null;
    _audioPlayerStateStreamController?.close();
    _audioPlayerStateStreamController = null;
  }

  void _subscribePlayerState() async {
    _player?.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _reset();
      } else if (state.playing) {
        _audioPlayerStateStreamController?.add(AudioPlayerState.playing);
      } else {
        _audioPlayerStateStreamController?.add(AudioPlayerState.paused);
      }
    });
  }
}
