part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class IdleState extends HomeState {}

final class AppLockConfigLoadedState extends HomeState {}

final class RefreshAudioRecordings extends HomeState {}
