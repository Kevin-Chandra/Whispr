import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/util/date_time_util.dart';

class JournalItemAudioPlayerBody extends StatelessWidget {
  const JournalItemAudioPlayerBody({
    super.key,
    required this.playerControllerWidget,
    required this.waveformData,
    required this.playerController,
    required this.playerDurationDisplayWidget,
  });

  final Widget playerControllerWidget;
  final Widget playerDurationDisplayWidget;
  final List<double> waveformData;
  final PlayerController playerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            playerControllerWidget,
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => AudioFileWaveforms(
                      animationDuration: Duration(milliseconds: 1000),
                      size: Size(constraints.maxWidth, 40),
                      playerController: playerController,
                      waveformData: waveformData,
                      waveformType: WaveformType.long,
                      playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: WhisprColors.lavenderWeb,
                        liveWaveColor: WhisprColors.maximumBluePurple,
                        showSeekLine: true,
                        seekLineThickness: 2,
                        seekLineColor: WhisprColors.maximumBluePurple,
                        waveCap: StrokeCap.round,
                        showTop: true,
                        showBottom: true,
                        spacing: 4,
                        scaleFactor: 100,
                        waveThickness: 2,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      playerDurationDisplayWidget,
                      Text(
                        Duration(milliseconds: playerController.maxDuration)
                            .durationDisplay,
                        style: WhisprTextStyles.bodyS.copyWith(
                          color: WhisprColors.spanishViolet,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
