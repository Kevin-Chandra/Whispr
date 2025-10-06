import 'package:flutter/material.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_icon_button.dart';

class JournalItemAudioPlayerControl extends StatelessWidget {
  const JournalItemAudioPlayerControl({
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
            buttonSize: ButtonSize.medium,
            buttonStyle: WhisprIconButtonStyle.gradient,
          )
        : WhisprIconButton(
            onClick: onPlayClick,
            icon: Icons.play_arrow_rounded,
            buttonSize: ButtonSize.medium,
            buttonStyle: WhisprIconButtonStyle.gradient,
          );
  }
}
