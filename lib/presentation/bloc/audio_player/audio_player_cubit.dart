import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_player_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/audio_player/get_audio_player_position_stream_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/get_audio_player_state_stream_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/get_audio_wave_form_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/get_waveform_extraction_progress_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/prepare_audio_use_case.dart';
import 'package:whispr/domain/use_case/audio_player/send_audio_player_command_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'audio_player_screen_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerScreenState> {
  AudioPlayerCubit()
      : super(AudioPlayerInitialState(AudioPlayerState.idle, null));

  // Audio player state.
  StreamSubscription? _audioPlayerStateSubscription;

  // Audio player position.
  final _audioPlayerPositionStreamController =
      StreamController<Duration>.broadcast();

  Stream<Duration> get position => _audioPlayerPositionStreamController.stream;
  StreamSubscription? _audioPlayerPositionSubscription;

  StreamSubscription<double?>? _waveformExtractionProgressSubscription;

  String? _currentPlayingFile;

  // Prepare the audio to be play and also constructs audio waveform.
  void prepareAudio(
    String file, {
    bool playImmediately = false,
    bool extractWaveForm = false,
    int? noOfSamples,
  }) async {
    _currentPlayingFile = file;
    safeEmit(AudioPlayerLoadingState(state.state, getCurrentPlayingFile()));

    final response = await di
        .get<PrepareAudioUseCase>()
        .call(file, playImmediately: playImmediately);

    subscribePlayerPosition();
    subscribePlayerState();

    response.fold((controller) async {
      if (!extractWaveForm) {
        safeEmit(
          AudioPlayerLoadedState(
            state.state,
            getCurrentPlayingFile(),
            controller: controller,
            waveform: [],
          ),
        );
        return;
      }

      subscribeExtractionProgress();
      final waveformResponse = await di.get<GetAudioWaveFormUseCase>().call(
            file,
            noOfSamples: noOfSamples,
          );
      waveformResponse.fold((waveform) {
        safeEmit(
          AudioPlayerLoadedState(
            state.state,
            getCurrentPlayingFile(),
            controller: controller,
            waveform: waveform,
          ),
        );
      }, (error) {
        safeEmit(AudioPlayerScreenError(
            state.state, getCurrentPlayingFile(), error));
      });
    }, (error) {
      safeEmit(AudioPlayerScreenError(
        state.state,
        getCurrentPlayingFile(),
        error,
      ));
    });
  }

  void play() {
    di.get<SendAudioPlayerCommandUseCase>().call(AudioPlayerCommand.play);
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
      safeEmit(state.copyWith(playerState, getCurrentPlayingFile()));
    });
  }

  void subscribePlayerPosition() {
    _audioPlayerPositionSubscription?.cancel();
    _audioPlayerPositionSubscription = di
        .get<GetAudioPlayerPositionStreamUseCase>()
        .call()
        ?.listen((position) {
      _audioPlayerPositionStreamController.add(position);
    });
  }

  void subscribeExtractionProgress() {
    _waveformExtractionProgressSubscription?.cancel();
    _waveformExtractionProgressSubscription = di
        .get<GetWaveformExtractionProgressUseCase>()
        .call()
        .listen((progress) {
      safeEmit(AudioPlayerLoadingState(
        state.state,
        getCurrentPlayingFile(),
        progress: progress,
      ));
    });
  }

  String? getCurrentPlayingFile() => _currentPlayingFile;

  Future<void> _closeSubscription() async {
    await _audioPlayerPositionSubscription?.cancel();
    await _audioPlayerStateSubscription?.cancel();
    await _waveformExtractionProgressSubscription?.cancel();
  }

  @override
  Future<void> close() async {
    _currentPlayingFile = null;
    stop();
    await _closeSubscription();
    return super.close();
  }
}
