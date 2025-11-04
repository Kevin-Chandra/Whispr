part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class IdleState extends SettingsState {}

final class SettingsChangedState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  const SettingsErrorState({required this.error});

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
