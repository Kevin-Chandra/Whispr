part of 'audio_recordings_cubit.dart';

sealed class AudioRecordingsState extends Equatable {
  const AudioRecordingsState();

  @override
  List<Object> get props => [];
}

final class AudioRecordingsInitialState extends AudioRecordingsState {}

final class AudioRecordingsLoadingState extends AudioRecordingsState {}

final class AudioRecordingsLoadedState extends AudioRecordingsState {
  const AudioRecordingsLoadedState(this.audioRecordings);

  final List<AudioRecording> audioRecordings;

  @override
  List<Object> get props => [audioRecordings];
}
