import 'package:equatable/equatable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class RecordAudioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecordAudioInitialState extends RecordAudioState {}

class RecordAudioLoadingState extends RecordAudioState {}

class RecordingAudioState extends RecordAudioState {}

class RecordAudioErrorState extends RecordAudioState {
  RecordAudioErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object?> get props => [error];
}
