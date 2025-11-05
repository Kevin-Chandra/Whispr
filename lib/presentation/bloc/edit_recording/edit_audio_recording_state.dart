part of 'edit_audio_recording_cubit.dart';

sealed class EditAudioRecordingState extends Equatable {
  const EditAudioRecordingState();

  @override
  List<Object> get props => [];
}

final class EditAudioRecordingInitialState extends EditAudioRecordingState {}

final class EditAudioRecordingLoadingState extends EditAudioRecordingState {}

final class UpdateAudioRecordingSuccessState extends EditAudioRecordingState {}

final class EditAudioRecordingLoadedState extends EditAudioRecordingState {
  const EditAudioRecordingLoadedState({required this.audioRecording});

  final AudioRecording audioRecording;

  @override
  List<Object> get props => [audioRecording];
}

final class EditAudioRecordingErrorState extends EditAudioRecordingState {
  const EditAudioRecordingErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
