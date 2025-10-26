part of 'app_lock_cubit.dart';

sealed class AppLockState extends Equatable {
  const AppLockState();

  @override
  List<Object> get props => [];
}

final class IdleState extends AppLockState {}

final class AuthenticatedState extends AppLockState {}

final class ErrorState extends AppLockState {
  const ErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
