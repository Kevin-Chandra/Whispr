import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    super.key,
    required this.onGetStartedClick,
  });

  final VoidCallback onGetStartedClick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.onboardingBgImage),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            Text(
              context.strings.whispr,
              style: WhisprTextStyles.bodyS.copyWith(
                color: WhisprColors.spanishViolet,
              ),
            ),
            Text(
              context.strings.onboardingTitle,
              style: WhisprTextStyles.heading1.copyWith(
                color: WhisprColors.spanishViolet,
              ),
            ),
            Text(
              context.strings.onboardingMessage,
              style: WhisprTextStyles.bodyM.copyWith(
                color: WhisprColors.spanishViolet,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            WhisprGradientButton(
              text: context.strings.getStarted,
              gradient:
                  WhisprGradient.blueMagentaVioletInterdimensionalBlueGradient,
              buttonStyle: WhisprGradientButtonStyle.filled,
              buttonSize: WhisprButtonSizes.medium,
              onPressed: onGetStartedClick,
            ),
          ],
        ),
      ),
    );
  }
}
