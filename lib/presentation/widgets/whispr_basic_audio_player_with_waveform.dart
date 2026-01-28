import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_basic_audio_player_control.dart';
import 'package:whispr/presentation/widgets/whispr_basic_audio_player_error.dart';
import 'package:whispr/presentation/widgets/whispr_player_duration_widget.dart';
import 'package:whispr/presentation/widgets/whispr_progress_indicator.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

class WhisprBasicAudioPlayerWithWaveform extends StatelessWidget {
  const WhisprBasicAudioPlayerWithWaveform({
    super.key,
    required this.audioPlayerScreenState,
    required this.onPlayClick,
    required this.onPauseClick,
    required this.onErrorRetryClick,
    required this.waveformWidth,
    required this.playerDuration,
    this.playerWaveStyle,
    this.waveformData,
  });

  final double waveformWidth;
  final AudioPlayerScreenState audioPlayerScreenState;
  final VoidCallback onPlayClick;
  final VoidCallback onPauseClick;
  final VoidCallback onErrorRetryClick;
  final Stream<Duration> playerDuration;
  final PlayerWaveStyle? playerWaveStyle;
  final List<double>? waveformData;

  @override
  Widget build(BuildContext context) {
    return switch (audioPlayerScreenState) {
      AudioPlayerInitialState() => SizedBox(),
      AudioPlayerLoadingState() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: WhisprProgressIndicator(
            value: (audioPlayerScreenState as AudioPlayerLoadingState).progress,
            dimension: 50,
            strokeWidth: 5,
          ),
        ),
      AudioPlayerLoadedState() => _AudioPlayerAndWaveform(
          waveformWidth: waveformWidth,
          playerControllerWidget: WhisprBasicAudioPlayerControl(
            playerState: audioPlayerScreenState.state,
            onPlayClick: onPlayClick,
            onPauseClick: onPauseClick,
          ),
          waveformData: waveformData ??
              (audioPlayerScreenState as AudioPlayerLoadedState).waveform,
          playerController:
              (audioPlayerScreenState as AudioPlayerLoadedState).controller,
          playerWaveStyle: playerWaveStyle,
          playerDuration: playerDuration,
        ),
      AudioPlayerScreenError() => WhisprBasicAudioPlayerError(
          icon: Icons.warning_amber_rounded,
          errorTitle: context.strings.loadingAudioPlaybackError,
          errorMessage:
              (audioPlayerScreenState as AudioPlayerScreenError).error.error,
          onRetryClicked: onErrorRetryClick,
        )
    };
  }
}

class _AudioPlayerAndWaveform extends StatelessWidget {
  const _AudioPlayerAndWaveform({
    super.key,
    required this.waveformWidth,
    required this.playerDuration,
    required this.playerControllerWidget,
    required this.waveformData,
    required this.playerController,
    this.playerWaveStyle,
  });

  final double waveformWidth;
  final Stream<Duration> playerDuration;
  final Widget playerControllerWidget;
  final List<double> waveformData;
  final PlayerController playerController;
  final PlayerWaveStyle? playerWaveStyle;

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
          playerWaveStyle: playerWaveStyle ??
              PlayerWaveStyle(
                fixedWaveColor: WhisprColors.lavenderWeb,
                liveWaveColor: WhisprColors.maximumBluePurple,
                seekLineThickness: 0,
                waveCap: StrokeCap.round,
                showTop: true,
                showBottom: true,
                spacing: 4,
                scaleFactor: 200,
                waveThickness: 2,
              ),
        ),
        SizedBox(
          width: waveformWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WhisprPlayerDurationWidget(currentDuration: playerDuration),
              Text(
                Duration(milliseconds: playerController.maxDuration)
                    .durationDisplay,
                style: WhisprTextStyles.bodyS.copyWith(
                  color: WhisprColors.spanishViolet,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
