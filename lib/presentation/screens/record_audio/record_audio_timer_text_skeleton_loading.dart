import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_timer_text.dart';

class RecordAudioTimerTextSkeletonLoading extends StatelessWidget {
  const RecordAudioTimerTextSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: RecordAudioTimerText(
        duration: Duration.zero,
      ),
    );
  }
}
