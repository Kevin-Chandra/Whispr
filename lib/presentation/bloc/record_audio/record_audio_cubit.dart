import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recorder_command.dart';
import 'package:whispr/domain/use_case/record_audio/get_audio_recorder_state_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/open_microphone_app_settings_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/send_audio_recorder_command_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/start_audio_recorder_use_case.dart';
import 'package:whispr/domain/use_case/record_audio/stop_audio_recorder_use_case.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_state.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioCubit extends Cubit<RecordAudioState> {
  RecordAudioCubit()
      : super(RecordAudioInitialState(AudioRecorderState.initial)) {
    subscribeAudioRecorderState();
  }

  Future<void> recordAudio() async {
    safeEmit(RecordAudioLoadingState(state.audioRecorderState));

    final response = await di.get<StartAudioRecorderUseCase>().call();
    response.fold((success) {
      safeEmit(RecordAudioInitialState(state.audioRecorderState));
    }, (failure) {
      safeEmit(RecordAudioErrorState(state.audioRecorderState, error: failure));
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

  void subscribeAudioRecorderState() {
    final stream = di.get<GetAudioRecorderStateUseCase>().call();
    stream.listen((state) {
      safeEmit(RecordAudioInitialState(state));
    });
  }

  void openMicrophoneAppSettings() {
    di.get<OpenMicrophoneAppSettingsUseCase>().call();
  }

  void resetState() {
    safeEmit(RecordAudioInitialState(state.audioRecorderState));
  }
}
