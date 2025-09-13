import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:whispr/data/local/audio_recorder/record_audio_exception.dart';
import 'package:whispr/data/local/timer/timer_service.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/data/models/service_failure_model.dart';

@singleton
class RecordAudioService {
  final StreamController<AudioRecorderState>
      _audioRecorderStateStreamController =
      StreamController<AudioRecorderState>.broadcast();

  AudioRecorder? _audioRecorder;
  AudioRecorderState _audioRecorderState = AudioRecorderState.initial;
  TimerService _timerService = TimerService();

  Stream<Duration> get recordingTimerStream => _timerService.timerStream;

  Stream<AudioRecorderState> get audioRecorderStateStream =>
      _audioRecorderStateStreamController.stream;

  Stream<Amplitude> getAudioRecorderAmplitude(Duration interval) {
    return _audioRecorder?.onAmplitudeChanged(interval) ?? Stream.empty();
  }

  Future<Either<void, ServiceFailureModel>> init() async {
    _setState(AudioRecorderState.initial);

    var status = await Permission.microphone.request();

    if (status.isDenied) {
      return right(ServiceFailureModel.empty(
          serviceException: MicrophonePermissionDenied()));
    }

    if (status.isPermanentlyDenied) {
      return right(ServiceFailureModel.empty(
          serviceException: MicrophonePermissionDeniedForever()));
    }

    _setState(AudioRecorderState.initialized);
    return left(null);
  }

  Future<Either<bool, ServiceFailureModel>> startRecord(String path) async {
    if (_audioRecorder != null && await _audioRecorder?.isRecording() == true) {
      return right(ServiceFailureModel(
          message: 'Recording is currently running!', serviceException: null));
    }

    final response = await init();
    if (response.isRight()) {
      return right(response.getOrElse(ServiceFailureModel.empty));
    }

    if (_audioRecorderState != AudioRecorderState.initialized) {
      _setState(AudioRecorderState.initial);
      return right(ServiceFailureModel(
          message: 'Recording is currently running!', serviceException: null));
    }
    _setState(AudioRecorderState.loading);

    _timerService = TimerService();
    _audioRecorder = AudioRecorder();

    final config = RecordConfig();

    await _audioRecorder?.start(config, path: path);
    _timerService.start();

    _setState(AudioRecorderState.started);
    return left(true);
  }

  Future<Either<String, ServiceFailureModel>> stopRecord() async {
    if (_audioRecorderState != AudioRecorderState.started &&
        _audioRecorderState != AudioRecorderState.paused) {
      return right(ServiceFailureModel(
          message: "No audio recording is running", serviceException: null));
    }

    final path = await _audioRecorder?.stop();
    _timerService.dispose();
    _audioRecorder?.dispose();
    _audioRecorder = null;
    _setState(AudioRecorderState.initial);
    return left(path ?? '');
  }

  Future<Either<bool, ServiceFailureModel>> cancelRecord() async {
    if (_audioRecorderState != AudioRecorderState.started &&
        _audioRecorderState != AudioRecorderState.paused) {
      return right(ServiceFailureModel(
          message: "No audio recording is running", serviceException: null));
    }

    await _audioRecorder?.cancel();
    _timerService.dispose();
    _audioRecorder?.dispose();
    _audioRecorder = null;
    _setState(AudioRecorderState.initial);
    return left(true);
  }

  void pauseRecord() async {
    if (_audioRecorderState != AudioRecorderState.started) {
      return;
    }

    await _audioRecorder?.pause();
    _timerService.pause();

    _setState(AudioRecorderState.paused);
  }

  void resumeRecord() async {
    if (_audioRecorderState != AudioRecorderState.paused) {
      return;
    }

    await _audioRecorder?.resume();
    _timerService.start();

    _setState(AudioRecorderState.started);
  }

  void openAppPermissionSettings() async => await openAppSettings();

  void _setState(AudioRecorderState state) {
    _audioRecorderState = state;
    _audioRecorderStateStreamController.add(_audioRecorderState);
  }
}
