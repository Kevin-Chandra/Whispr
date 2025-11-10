import 'package:flutter/material.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_icon_button.dart';

class WhisprBasicAudioPlayerControl extends StatelessWidget {
  const WhisprBasicAudioPlayerControl({
    super.key,
    required this.playerState,
    required this.onPlayClick,
    required this.onPauseClick,
  });

  final AudioPlayerState playerState;
  final VoidCallback onPlayClick;
  final VoidCallback onPauseClick;

  @override
  Widget build(BuildContext context) {
    return switch (playerState) {
      AudioPlayerState.idle => _BasicPlayerControl(
          isPlaying: false,
          onPlayClick: onPlayClick,
          onPauseClick: onPauseClick,
        ),
      AudioPlayerState.playing => _BasicPlayerControl(
          isPlaying: true,
          onPlayClick: onPlayClick,
          onPauseClick: onPauseClick,
        ),
      AudioPlayerState.paused => _BasicPlayerControl(
          isPlaying: false,
          onPlayClick: onPlayClick,
          onPauseClick: onPauseClick,
        ),
      AudioPlayerState.stopped => _BasicPlayerControl(
          isPlaying: false,
          onPlayClick: onPlayClick,
          onPauseClick: onPauseClick,
        ),
    };
  }
}

class _BasicPlayerControl extends StatelessWidget {
  const _BasicPlayerControl({
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
        ? WhisprIconButton(
            onClick: onPauseClick,
            icon: Icons.pause_rounded,
            iconColor: Colors.white,
            buttonSize: ButtonSize.xLarge,
            buttonStyle: WhisprIconButtonStyle.gradient,
          )
        : WhisprIconButton(
            onClick: onPlayClick,
            icon: Icons.play_arrow_rounded,
            iconColor: Colors.white,
            buttonSize: ButtonSize.xLarge,
            buttonStyle: WhisprIconButtonStyle.gradient,
          );
  }
}
