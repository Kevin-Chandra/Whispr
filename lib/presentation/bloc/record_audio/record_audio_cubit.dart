import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recorder_command.dart';
import 'package:whispr/domain/use_case/record_audio/cancel_audio_recorder_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_amplitude_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_state_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_timer_use_case.dart';
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

  StreamSubscription<AudioRecorderState>? _recorderStateSub;

  final StreamController<double?> _recorderAmplitudeStreamController =
      StreamController<double?>();

  Stream<double?> get levels => _recorderAmplitudeStreamController.stream;
  StreamSubscription<double>? _recordingAmplitudeSubscription;

  final StreamController<Duration> _recordingTimerController =
      StreamController<Duration>();

  Stream<Duration> get recordingTimer => _recordingTimerController.stream;
  StreamSubscription<Duration>? _recordingTimerSubscription;

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

  void stopRecording() async {
    final response = await di.get<StopAudioRecorderUseCase>().call();
    response.fold((audioFilePath) {
      safeEmit(RecordAudioSaveSuccessState(audioPath: audioFilePath));
    }, (failure) {
      safeEmit(RecordAudioErrorState(error: failure));
    });
  }

  void cancelRecording() async {
    final response = await di.get<CancelAudioRecorderUseCase>().call();
    response.fold((success) {
      safeEmit(RecordAudioCancelledState());
    }, (failure) {
      // This will show the error in the UI.
      safeEmit(RecordAudioErrorState(error: failure));

      // Emit `RecordAudioCancelledState` to always pop back
      // if the user cancels the recording.
      safeEmit(RecordAudioCancelledState());
    });
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
    _recorderStateSub =
        di.get<GetAudioRecorderStateUseCase>().call().listen((state) {
      switch (state) {
        case AudioRecorderState.initial:
        case AudioRecorderState.initialized:
          _stopAmplitudeSubscription();
          safeEmit(RecordAudioInitialState());
          break;
        case AudioRecorderState.loading:
          _stopAmplitudeSubscription();
          safeEmit(RecordAudioLoadingState());
          break;
        case AudioRecorderState.started:
          _subscribeRunningRecorder();
          safeEmit(RecordAudioRecordingState());
          break;
        case AudioRecorderState.paused:
          _stopAmplitudeSubscription();
          safeEmit(RecordAudioPausedState());
          break;
      }
    });
  }

  void _subscribeRunningRecorder() {
    _subscribeRecorderAmplitude();
    _subscribeRecorderTimer();
  }

  void _subscribeRecorderAmplitude() {
    _recordingAmplitudeSubscription =
        di.get<GetAudioRecorderAmplitudeUseCase>().call().listen((amplitude) {
      _recorderAmplitudeStreamController.add(amplitude);
    });
  }

  void _subscribeRecorderTimer() {
    _recordingTimerSubscription =
        di.get<GetAudioRecorderTimerUseCase>().call().listen((timer) {
      _recordingTimerController.add(timer);
    });
  }

  void _stopAmplitudeSubscription() {
    _recordingAmplitudeSubscription?.cancel();
    _recorderAmplitudeStreamController.add(null);
  }

  @override
  Future<void> close() {
    cancelRecording();
    _stopAmplitudeSubscription();
    _recorderAmplitudeStreamController.close();
    _recordingTimerController.close();
    _recordingTimerSubscription?.cancel();
    _recorderStateSub?.cancel();
    _recorderStateSub = null;
    return super.close();
  }
}
