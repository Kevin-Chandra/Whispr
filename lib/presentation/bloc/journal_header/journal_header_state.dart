part of 'journal_header_cubit.dart';

sealed class JournalHeaderState extends Equatable {
  const JournalHeaderState();

  @override
  List<Object> get props => [];
}

final class JournalHeaderLoadingState extends JournalHeaderState {}

final class JournalHeaderLoadedState extends JournalHeaderState {
  const JournalHeaderLoadedState(
    this.audioRecordingDates,
    this.firstAudioRecordingDate,
  );

  final List<DateTime> audioRecordingDates;
  final DateTime firstAudioRecordingDate;

  @override
  List<Object> get props => [firstAudioRecordingDate, audioRecordingDates];
}

final class JournalHeaderErrorState extends JournalHeaderState {
  const JournalHeaderErrorState(this.error);

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
