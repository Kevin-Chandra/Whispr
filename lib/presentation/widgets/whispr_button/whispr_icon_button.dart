import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';

class WhisprIconButton extends StatelessWidget {
  const WhisprIconButton({
    super.key,
    required this.icon,
    required this.onClick,
    required this.buttonStyle,
    this.backgroundColor = Colors.white,
    this.iconColor = WhisprColors.cornflowerBlue,
    this.buttonSize = ButtonSize.small,
    this.backgroundGradient = WhisprGradient.purplePinkGradient,
  });

  final VoidCallback onClick;
  final IconData icon;
  final Gradient backgroundGradient;
  final Color backgroundColor;
  final Color iconColor;
  final ButtonSize buttonSize;
  final WhisprIconButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _resolveCardElevation(),
      color: backgroundColor,
      shape: CircleBorder(),
      child: Container(
        decoration: _resolveBoxDecoration(),
        child: Material(
          color: Colors.transparent,
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
        ),
      ),
    );
  }

  double _resolveCardElevation() {
    switch (buttonStyle) {
      case WhisprIconButtonStyle.gradient:
        return 0;
      case WhisprIconButtonStyle.solid:
        return 3;
    }
  }

  BoxDecoration? _resolveBoxDecoration() {
    switch (buttonStyle) {
      case WhisprIconButtonStyle.gradient:
        return BoxDecoration(
          gradient: backgroundGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white54,
              offset: Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        );
      case WhisprIconButtonStyle.solid:
        return null;
    }
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
        return 56;
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

enum WhisprIconButtonStyle { gradient, solid }
