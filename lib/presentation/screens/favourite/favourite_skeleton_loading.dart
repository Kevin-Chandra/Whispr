import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/presentation/screens/favourite/favourite_body.dart';

class FavouriteSkeletonLoading extends StatelessWidget {
  const FavouriteSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: FavouriteBody(
        audioRecordings: {
          DateTime.now().add(Duration(days: -1)):
              List.filled(2, AudioRecording.mock()),
          DateTime.now(): List.filled(2, AudioRecording.mock()),
          DateTime.now().add(Duration(days: 1)):
              List.filled(2, AudioRecording.mock()),
        },
        onEditPressed: (_) {},
        onDeletePressed: (_) {},
        onRefreshPressed: () {},
        onFavouritePressed: (_) {},
        onAddFavouritePressed: () {},
      ),
    );
  }
}
