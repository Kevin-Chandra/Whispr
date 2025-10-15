import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/use_case/settings/complete_onboarding_use_case.dart';
import 'package:whispr/domain/use_case/settings/get_has_completed_onboarding_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitialState()) {
    checkHasCompletedOnboarding();
  }

  void checkHasCompletedOnboarding() async {
    safeEmit(OnboardingLoadingState());
    final hasCompleted =
        await di.get<GetHasCompletedOnboardingUseCase>().call();

    if (hasCompleted) {
      safeEmit(OnboardingCompletedState());
    } else {
      safeEmit(OnboardingInitialState());
    }
  }

  void completeOnboarding() async {
    safeEmit(OnboardingLoadingState());

    await di.get<CompleteOnboardingUseCase>().call();
    checkHasCompletedOnboarding();
  }
}
