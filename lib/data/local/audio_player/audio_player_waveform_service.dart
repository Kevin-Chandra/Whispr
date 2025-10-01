import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/audio_player/audio_player_exception.dart';
import 'package:whispr/data/local/file_service.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/data/models/service_failure_model.dart';

@singleton
class AudioPlayerWaveformService {
  final FileService _fileService;
  StreamController<AudioPlayerState>? _audioPlayerStateStreamController;
  PlayerController? _player;

  AudioPlayerWaveformService(this._fileService);

  String? _currentPlayingFile;

  Future<Either<PlayerController, ServiceFailureModel>> initPlayer(
    String filePath,
  ) async {
    // Reset the player before initializing the new player.
    _reset();

    // Check if file exist.
    if (!(await _fileService.isFileExist(filePath))) {
      return right(ServiceFailureModel(
        message: 'File not found!',
        serviceException: AudioFileNotFoundException(),
      ));
    }

    _currentPlayingFile = filePath;

    // Init stream controller.
    _audioPlayerStateStreamController = StreamController();

    // Init player.
    _player = PlayerController();

    // Prepare audio file.
    await _player!.preparePlayer(path: filePath, shouldExtractWaveform: false);

    // Only set the finish mode after preparing the player.
    _player!.setFinishMode(finishMode: FinishMode.pause);

    // Subscribe to all streams related to audio player.
    _subscribePlayerState();

    return left(_player!);
  }

  Future<Either<List<double>, ServiceFailureModel>> getWaveFormData(
    String filePath, {
    int? noOfSamples,
  }) async {
    if (!(await _fileService.isFileExist(filePath))) {
      return right(ServiceFailureModel(
        message: 'File not found!',
        serviceException: AudioFileNotFoundException(),
      ));
    }

    final player = PlayerController();
    final waveform = await player.extractWaveformData(
      path: filePath,
      noOfSamples: noOfSamples ?? 100,
    );

    // Release all player resources.
    player.release();
    player.dispose();

    return left(waveform);
  }

  void play() async {
    _player?.startPlayer();
  }

  void resume() {
    play();
  }

  Future<void> pause() async {
    await _player?.pausePlayer();
  }

  Future<void> stop() async {
    await _player?.stopPlayer();
    _reset();
  }

  Stream<AudioPlayerState>? getPlayerStateStream() {
    return _audioPlayerStateStreamController?.stream;
  }

  Stream<Duration>? getPlayerPositionStream() {
    return _player?.onCurrentDurationChanged
        .map((duration) => Duration(milliseconds: duration));
  }

  String? getCurrentPlayingFile() {
    return _currentPlayingFile;
  }

  void _reset() {
    _currentPlayingFile = null;
    _audioPlayerStateStreamController?.add(AudioPlayerState.stopped);
    _player?.stopAllPlayers();
    _player?.release();
    _player?.dispose();
    _player = null;
    _audioPlayerStateStreamController?.close();
    _audioPlayerStateStreamController = null;
  }

  void _subscribePlayerState() async {
    _player?.onPlayerStateChanged.listen((state) {
      switch (state) {
        case PlayerState.initialized:
          break;
        case PlayerState.playing:
          _audioPlayerStateStreamController?.add(AudioPlayerState.playing);
          break;
        case PlayerState.paused:
          _audioPlayerStateStreamController?.add(AudioPlayerState.paused);
          break;
        case PlayerState.stopped:
          _currentPlayingFile = null;
          _audioPlayerStateStreamController?.add(AudioPlayerState.stopped);
          break;
      }
    });
  }
}
