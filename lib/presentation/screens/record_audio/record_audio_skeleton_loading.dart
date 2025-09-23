import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_body.dart';

class RecordAudioSkeletonLoading extends StatelessWidget {
  const RecordAudioSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: RecordAudioBody(
        onPauseClick: () {},
        onResumeClick: () {},
        onSaveClick: () {},
        onCancelClick: () {},
        isRecording: true,
      ),
    );
  }
}
