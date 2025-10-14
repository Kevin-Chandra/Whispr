import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class AudioPlayerBody extends StatelessWidget {
  const AudioPlayerBody({
    super.key,
    required this.waveformWidth,
    required this.playerControllerWidget,
    required this.waveformData,
    required this.playerController,
    required this.playerWaveStyle,
  });

  final double waveformWidth;
  final Widget playerControllerWidget;
  final List<double> waveformData;
  final PlayerController playerController;
  final PlayerWaveStyle playerWaveStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        playerControllerWidget,
        SizedBox(
          height: 16,
        ),
        AudioFileWaveforms(
          size: Size(waveformWidth, 75),
          playerController: playerController,
          waveformData: waveformData,
          waveformType: WaveformType.fitWidth,
          playerWaveStyle: playerWaveStyle,
        )
      ],
    );
  }
}
