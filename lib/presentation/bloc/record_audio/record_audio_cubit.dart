import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recorder_command.dart';
import 'package:whispr/domain/use_case/record_audio/cancel_audio_recorder_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_amplitude_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_state_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/open_microphone_app_settings_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/send_audio_recorder_command_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/start_audio_recorder_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/stop_audio_recorder_use_case.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_state.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioCubit extends Cubit<RecordAudioState> {
  RecordAudioCubit(bool startImmediately) : super(RecordAudioInitialState()) {
    _subscribeAudioRecorderState();

    if (startImmediately) {
      recordAudio();
    }
  }

  StreamSubscription<double>? _levelSub;
  StreamSubscription<AudioRecorderState>? _recorderStateSub;

  final StreamController<double?> _levelController =
      StreamController<double?>();

  Stream<double?> get levels => _levelController.stream;

  Future<void> recordAudio() async {
    safeEmit(RecordAudioLoadingState());

    final response = await di.get<StartAudioRecorderUseCase>().call();
    response.fold((success) {
      safeEmit(RecordAudioInitialState());
    }, (failure) {
      safeEmit(RecordAudioErrorState(error: failure));
    });
  }

  void pauseRecording() {
    di.get<SendAudioRecorderCommandUseCase>().call(AudioRecorderCommand.pause);
  }

  void resumeRecording() {
    di.get<SendAudioRecorderCommandUseCase>().call(AudioRecorderCommand.resume);
  }

  void stopRecording() {
    di.get<StopAudioRecorderUseCase>().call();
  }

  void cancelRecording() {
    di.get<CancelAudioRecorderUseCase>().call();
  }

  void openMicrophoneAppSettings() {
    di.get<OpenMicrophoneAppSettingsUseCase>().call();
  }

  void pauseResumeRecording() {
    if (state is RecordAudioRecordingState) {
      pauseRecording();
    } else if (state is RecordAudioPausedState) {
      resumeRecording();
    }
  }

  void resetState() {
    safeEmit(RecordAudioInitialState());
  }

  void _subscribeAudioRecorderState() {
    final stream = di.get<GetAudioRecorderStateUseCase>().call();
    _recorderStateSub = stream.listen((state) {
      switch (state) {
        case AudioRecorderState.initial:
        case AudioRecorderState.initialized:
          _stopVisualizer();
          safeEmit(RecordAudioInitialState());
          break;
        case AudioRecorderState.loading:
          _stopVisualizer();
          safeEmit(RecordAudioLoadingState());
          break;
        case AudioRecorderState.started:
          _subscribeRecorderAmplitude();
          safeEmit(RecordAudioRecordingState());
          break;
        case AudioRecorderState.paused:
          _stopVisualizer();
          safeEmit(RecordAudioPausedState());
          break;
      }
    });
  }

  void _subscribeRecorderAmplitude() {
    _levelSub =
        di.get<GetAudioRecorderAmplitudeUseCase>().call().listen((amplitude) {
      _levelController.add(amplitude);
    });
  }

  void _stopVisualizer() {
    _levelSub?.cancel();
    _levelController.add(null);
  }

  @override
  Future<void> close() {
    stopRecording();
    _stopVisualizer();
    _levelController.close();
    _recorderStateSub?.cancel();
    return super.close();
  }
}
