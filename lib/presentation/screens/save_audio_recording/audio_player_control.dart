import 'package:flutter/material.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_icon_button.dart';

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
