import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/onboarding/onboarding_body.dart';

class OnboardingSkeletonLoading extends StatelessWidget {
  const OnboardingSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: OnboardingBody(
        onGetStartedClick: () {},
      ),
    );
  }
}
