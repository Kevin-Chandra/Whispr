import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';

class JournalItemAudioPlayerBody extends StatelessWidget {
  const JournalItemAudioPlayerBody({
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
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        playerControllerWidget,
        SizedBox(
          width: 8,
        ),
        AudioFileWaveforms(
          animationDuration: Duration(milliseconds: 1000),
          size: Size(width * 0.5, 50),
          playerController: playerController,
          waveformData: waveformData,
          waveformType: WaveformType.long,
          playerWaveStyle: PlayerWaveStyle(
            fixedWaveColor: WhisprColors.lavenderWeb,
            liveWaveColor: WhisprColors.maximumBluePurple,
            showSeekLine: false,
            waveCap: StrokeCap.round,
            showTop: true,
            showBottom: true,
            spacing: 4,
            scaleFactor: 100,
            waveThickness: 2,
          ),
        )
      ],
    );
  }
}
