import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/widgets/whispr_basic_audio_player_control.dart';
import 'package:whispr/presentation/widgets/whispr_basic_audio_player_error.dart';
import 'package:whispr/util/extensions.dart';

class WhisprBasicAudioPlayerWithWaveform extends StatelessWidget {
  const WhisprBasicAudioPlayerWithWaveform({
    super.key,
    required this.audioPlayerScreenState,
    required this.waveformWidth,
    required this.onPlayClick,
    required this.onPauseClick,
    required this.onErrorRetryClick,
    required this.playerWaveStyle,
  });

  final AudioPlayerScreenState audioPlayerScreenState;
  final double waveformWidth;
  final VoidCallback onPlayClick;
  final VoidCallback onPauseClick;
  final VoidCallback onErrorRetryClick;
  final PlayerWaveStyle playerWaveStyle;

  @override
  Widget build(BuildContext context) {
    return switch (audioPlayerScreenState) {
      AudioPlayerInitialState() => SizedBox(),
      AudioPlayerLoadingState() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      AudioPlayerLoadedState() => _AudioPlayerAndWaveform(
          waveformWidth: waveformWidth,
          playerControllerWidget: WhisprBasicAudioPlayerControl(
            playerState: audioPlayerScreenState.state,
            onPlayClick: onPlayClick,
            onPauseClick: onPauseClick,
          ),
          waveformData:
              (audioPlayerScreenState as AudioPlayerLoadedState).waveform,
          playerController:
              (audioPlayerScreenState as AudioPlayerLoadedState).controller,
          playerWaveStyle: playerWaveStyle,
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
