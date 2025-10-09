import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_body.dart';

class SaveAudioRecordingSkeletonLoading extends StatelessWidget {
  const SaveAudioRecordingSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: SaveAudioRecordingBody(
      waveformWidget: SizedBox(),
      titleController: TextEditingController(),
      onCancelClick: () {},
      onSaveClick: () {},
      onMoodSelected: (_) {},
      onRecordingTagChanged: (_) {},
      titleFormKey: GlobalKey(),
    ));
  }
}
