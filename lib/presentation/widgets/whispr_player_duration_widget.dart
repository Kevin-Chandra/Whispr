import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/util/date_time_util.dart';

class WhisprPlayerDurationWidget extends StatelessWidget {
  const WhisprPlayerDurationWidget({
    super.key,
    required this.currentDuration,
    this.defaultDisplay = "00:00",
  });

  final Stream<Duration> currentDuration;
  final String defaultDisplay;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          currentDuration.map((d) => Duration(seconds: d.inSeconds)).distinct(),
      builder: (context, snapshot) => Text(
        snapshot.data?.durationDisplay ?? defaultDisplay,
        style: WhisprTextStyles.bodyS.copyWith(
          color: WhisprColors.spanishViolet,
        ),
      ),
    );
  }
}
