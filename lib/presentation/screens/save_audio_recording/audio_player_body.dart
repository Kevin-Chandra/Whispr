import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';

class AudioPlayerBody extends StatelessWidget {
  const AudioPlayerBody({
    super.key,
    required this.playerControllerWidget,
    required this.waveformData,
    required this.playerController,
  });

  final Widget playerControllerWidget;
  final List<double> waveformData;
  final PlayerController playerController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) => Column(
        children: [
          playerControllerWidget,
          SizedBox(
            height: 16,
          ),
          AudioFileWaveforms(
            size: Size(constraint.maxWidth * 0.75, 75),
            playerController: playerController,
            waveformData: waveformData,
            waveformType: WaveformType.fitWidth,
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: WhisprColors.lavenderWeb,
              liveWaveColor: WhisprColors.maximumBluePurple,
              seekLineThickness: 0,
              // hide center line
              waveCap: StrokeCap.round,
              showTop: true,
              showBottom: true,
              // controls bar height
              spacing: 4,
              scaleFactor: 200,
              // distance between bars
              waveThickness: 2,
            ),
          )
        ],
      ),
    );
  }
}
