import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_all_recordings_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/save_recording_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'audio_recordings_state.dart';

class AudioRecordingsCubit extends Cubit<AudioRecordingsState> {
  AudioRecordingsCubit() : super(AudioRecordingsInitialState()) {
    _subscribeAudioRecordings();
  }

  StreamSubscription? _sub;

  void addRecording() async {
    final response =
        await di.get<SaveRecordingUseCase>().call(AudioRecording.mock());
  }

  void _subscribeAudioRecordings() async {
    _sub = di.get<GetAllRecordingsUseCase>().call().listen((x) {
      safeEmit(AudioRecordingsLoadedState(x));
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
