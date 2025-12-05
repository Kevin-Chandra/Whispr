import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/screens/journal/journal_empty_body.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_icon_button.dart';
import 'package:whispr/presentation/widgets/whispr_journal_item.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

import 'journal_item_audio_player_body.dart';
import 'journal_item_audio_player_control.dart';

class JournalBody extends StatelessWidget {
  const JournalBody({
    super.key,
    required this.audioRecordings,
    required this.onFavouritePressed,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onRefresh,
    required this.onAddNewRecording,
  });

  final List<AudioRecording> audioRecordings;
  final VoidCallback onAddNewRecording;
  final VoidCallback onRefresh;
  final Function(AudioRecording) onFavouritePressed;
  final Function(AudioRecording) onEditPressed;
  final Function(AudioRecording) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return audioRecordings.isEmpty
        ? JournalEmptyBody(onAddNewRecording: onAddNewRecording)
        : _JournalList(
            audioRecordings: audioRecordings,
            onAddNewRecording: onAddNewRecording,
            onRefresh: onRefresh,
            onFavouritePressed: onFavouritePressed,
            onEditPressed: onEditPressed,
            onDeletePressed: onDeletePressed,
          );
  }
}

class _JournalList extends StatefulWidget {
  const _JournalList({
    super.key,
    required this.audioRecordings,
    required this.onAddNewRecording,
    required this.onRefresh,
    required this.onFavouritePressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  final List<AudioRecording> audioRecordings;
  final VoidCallback onAddNewRecording;
  final VoidCallback onRefresh;
  final Function(AudioRecording) onFavouritePressed;
  final Function(AudioRecording) onEditPressed;
  final Function(AudioRecording) onDeletePressed;

  @override
  State<_JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<_JournalList> {
  late final AudioPlayerCubit _audioPlayerCubit;
  String? currentSelectedRecordingId;

  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerScreenState>(
        builder: (context, state) {
      return RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh();
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          itemCount: widget.audioRecordings.length + 1,
          itemBuilder: (context, index) {
            if (index < widget.audioRecordings.length) {
              final currentAudioRecording = widget.audioRecordings[index];
              return WhisprJournalItem(
                isSelected:
                    currentSelectedRecordingId == currentAudioRecording.id,
                audioRecording: currentAudioRecording,
                onFavouritePressed: () {
                  widget.onFavouritePressed(currentAudioRecording);
                },
                isLastItem: index == widget.audioRecordings.length - 1,
                expandedWidget: RecordingCardExpandedContent(
                  state: state,
                  audioRecording: currentAudioRecording,
                  currentDuration: _audioPlayerCubit.position,
                  onEditPressed: () {
                    widget.onEditPressed(currentAudioRecording);
                  },
                  onDeletePressed: () {
                    widget.onDeletePressed(currentAudioRecording);
                  },
                  onPrepare: () {
                    _audioPlayerCubit.prepareAudio(
                      currentAudioRecording.filePath,
                      playImmediately: true,
                    );
                  },
                  onPlay: _audioPlayerCubit.play,
                  onPause: _audioPlayerCubit.pause,
                ),
                onPressed: () {
                  setState(() {
                    currentSelectedRecordingId == currentAudioRecording.id
                        ? currentSelectedRecordingId = null
                        : currentSelectedRecordingId = currentAudioRecording.id;
                  });
                },
                isPlayingAudio: state.currentPlayingFile ==
                        currentAudioRecording.filePath &&
                    state.state == AudioPlayerState.playing,
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    WhisprGradientButton(
                      text: context.strings.addNewRecording,
                      buttonStyle: WhisprGradientButtonStyle.filled,
                      buttonSize: WhisprButtonSizes.small,
                      icon: Icons.add_rounded,
                      onPressed: widget.onAddNewRecording,
                    ),
                  ],
                ),
              );
            }
          },
          separatorBuilder: (context, index) => SizedBox(height: 8),
        ),
      );
    });
  }
}

class RecordingCardExpandedContent extends StatelessWidget {
  const RecordingCardExpandedContent({
    super.key,
    required this.state,
    required this.audioRecording,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onPrepare,
    required this.onPlay,
    required this.onPause,
    this.currentDuration,
  });

  final AudioPlayerScreenState state;
  final AudioRecording audioRecording;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onPrepare;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final Stream<Duration>? currentDuration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: state.currentPlayingFile != audioRecording.filePath
          ? _RowWithEditAndDeleteButton(
              startWidget: WhisprIconButton(
                icon: Icons.play_arrow_rounded,
                buttonSize: ButtonSize.medium,
                onClick: onPrepare,
                buttonStyle: WhisprIconButtonStyle.gradient,
              ),
              onEditPressed: onEditPressed,
              onDeletePressed: onDeletePressed,
            )
          : switch (state) {
              AudioPlayerInitialState() => _RowWithEditAndDeleteButton(
                  startWidget: WhisprIconButton(
                    icon: Icons.play_arrow_rounded,
                    buttonSize: ButtonSize.medium,
                    onClick: onPrepare,
                    buttonStyle: WhisprIconButtonStyle.gradient,
                  ),
                  onEditPressed: onEditPressed,
                  onDeletePressed: onDeletePressed,
                ),
              AudioPlayerLoadingState() => _RowWithEditAndDeleteButton(
                  startWidget: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  onEditPressed: onEditPressed,
                  onDeletePressed: onDeletePressed,
                ),
              AudioPlayerLoadedState() =>
                state.state == AudioPlayerState.playing
                    ? JournalItemAudioPlayerBody(
                        playerControllerWidget:
                            _JournalItemAudioPlayerControlWrapper(
                          onPrepare: onPrepare,
                          onPlayClick: onPlay,
                          onPauseClick: onPause,
                        ),
                        // TODO: Improve handling for null.
                        waveformData: audioRecording.waveformData ?? [],
                        playerController:
                            (state as AudioPlayerLoadedState).controller,
                        playerDurationDisplayWidget: StreamBuilder(
                          stream: currentDuration,
                          builder: (context, snapshot) => snapshot.data != null
                              ? Text(
                                  snapshot.data!.durationDisplay,
                                  style: WhisprTextStyles.bodyS.copyWith(
                                    color: WhisprColors.spanishViolet,
                                  ),
                                )
                              : SizedBox(),
                        ),
                      )
                    : _RowWithEditAndDeleteButton(
                        startWidget: _JournalItemAudioPlayerControlWrapper(
                          onPrepare: onPrepare,
                          onPlayClick: onPlay,
                          onPauseClick: onPause,
                        ),
                        onEditPressed: onEditPressed,
                        onDeletePressed: onDeletePressed,
                      ),
              AudioPlayerScreenError() => _RowWithEditAndDeleteButton(
                  startWidget: WhisprIconButton(
                    icon: Icons.play_arrow_rounded,
                    buttonSize: ButtonSize.medium,
                    onClick: onPrepare,
                    buttonStyle: WhisprIconButtonStyle.gradient,
                  ),
                  middleWidget: Text(
                    (state as AudioPlayerScreenError).error.error,
                    style: WhisprTextStyles.bodyS.copyWith(
                      color: WhisprColors.crayola,
                    ),
                  ),
                  onEditPressed: onEditPressed,
                  onDeletePressed: onDeletePressed,
                ),
            },
    );
  }
}

class _JournalItemAudioPlayerControlWrapper extends StatelessWidget {
  const _JournalItemAudioPlayerControlWrapper({
    required this.onPlayClick,
    required this.onPauseClick,
    required this.onPrepare,
  });

  final VoidCallback onPrepare;
  final VoidCallback onPlayClick;
  final VoidCallback onPauseClick;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AudioPlayerCubit, AudioPlayerScreenState,
        AudioPlayerState>(
      selector: (state) => state.state,
      builder: (context, state) {
        return switch (state) {
          AudioPlayerState.idle => JournalItemAudioPlayerControl(
              isPlaying: false,
              onPlayClick: onPlayClick,
              onPauseClick: onPauseClick,
            ),
          AudioPlayerState.playing => JournalItemAudioPlayerControl(
              isPlaying: true,
              onPlayClick: onPlayClick,
              onPauseClick: onPauseClick,
            ),
          AudioPlayerState.paused => JournalItemAudioPlayerControl(
              isPlaying: false,
              onPlayClick: onPlayClick,
              onPauseClick: onPauseClick,
            ),
          AudioPlayerState.stopped => JournalItemAudioPlayerControl(
              isPlaying: false,
              onPlayClick: onPrepare,
              onPauseClick: onPauseClick,
            ),
        };
      },
    );
  }
}

class _RowWithEditAndDeleteButton extends StatelessWidget {
  const _RowWithEditAndDeleteButton({
    required this.startWidget,
    required this.onEditPressed,
    required this.onDeletePressed,
    this.middleWidget,
  });

  final Widget startWidget;
  final Widget? middleWidget;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        startWidget,
        middleWidget ?? SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEditPressed,
              icon: const Icon(Icons.edit_rounded),
              color: WhisprColors.lavenderBlue,
            ),
            IconButton(
              onPressed: onDeletePressed,
              icon: const Icon(Icons.delete_rounded),
              color: WhisprColors.crayola,
            ),
          ],
        ),
      ],
    );
  }
}
