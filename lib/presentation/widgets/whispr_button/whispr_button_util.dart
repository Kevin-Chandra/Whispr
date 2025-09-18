import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';

abstract class WhisprButtonUtil {
  static const outlineBorderWidth = 2.0;

  static TextStyle resolveTextStyle(WhisprButtonSizes buttonSize) {
    switch (buttonSize) {
      case WhisprButtonSizes.xsmall:
      case WhisprButtonSizes.small:
        return WhisprTextStyles.buttonS;
      case WhisprButtonSizes.medium:
        return WhisprTextStyles.buttonM;
      case WhisprButtonSizes.large:
        return WhisprTextStyles.buttonL;
    }
  }

  static double resolveIconSize(WhisprButtonSizes buttonSize) {
    switch (buttonSize) {
      case WhisprButtonSizes.xsmall:
      case WhisprButtonSizes.small:
        return 16;
      case WhisprButtonSizes.medium:
        return 20;
      case WhisprButtonSizes.large:
        return 24;
    }
  }

  static Size resolveButtonSize(WhisprButtonSizes buttonSize) {
    switch (buttonSize) {
      case WhisprButtonSizes.xsmall:
        return const Size(102, 32);
      case WhisprButtonSizes.small:
        return const Size(113, 40);
      case WhisprButtonSizes.medium:
        return const Size(131, 48);
      case WhisprButtonSizes.large:
        return const Size(148, 56);
    }
  }

  static Widget? resolveIcon(IconData? icon) {
    return icon == null ? null : Icon(icon);
  }

  static BorderRadius resolveBorderRadius() => BorderRadius.circular(100);
}
