import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/onboarding/onboarding_body.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return OnboardingBody(onGetStartedClick: () {
      NavigationCoordinator.navigateHomeFromOnboarding(context: context);
    });
  }
}
