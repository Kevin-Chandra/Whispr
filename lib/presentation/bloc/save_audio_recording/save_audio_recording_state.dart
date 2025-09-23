part of 'save_audio_recording_cubit.dart';

sealed class SaveAudioRecordingState extends Equatable {
  const SaveAudioRecordingState();

  @override
  List<Object> get props => [];
}

final class SaveAudioRecordingInitialState extends SaveAudioRecordingState {}

final class SaveAudioRecordingLoadingState extends SaveAudioRecordingState {}

final class SaveAudioRecordingSuccessState extends SaveAudioRecordingState {}

final class SaveAudioRecordingCancelledState extends SaveAudioRecordingState {}

final class SaveAudioRecordingErrorState extends SaveAudioRecordingState {
  const SaveAudioRecordingErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
