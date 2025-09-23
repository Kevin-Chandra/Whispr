import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/util/date_time_util.dart';

class RecordAudioTimerText extends StatelessWidget {
  const RecordAudioTimerText({super.key, required this.duration});

  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Text(
      duration != null ? duration!.durationDisplay : "",
      style: WhisprTextStyles.heading1.copyWith(
        color: Colors.white,
        fontSize: 48,
      ),
    );
  }
}
