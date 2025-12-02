import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/util/extensions.dart';

class WhisprLoadingDialog extends StatelessWidget {
  const WhisprLoadingDialog({
    super.key,
    required this.title,
    this.message,
    this.dismissText,
    this.onDismissPressed,
  });

  ///
  /// A loading dialog.
  ///

  final String title;
  final String? message;
  final String? dismissText;
  final VoidCallback? onDismissPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: WhisprTextStyles.heading4
                  .copyWith(color: WhisprColors.spanishViolet),
            ),
            const SizedBox(height: 16),
            CircularProgressIndicator(),
            const SizedBox(height: 16),
            if (message != null)
              Column(
                children: [
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: WhisprTextStyles.bodyM.copyWith(
                      color: WhisprColors.cosmicCobalt,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            if (dismissText.isNotNullOrEmpty)
              WhisprGradientButton(
                text: dismissText!,
                onPressed: onDismissPressed,
                buttonStyle: WhisprGradientButtonStyle.filled,
                buttonSize: WhisprButtonSizes.small,
              )
          ],
        ),
      ),
    );
  }

  ///
  /// Method that will display an [WhisprLoadingDialog].
  /// [onDismissOutside] can be set to false to prevent dismissing the dialog
  /// by tapping outside or using the system back button.
  ///
  /// Note: Setting [onDismissOutside] to false will prevent normal
  ///       router [maybePop] navigation, and can only be dismissed
  ///       using [Navigator] pop by using [NavigationCoordinator.navigatorPop].
  ///
  Future<T?> show<T>({
    required BuildContext context,
    bool onDismissOutside = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: onDismissOutside,
      builder: (BuildContext context) {
        return PopScope(
          // Will prevent system button dismiss as well.
          canPop: onDismissOutside,
          child: this,
        );
      },
    );
  }
}
