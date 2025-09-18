import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:whispr/presentation/themes/themes.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_util.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_text.dart';

class WhisprGradientButton extends StatelessWidget {
  ///
  /// Generic Whispr Gradient Button
  ///
  /// Usage: This button can represent an
  ///     outlined gradient button by using [WhisprGradientButtonStyle.outlined],
  ///     filled gradient button by using [WhisprGradientButtonStyle.filled],
  ///
  /// * With different size presets [WhisprButtonSizes] in [buttonSize].
  /// * Along with an optional [icon] with a preferred alignment [iconAlignment].
  /// * The "disable" button state can be achieved when the [onPressed] callback is null.
  /// * The gradient can be customized with [gradient].
  ///
  const WhisprGradientButton({
    super.key,
    required this.text,
    required this.buttonStyle,
    required this.buttonSize,
    this.onPressed,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.gradient = WhisprGradient.purplePinkGradient,
  });

  final String text;
  final Gradient gradient;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final WhisprGradientButtonStyle buttonStyle;
  final WhisprButtonSizes buttonSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _resolveBackgroundGradient(),
        border: GradientBoxBorder(
          width: _resolveBorderWidth(),
          gradient: _resolveGradient(),
        ),
        borderRadius: WhisprButtonUtil.resolveBorderRadius(),
      ),
      child: switch (buttonStyle) {
        WhisprGradientButtonStyle.outlined => OutlinedButton.icon(
            onPressed: onPressed,
            icon: _resolveGradientIcon(),
            iconAlignment: iconAlignment,
            label: WhisprGradientText(
              text: text,
              gradient: _resolveGradient(),
              style: WhisprButtonUtil.resolveTextStyle(buttonSize),
            ),
            style: _resolveButtonStyle(),
          ),
        WhisprGradientButtonStyle.filled => ElevatedButton.icon(
            onPressed: onPressed,
            icon: WhisprButtonUtil.resolveIcon(icon),
            iconAlignment: iconAlignment,
            label: Text(text),
            style: _resolveButtonStyle(),
          ),
      },
    );
  }

  /// Overriding the theme for specific button styles, as each have different sizes.
  ButtonStyle _resolveButtonStyle() {
    switch (buttonStyle) {
      case WhisprGradientButtonStyle.outlined:
        return WhisprThemes.outlinedButtonTheme.copyWith(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStatePropertyAll(_resolveOutlinedButtonSize()),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          side: WidgetStateProperty.all(BorderSide.none),
          backgroundColor:
              WidgetStateProperty.all(Colors.white.withValues(alpha: 0.5)),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize),
          ),
        );
      case WhisprGradientButtonStyle.filled:
        return WhisprThemes.filledButtonTheme.copyWith(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveButtonSize(buttonSize)),
          iconSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveIconSize(buttonSize)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize).copyWith(
              color: Colors.white,
            ),
          ),
        );
    }
  }

  // Border width for outline button.
  // Filled button has no border.
  double _resolveBorderWidth() => switch (buttonStyle) {
        WhisprGradientButtonStyle.outlined =>
          WhisprButtonUtil.outlineBorderWidth,
        WhisprGradientButtonStyle.filled => 0,
      };

  // Due to using container border in outline button, the size
  // has to be reduced to ensure button size consistency.
  Size _resolveOutlinedButtonSize() {
    final size = WhisprButtonUtil.resolveButtonSize(buttonSize);
    return Size(size.width - 2 * WhisprButtonUtil.outlineBorderWidth,
        size.height - 2 * WhisprButtonUtil.outlineBorderWidth);
  }

  GradientIcon? _resolveGradientIcon() => icon == null
      ? null
      : GradientIcon(
          icon: icon!,
          offset: Offset.zero,
          size: WhisprButtonUtil.resolveIconSize(buttonSize),
          gradient: _resolveGradient(),
        );

  Gradient _resolveGradient() =>
      onPressed == null ? gradient.withOpacity(0.5) : gradient;

  // Gradient for background color.
  Gradient? _resolveBackgroundGradient() => switch (buttonStyle) {
        WhisprGradientButtonStyle.outlined => null,
        WhisprGradientButtonStyle.filled => _resolveGradient(),
      };
}

/// Whispr gradient button types
enum WhisprGradientButtonStyle { outlined, filled }
