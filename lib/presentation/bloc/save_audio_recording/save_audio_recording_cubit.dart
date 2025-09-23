import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/use_case/audio_recordings/delete_audio_recording_file_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/save_audio_recording_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'save_audio_recording_state.dart';

class SaveAudioRecordingCubit extends Cubit<SaveAudioRecordingState> {
  SaveAudioRecordingCubit(this.filePath)
      : super(SaveAudioRecordingInitialState());

  final String filePath;
  Mood _selectedMood = Mood.values.first;

  void moodSelected(Mood mood) {
    _selectedMood = mood;
  }

  void cancelSaveRecording() async {
    safeEmit(SaveAudioRecordingLoadingState());
    final response = await di
        .get<DeleteAudioRecordingFileUseCase>()
        .call(filePath: filePath);

    return response.fold((success) {
      safeEmit(SaveAudioRecordingCancelledState());
    }, (error) {
      safeEmit(SaveAudioRecordingErrorState(error: error));
    });
  }

  void saveAudioRecording({
    required String name,
    required List<String> tags,
  }) async {
    safeEmit(SaveAudioRecordingLoadingState());

    final response = await di.get<SaveAudioRecordingUseCase>().call(
          name: name,
          filePath: filePath,
          mood: _selectedMood,
          tags: tags,
        );

    return response.fold((success) {
      safeEmit(SaveAudioRecordingSuccessState());
    }, (error) {
      safeEmit(SaveAudioRecordingErrorState(error: error));
    });
  }

  void resetState() {
    safeEmit(SaveAudioRecordingInitialState());
  }
}
