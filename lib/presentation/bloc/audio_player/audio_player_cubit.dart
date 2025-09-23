import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/audio_player/get_audio_player_position_stream_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/get_audio_player_state_stream_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/play_audio_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/send_audio_player_command_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'audio_player_screen_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerScreenState> {
  AudioPlayerCubit()
      : super(AudioPlayerScreenInitial(
          AudioPlayerState.idle,
          Duration.zero,
          Duration.zero,
        ));

  StreamSubscription? _audioPlayerStateSubscription;
  StreamSubscription? _audioPlayerPositionSubscription;

  void playAudio() async {
    final response = await di.get<PlayAudioUseCase>().call(
        "/data/user/0/com.xenon.whispr/app_flutter/audio_recordings/audio_recording_20250828_123210.m4a");

    subscribePlayerPosition();
    subscribePlayerState();

    response.fold((duration) {
      safeEmit(AudioPlayerScreenInitial(
          state.playerState, state.playerPosition, duration ?? Duration.zero));
    }, (error) {
      safeEmit(AudioPlayerScreenError(
          state.playerState, state.playerPosition, state.totalDuration, error));
    });
  }

  void pause() {
    di.get<SendAudioPlayerCommandUseCase>().call(AudioPlayerCommand.pause);
  }

  void resume() {
    di.get<SendAudioPlayerCommandUseCase>().call(AudioPlayerCommand.resume);
  }

  void stop() {
    di.get<SendAudioPlayerCommandUseCase>().call(AudioPlayerCommand.stop);
  }

  void subscribePlayerState() {
    _audioPlayerStateSubscription?.cancel();
    _audioPlayerStateSubscription = di
        .get<GetAudioPlayerStateStreamUseCase>()
        .call()
        ?.listen((playerState) {
      if (playerState == AudioPlayerState.stopped) {
        _closeSubscription();
      }

      safeEmit(AudioPlayerScreenInitial(
          playerState, state.playerPosition, state.totalDuration));
    });
  }

  void subscribePlayerPosition() {
    _audioPlayerPositionSubscription?.cancel();
    _audioPlayerPositionSubscription = di
        .get<GetAudioPlayerPositionStreamUseCase>()
        .call()
        ?.listen((position) {
      safeEmit(AudioPlayerScreenInitial(
          state.playerState, position, state.totalDuration));
    });
  }

  Future<void> _closeSubscription() async {
    await _audioPlayerPositionSubscription?.cancel();
    await _audioPlayerStateSubscription?.cancel();
  }

  @override
  Future<void> close() async {
    await _closeSubscription();
    return super.close();
  }
}
