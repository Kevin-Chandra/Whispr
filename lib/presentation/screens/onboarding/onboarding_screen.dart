import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whispr/presentation/bloc/onboarding/onboarding_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/onboarding/onboarding_body.dart';
import 'package:whispr/presentation/screens/onboarding/onboarding_skeleton_loading.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget implements AutoRouteWrapper {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: this,
    );
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingCubit _onboardingCubit;

  @override
  void initState() {
    super.initState();
    _onboardingCubit = context.read<OnboardingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (ctx, state) {
        if (state is OnboardingCompletedState) {
          NavigationCoordinator.navigateHomeFromOnboarding(context: ctx);
          return;
        }
        if (state is OnboardingInitialState) {
          FlutterNativeSplash.remove();
          return;
        }
      },
      buildWhen: (prev, current) => current is! OnboardingCompletedState,
      builder: (ctx, state) {
        return switch (state) {
          OnboardingInitialState() => OnboardingBody(
              onGetStartedClick: () => _onboardingCubit.completeOnboarding(),
            ),
          OnboardingLoadingState() => const OnboardingSkeletonLoading(),
          _ => SizedBox()
        };
      },
    );
  }
}
