import 'package:equatable/equatable.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class RecordAudioState extends Equatable {
  const RecordAudioState(this.audioRecorderState);

  final AudioRecorderState audioRecorderState;

  @override
  List<Object?> get props => [audioRecorderState];
}

final class RecordAudioInitialState extends RecordAudioState {
  const RecordAudioInitialState(super.audioRecorderState);
}

final class RecordAudioLoadingState extends RecordAudioState {
  const RecordAudioLoadingState(super.audioRecorderState);
}

class RecordAudioErrorState extends RecordAudioState {
  const RecordAudioErrorState(super.audioRecorderState, {required this.error});

  final FailureEntity error;

  @override
  List<Object?> get props => [error];
}
