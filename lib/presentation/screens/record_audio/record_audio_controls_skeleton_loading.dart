import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_controls.dart';

class RecordAudioControlsSkeletonLoading extends StatelessWidget {
  const RecordAudioControlsSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: RecordAudioControls(
        onPauseClick: () {},
        onResumeClick: () {},
        onSaveClick: () {},
        onCancelClick: () {},
        isRecording: true,
      ),
    );
  }
}
