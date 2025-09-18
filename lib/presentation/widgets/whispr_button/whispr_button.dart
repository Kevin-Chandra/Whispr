import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/themes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_util.dart';

class WhisprButton extends StatelessWidget {
  ///
  /// Generic Whispr Button
  ///
  /// Usage: This button can represent an
  ///     outlined button by using [WhisprButtonStyle.outlined],
  ///     filled button by using [WhisprButtonStyle.filled],
  ///     text button by using [WhisprButtonStyle.text],
  ///     negative button by using [WhisprButtonStyle.negativeFilled],
  ///     negative text by using [WhisprButtonStyle.negativeText].
  ///
  /// * With different size presets [WhisprButtonSizes] in [buttonSize].
  /// * Along with an optional [icon] with a preferred alignment [iconAlignment].
  /// * The "disable" button state can be achieved when the [onPressed] callback is null.
  ///
  const WhisprButton({
    super.key,
    required this.text,
    required this.buttonStyle,
    required this.buttonSize,
    this.onPressed,
    this.icon,
    this.iconAlignment = IconAlignment.start,
  });

  final String text;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final WhisprButtonStyle buttonStyle;
  final WhisprButtonSizes buttonSize;
  final VoidCallback? onPressed;

  static const _outlinedButtonColor = WhisprColors.cornflowerBlue;
  static const _filledButtonColor = WhisprColors.vodka;
  static const _textButtonColor = WhisprColors.vodka;
  static const _disabledColor = WhisprColors.lightGray;
  static const _negativeButtonColor = WhisprColors.crayola;
  static const _negativeDisabledButtonColor = WhisprColors.melon;

  @override
  Widget build(BuildContext context) {
    switch (buttonStyle) {
      case WhisprButtonStyle.outlined:
        return OutlinedButton.icon(
          onPressed: onPressed,
          icon: WhisprButtonUtil.resolveIcon(icon),
          iconAlignment: iconAlignment,
          label: Text(text),
          style: _resolveButtonStyle(),
        );
      case WhisprButtonStyle.filled:
      case WhisprButtonStyle.negativeFilled:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: WhisprButtonUtil.resolveIcon(icon),
          iconAlignment: iconAlignment,
          label: Text(text),
          style: _resolveButtonStyle(),
        );
      case WhisprButtonStyle.text:
      case WhisprButtonStyle.negativeText:
        return TextButton.icon(
          onPressed: onPressed,
          icon: WhisprButtonUtil.resolveIcon(icon),
          iconAlignment: iconAlignment,
          label: Text(text),
          style: _resolveButtonStyle(),
        );
    }
  }

  /// Overriding the theme for specific button styles, as each have different sizes and corner radii.
  /// Note: the [WhisprButtonStyle.filled] can have a different base color.
  ButtonStyle _resolveButtonStyle() {
    switch (buttonStyle) {
      case WhisprButtonStyle.outlined:
        return WhisprThemes.outlinedButtonTheme.copyWith(
          minimumSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveButtonSize(buttonSize)),
          iconSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveIconSize(buttonSize)),
          side: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return const BorderSide(
                width: WhisprButtonUtil.outlineBorderWidth,
                color: _disabledColor,
              );
            } else {
              return const BorderSide(
                width: WhisprButtonUtil.outlineBorderWidth,
                color: _outlinedButtonColor,
              );
            }
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          foregroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return _disabledColor;
            } else {
              return _outlinedButtonColor;
            }
          }),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize),
          ),
        );
      case WhisprButtonStyle.filled:
        return WhisprThemes.filledButtonTheme.copyWith(
          minimumSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveButtonSize(buttonSize)),
          iconSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveIconSize(buttonSize)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return _disabledColor;
            } else {
              return _filledButtonColor;
            }
          }),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize).copyWith(
              color: Colors.white,
            ),
          ),
        );
      case WhisprButtonStyle.text:
        return WhisprThemes.textButtonTheme.copyWith(
          minimumSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveButtonSize(buttonSize)),
          iconSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveIconSize(buttonSize)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          foregroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return _disabledColor;
            } else {
              return _textButtonColor;
            }
          }),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize),
          ),
        );
      case WhisprButtonStyle.negativeFilled:
        return WhisprThemes.filledButtonTheme.copyWith(
          minimumSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveButtonSize(buttonSize)),
          iconSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveIconSize(buttonSize)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          elevation: const WidgetStatePropertyAll(0.0),
          backgroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return _negativeDisabledButtonColor;
            } else {
              return _negativeButtonColor;
            }
          }),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize)
                .copyWith(color: Colors.white),
          ),
        );
      case WhisprButtonStyle.negativeText:
        return WhisprThemes.textButtonTheme.copyWith(
          minimumSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveButtonSize(buttonSize)),
          iconSize: WidgetStatePropertyAll(
              WhisprButtonUtil.resolveIconSize(buttonSize)),
          iconColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return _negativeDisabledButtonColor;
            } else {
              return _negativeButtonColor;
            }
          }),
          overlayColor: WidgetStatePropertyAll(
              _negativeButtonColor.withValues(alpha: 0.1)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: WhisprButtonUtil.resolveBorderRadius(),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            WhisprButtonUtil.resolveTextStyle(buttonSize)
                .copyWith(color: WhisprColors.crayola),
          ),
          foregroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.disabled)) {
              return _negativeDisabledButtonColor;
            } else {
              return _negativeButtonColor;
            }
          }),
        );
    }
  }
}

/// Whispr button types
enum WhisprButtonStyle { outlined, filled, text, negativeFilled, negativeText }
