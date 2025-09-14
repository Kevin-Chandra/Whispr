import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_state_text.dart';

class RecordAudioStateTextSkeletonLoading extends StatelessWidget {
  const RecordAudioStateTextSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: RecordAudioStateText(isRecording: false));
  }
}
