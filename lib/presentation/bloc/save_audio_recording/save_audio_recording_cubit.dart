import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/use_case/audio_recordings/delete_audio_recording_file_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/save_audio_recording_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'save_audio_recording_state.dart';

class SaveAudioRecordingCubit extends Cubit<SaveAudioRecordingState> {
  SaveAudioRecordingCubit(this._filePath)
      : super(SaveAudioRecordingInitialState());

  final String _filePath;
  List<RecordingTag> _selectedTags = [];
  Mood _selectedMood = Mood.values.first;

  void moodSelected(Mood mood) {
    _selectedMood = mood;
  }

  void tagChanged(List<RecordingTag> tags) {
    _selectedTags = List.from(tags);
  }

  void cancelSaveRecording() async {
    safeEmit(SaveAudioRecordingLoadingState());
    final response = await di
        .get<DeleteAudioRecordingFileUseCase>()
        .call(filePath: _filePath);

    return response.fold((success) {
      safeEmit(SaveAudioRecordingCancelledState());
    }, (error) {
      safeEmit(SaveAudioRecordingErrorState(error: error));
    });
  }

  void saveAudioRecording({
    required String name,
    required Duration duration,
    List<double>? waveformData,
  }) async {
    safeEmit(SaveAudioRecordingLoadingState());

    final response = await di.get<SaveAudioRecordingUseCase>().call(
          name: name,
          filePath: _filePath,
          mood: _selectedMood,
          tags: _selectedTags,
          isFavourite: false,
          duration: duration,
          waveformData: waveformData,
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
