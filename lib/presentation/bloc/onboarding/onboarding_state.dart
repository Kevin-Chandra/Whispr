part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitialState extends OnboardingState {}

final class OnboardingLoadingState extends OnboardingState {}

final class OnboardingCompletedState extends OnboardingState {}
