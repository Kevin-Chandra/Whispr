import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';

class WhisprDialog extends StatelessWidget {
  const WhisprDialog({
    super.key,
    required this.title,
    required this.confirmText,
    required this.onConfirmPressed,
    this.icon,
    this.message,
    this.dismissText,
    this.onDismissPressed,
    this.isNegativeAction = false,
  });

  ///
  /// A generic dialog for Atlas app.
  ///
  /// Usage: Show this dialog by using [context.showAtlasDialog()]
  /// * [isNegativeAction] to set negative dialog style.
  /// * [dismissText] to show dismiss button.
  ///

  final String title;
  final String? message;
  final String confirmText;
  final String? dismissText;
  final VoidCallback? onDismissPressed;
  final VoidCallback onConfirmPressed;
  final bool isNegativeAction;
  final IconData? icon;

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
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Icon(
                      icon,
                      size: 50,
                      color: isNegativeAction
                          ? WhisprColors.crayola
                          : WhisprColors.lavenderBlue,
                    ),
                  )
                : const SizedBox(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: WhisprTextStyles.heading4
                  .copyWith(color: WhisprColors.spanishViolet),
            ),
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
            LayoutBuilder(
              builder: (context, constraint) {
                final width = constraint.maxWidth;
                // Width threshold to prevent button from overflowing.
                if (width >= 250) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (dismissText != null)
                        Expanded(
                          child: _buildDismissButton(dismissText!),
                        ),
                      SizedBox(
                        width: dismissText != null ? 16 : 0,
                      ),
                      Expanded(child: _buildConfirmButton()),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (dismissText != null)
                        _buildDismissButton(dismissText!),
                      if (dismissText != null)
                        const SizedBox(
                          height: 4,
                        ),
                      _buildConfirmButton(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDismissButton(String buttonText) {
    return WhisprGradientButton(
      text: buttonText,
      onPressed: onDismissPressed,
      buttonStyle: WhisprGradientButtonStyle.outlined,
      buttonSize: WhisprButtonSizes.small,
    );
  }

  Widget _buildConfirmButton() {
    return isNegativeAction
        ? WhisprButton(
            text: confirmText,
            buttonStyle: WhisprButtonStyle.negativeFilled,
            buttonSize: WhisprButtonSizes.small,
            onPressed: onConfirmPressed,
          )
        : WhisprGradientButton(
            text: confirmText,
            onPressed: onConfirmPressed,
            buttonStyle: WhisprGradientButtonStyle.filled,
            buttonSize: WhisprButtonSizes.small,
            gradient:
                WhisprGradient.blueMagentaVioletInterdimensionalBlueGradient,
          );
  }

  ///
  /// Method that will display an [WhisprDialog].
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
