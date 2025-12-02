part of 'recording_count_cubit.dart';

sealed class RecordingCountState extends Equatable {
  const RecordingCountState();

  @override
  List<Object?> get props => [];
}

final class RecordingCountLoading extends RecordingCountState {}

final class RecordingCountLoaded extends RecordingCountState {
  final int count;

  const RecordingCountLoaded(this.count);

  @override
  List<Object?> get props => [count];
}
