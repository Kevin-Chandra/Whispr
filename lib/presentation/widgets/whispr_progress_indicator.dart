import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';

class WhisprProgressIndicator extends StatelessWidget {
  const WhisprProgressIndicator({
    super.key,
    this.value,
    this.textStyle,
    this.dimension,
    this.strokeWidth,
  });

  final double? value;
  final TextStyle? textStyle;
  final double? dimension;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: dimension,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
          ),
        ),
        value != null
            ? Text("${(value! * 100).round()}%",
                style: textStyle ??
                    WhisprTextStyles.subtitle1
                        .copyWith(color: WhisprColors.spanishViolet))
            : const SizedBox(),
      ],
    );
  }
}
