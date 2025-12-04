part of 'backup_cubit.dart';

sealed class BackupState extends Equatable {
  const BackupState();

  @override
  List<Object> get props => [];
}

final class IdleState extends BackupState {
  const IdleState({
    required this.recordingFirstDate,
    required this.startDate,
    required this.endDate,
  });

  final DateTime recordingFirstDate;
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object> get props => [
        recordingFirstDate,
        startDate,
        endDate,
      ];
}

final class BackupLoadingState extends BackupState {}

final class InitialLoadingState extends BackupState {}

final class BackupSuccessState extends BackupState {
  final File file;

  const BackupSuccessState({required this.file});

  @override
  List<Object> get props => [file];
}

final class BackupErrorState extends BackupState {
  const BackupErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
