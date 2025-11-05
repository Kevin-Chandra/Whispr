import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/use_case/audio_recordings/get_audio_recording_by_id_use_case.dart';
import 'package:whispr/domain/use_case/audio_recordings/update_audio_recording_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'edit_audio_recording_state.dart';

class EditAudioRecordingCubit extends Cubit<EditAudioRecordingState> {
  EditAudioRecordingCubit(this.audioRecordingId)
      : super(EditAudioRecordingInitialState()) {
    getAudioRecording();
  }

  final String audioRecordingId;
  AudioRecording? currentAudioRecording;

  List<RecordingTag> _selectedTags = [];
  Mood _selectedMood = Mood.values.first;

  void moodSelected(Mood mood) {
    _selectedMood = mood;
  }

  void tagChanged(List<RecordingTag> tags) {
    _selectedTags = List.from(tags);
  }

  void getAudioRecording() async {
    safeEmit(EditAudioRecordingLoadingState());

    final response =
        await di.get<GetAudioRecordingByIdUseCase>().call(audioRecordingId);
    response.fold((recording) {
      _loadAudioRecording(recording);
      safeEmit(EditAudioRecordingLoadedState(audioRecording: recording));
    }, (error) {
      safeEmit(EditAudioRecordingErrorState(error: error));
    });
  }

  void updateAudioRecording(String title) async {
    safeEmit(EditAudioRecordingLoadingState());

    if (currentAudioRecording == null) {
      safeEmit(
        EditAudioRecordingErrorState(
          error: FailureEntity(error: 'Audio recording not loaded'),
        ),
      );
      return;
    }

    final response = await di.get<UpdateAudioRecordingUseCase>().call(
        currentAudioRecording: currentAudioRecording!,
        name: title,
        mood: _selectedMood,
        tags: _selectedTags);

    return response.fold((success) {
      safeEmit(UpdateAudioRecordingSuccessState());
    }, (error) {
      safeEmit(EditAudioRecordingErrorState(error: error));
    });
  }

  void _loadAudioRecording(AudioRecording audioRecording) {
    currentAudioRecording = audioRecording;
    _selectedTags = audioRecording.tags;
    _selectedMood = audioRecording.mood;
  }
}
