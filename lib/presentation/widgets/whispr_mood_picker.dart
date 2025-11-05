import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_wheel_scroll.dart';

class WhisprMoodPicker extends StatelessWidget {
  const WhisprMoodPicker({
    super.key,
    required this.onMoodSelected,
    this.selectedMood,
    this.maxDistanceToFade = 2,
    this.maxBlur = 3.0,
    this.minOpacity = 0.5,
    this.minScale = 0.8,
  });

  final int maxDistanceToFade;
  final double maxBlur;
  final double minOpacity;
  final double minScale;
  final Mood? selectedMood;
  final Function(Mood) onMoodSelected;

  static const _selectedImageSize = 80.0;
  static const _unselectedImageSize = 60.0;

  @override
  Widget build(BuildContext context) {
    return WhisprWheelScroll(
      initialIndex:
          selectedMood != null ? Mood.values.indexOf(selectedMood!) : 0,
      items: Mood.values,
      itemSize: _selectedImageSize,
      squeeze: 1,
      diameterRatio: 3,
      onSelected: (item) => onMoodSelected(item),
      selectedLabel: (item) => item.getDisplayName(context),
      selectedLabelStyle:
          WhisprTextStyles.heading4.copyWith(color: WhisprColors.spanishViolet),
      selectedWidget: (item) => Image.asset(
        item.imageAsset,
        width: _selectedImageSize,
        height: _selectedImageSize,
      ),
      unselectedWidget: (item, selected, current) {
        final ratio =
            ((selected - current).abs() / maxDistanceToFade).clamp(0.0, 1.0);
        final blur = lerpDouble(0, maxBlur, ratio)!;
        final opacity = lerpDouble(1, minOpacity, ratio)!;
        final scale = lerpDouble(1, minScale, ratio)!;

        final image = ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Image.asset(
            item.imageAsset,
            width: _unselectedImageSize,
            height: _unselectedImageSize,
          ),
        );

        return Transform.scale(
          scale: scale,
          child: Opacity(opacity: opacity, child: image),
        );
      },
    );
  }
}
