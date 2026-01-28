import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/util/date_time_util.dart';

class RecordAudioTimerText extends StatelessWidget {
  const RecordAudioTimerText({super.key, required this.duration});

  final Stream<Duration>? duration;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: duration,
      builder: (ctx, snapshot) => Text(
        snapshot.data != null ? snapshot.data!.durationDisplay : "",
        style: WhisprTextStyles.heading1.copyWith(
          color: Colors.white,
          fontSize: 48,
        ),
      ),
    );
  }
}
