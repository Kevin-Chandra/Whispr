import 'package:equatable/equatable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

sealed class RecordAudioState extends Equatable {
  const RecordAudioState();

  @override
  List<Object?> get props => [];
}

final class RecordAudioInitialState extends RecordAudioState {}

final class RecordAudioSaveSuccessState extends RecordAudioState {
  const RecordAudioSaveSuccessState({required this.audioPath});

  final String audioPath;

  @override
  List<Object?> get props => [audioPath];
}

final class RecordAudioPausedState extends RecordAudioState {}

final class RecordAudioRecordingState extends RecordAudioState {}

final class RecordAudioLoadingState extends RecordAudioState {}

final class RecordAudioCancelledState extends RecordAudioState {}

class RecordAudioErrorState extends RecordAudioState {
  const RecordAudioErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object?> get props => [error];
}
