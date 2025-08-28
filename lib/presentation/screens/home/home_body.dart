import 'package:flutter/material.dart';
import 'package:whispr/data/models/audio_player_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.state,
    required this.totalDuration,
    required this.currentDuration,
  });

  final AudioPlayerState state;
  final Duration totalDuration;
  final Duration currentDuration;

  @override
  Widget build(BuildContext context) {
    final total = totalDuration.inMilliseconds == 0
        ? 1.0
        : totalDuration.inMilliseconds.toDouble();
    final a = currentDuration.inMilliseconds.toDouble() / total;
    return Column(
      children: [
        Text(state.toString()),
        LinearProgressIndicator(
          value: a,
        )
      ],
    );
  }
}
