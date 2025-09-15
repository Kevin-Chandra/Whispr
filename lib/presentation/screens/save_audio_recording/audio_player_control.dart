import 'package:flutter/material.dart';

class AudioPlayerControl extends StatelessWidget {
  const AudioPlayerControl({
    super.key,
    required this.isPlaying,
    required this.onPlayClick,
    required this.onPauseClick,
  });

  final bool isPlaying;
  final VoidCallback onPlayClick;
  final VoidCallback onPauseClick;

  @override
  Widget build(BuildContext context) {
    return isPlaying
        ? ElevatedButton(
            onPressed: onPauseClick,
            child: Icon(Icons.pause_rounded),
          )
        : ElevatedButton(
            onPressed: onPlayClick,
            child: Icon(Icons.play_arrow_rounded),
          );
  }
}
