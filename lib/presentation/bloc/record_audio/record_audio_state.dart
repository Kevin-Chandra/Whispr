import 'package:equatable/equatable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

sealed class RecordAudioState extends Equatable {
  const RecordAudioState();

  @override
  List<Object?> get props => [];
}

final class RecordAudioInitialState extends RecordAudioState {
  const RecordAudioInitialState();
}

final class RecordAudioPausedState extends RecordAudioState {
  const RecordAudioPausedState();
}

final class RecordAudioRecordingState extends RecordAudioState {
  const RecordAudioRecordingState();
}

final class RecordAudioLoadingState extends RecordAudioState {
  const RecordAudioLoadingState();
}

class RecordAudioErrorState extends RecordAudioState {
  const RecordAudioErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object?> get props => [error];
}
