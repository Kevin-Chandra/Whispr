part of 'clear_all_data_cubit.dart';

sealed class ClearAllDataState extends Equatable {
  const ClearAllDataState();

  @override
  List<Object?> get props => [];
}

final class IdleState extends ClearAllDataState {
  const IdleState({this.file});

  final File? file;

  @override
  List<Object?> get props => [file];
}

final class ClearAllDataLoadingState extends ClearAllDataState {}

final class ClearAllDataSuccessState extends ClearAllDataState {}

final class ClearAllDataErrorState extends ClearAllDataState {
  const ClearAllDataErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object?> get props => [error];
}
