import 'package:flutter/material.dart';
import 'package:whispr/presentation/icons/custom_icon.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/util/extensions.dart';

class AppLockBody extends StatelessWidget {
  const AppLockBody({super.key, this.onUnlockPressed});

  final VoidCallback? onUnlockPressed;

  @override
  Widget build(BuildContext context) {
    return WhisprGradientScaffold(
      gradient: WhisprGradient.whiteBlueWhiteGradient,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.strings.appLock,
            style: WhisprTextStyles.heading2
                .copyWith(color: WhisprColors.spanishViolet),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            context.strings.thisAppIsProtected,
            style: WhisprTextStyles.bodyS
                .copyWith(color: WhisprColors.spanishViolet),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48),
          Icon(
            CustomIcon.encrypted,
            size: 125,
            color: WhisprColors.lavenderBlue,
            shadows: [
              Shadow(
                color: WhisprColors.vistaBlue.withValues(alpha: 0.25),
                blurRadius: 15.0,
                // offset: Offset(3, 3),
              ),
            ],
          ),
          SizedBox(height: 56),
          FractionallySizedBox(
            widthFactor: 0.35,
            child: WhisprGradientButton(
              gradient:
                  WhisprGradient.blueMagentaVioletInterdimensionalBlueGradient,
              text: context.strings.unlock,
              buttonStyle: WhisprGradientButtonStyle.filled,
              buttonSize: WhisprButtonSizes.medium,
              onPressed: onUnlockPressed,
            ),
          )
        ],
      ),
    );
  }
}
