import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';

class WhisprElevatedIconButton extends StatelessWidget {
  const WhisprElevatedIconButton({
    super.key,
    required this.onClick,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.iconColor = WhisprColors.spanishViolet,
    this.buttonSize = ButtonSize.small,
  });

  final VoidCallback onClick;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final ButtonSize buttonSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: backgroundColor,
      shape: CircleBorder(),
      child: InkWell(
        onTap: onClick,
        customBorder: CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(_resolvePaddingSize()),
          child: Icon(
            icon,
            size: _resolveIconSize(),
            color: iconColor,
          ),
        ),
      ),
    );
  }

  double _resolveIconSize() {
    switch (buttonSize) {
      case ButtonSize.extraSmall:
        return 12;
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 24;
      case ButtonSize.large:
        return 28;
      case ButtonSize.xLarge:
        return 36;
      case ButtonSize.xxLarge:
        return 42;
    }
  }

  double _resolvePaddingSize() {
    switch (buttonSize) {
      case ButtonSize.extraSmall:
      case ButtonSize.small:
        return 4;
      case ButtonSize.medium:
        return 8;
      case ButtonSize.large:
        return 12;
      case ButtonSize.xLarge:
        return 16;
      case ButtonSize.xxLarge:
        return 20;
    }
  }
}

enum ButtonSize {
  extraSmall,
  small,
  medium,
  large,
  xLarge,
  xxLarge,
}
