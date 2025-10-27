part of 'journal_cubit.dart';

sealed class JournalState extends Equatable {
  const JournalState();

  @override
  List<Object> get props => [];
}

final class JournalLoadingState extends JournalState {}

final class JournalDeleteSuccessState extends JournalState {}

final class JournalAddToFavouriteSuccessState extends JournalState {}

final class JournalLoadedState extends JournalState {
  const JournalLoadedState(this.audioRecordings);

  final List<AudioRecording> audioRecordings;

  @override
  List<Object> get props => [audioRecordings];
}

final class JournalErrorState extends JournalState {
  const JournalErrorState(this.error);

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
