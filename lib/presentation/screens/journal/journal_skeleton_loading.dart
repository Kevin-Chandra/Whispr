import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/presentation/screens/journal/journal_body.dart';

class JournalSkeletonLoading extends StatelessWidget {
  const JournalSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: JournalBody(
        audioRecordings: [
          AudioRecording.mock(),
          AudioRecording.mock(),
          AudioRecording.mock(),
          AudioRecording.mock(),
          AudioRecording.mock(),
        ],
        onFavouritePressed: (_) {},
        onAddNewRecording: () {},
        onEditPressed: (_) {},
        onDeletePressed: (_) {},
        onRefresh: () {},
      ),
    );
  }
}
