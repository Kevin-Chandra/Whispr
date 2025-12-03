part of 'restore_cubit.dart';

sealed class RestoreState extends Equatable {
  const RestoreState();

  @override
  List<Object?> get props => [];
}

final class IdleState extends RestoreState {
  const IdleState({this.file});

  final File? file;

  @override
  List<Object?> get props => [file];
}

final class RestoreLoadingState extends RestoreState {}

final class RestoreSuccessState extends RestoreState {}

final class RestoreErrorState extends RestoreState {
  const RestoreErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object?> get props => [error];
}
