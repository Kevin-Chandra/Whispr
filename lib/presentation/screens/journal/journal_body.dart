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
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

import 'journal_item_audio_player_body.dart';
import 'journal_item_audio_player_control.dart';

class JournalBody extends StatefulWidget {
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
  State<JournalBody> createState() => _JournalBodyState();
}

class _JournalBodyState extends State<JournalBody> {
  late AudioPlayerCubit _audioPlayerCubit;
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
          child: widget.audioRecordings.isEmpty
              ? JournalEmptyBody(onAddNewRecording: widget.onAddNewRecording)
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16),
                  itemCount: widget.audioRecordings.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.audioRecordings.length) {
                      final currentAudioRecording =
                          widget.audioRecordings[index];
                      return AnimatedSize(
                        duration: const Duration(
                            milliseconds:
                                WhisprDuration.animatedContainerMillis),
                        alignment: Alignment.topCenter,
                        curve: Curves.easeIn,
                        clipBehavior: Clip.antiAlias,
                        child: WhisprJournalItem(
                          isSelected: currentSelectedRecordingId ==
                              currentAudioRecording.id,
                          audioRecording: currentAudioRecording,
                          onFavouritePressed: () {
                            widget.onFavouritePressed(currentAudioRecording);
                          },
                          isLastItem:
                              index == widget.audioRecordings.length - 1,
                          expandedWidget: SizedBox(
                            height: 60,
                            child: state.currentPlayingFile ==
                                    currentAudioRecording.filePath
                                ? _buildExpandedWidget(
                                    currentAudioRecording, state)
                                : _buildRowWithEditAndDeleteButton(
                                    startWidget: WhisprIconButton(
                                      icon: Icons.play_arrow_rounded,
                                      buttonSize: ButtonSize.medium,
                                      onClick: () {
                                        _audioPlayerCubit.prepareAudio(
                                          currentAudioRecording.filePath,
                                          playImmediately: true,
                                        );
                                      },
                                      buttonStyle:
                                          WhisprIconButtonStyle.gradient,
                                    ),
                                    audioRecording: currentAudioRecording,
                                  ),
                          ),
                          onPressed: () {
                            setState(() {
                              currentSelectedRecordingId ==
                                      currentAudioRecording.id
                                  ? currentSelectedRecordingId = null
                                  : currentSelectedRecordingId =
                                      currentAudioRecording.id;
                            });
                          },
                          isPlayingAudio: state.currentPlayingFile ==
                                  currentAudioRecording.filePath &&
                              state.state == AudioPlayerState.playing,
                        ),
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
      },
    );
  }

  Widget _buildExpandedWidget(
      AudioRecording audioRecording, AudioPlayerScreenState state) {
    return switch (state) {
      AudioPlayerInitialState() => _buildRowWithEditAndDeleteButton(
          startWidget: WhisprIconButton(
            icon: Icons.play_arrow_rounded,
            buttonSize: ButtonSize.medium,
            onClick: () {
              _audioPlayerCubit.prepareAudio(
                audioRecording.filePath,
                playImmediately: false,
              );
            },
            buttonStyle: WhisprIconButtonStyle.gradient,
          ),
          audioRecording: audioRecording,
        ),
      AudioPlayerLoadingState() => _buildRowWithEditAndDeleteButton(
          startWidget: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(),
            ),
          ),
          audioRecording: audioRecording,
        ),
      AudioPlayerLoadedState() => state.state == AudioPlayerState.playing
          ? JournalItemAudioPlayerBody(
              playerControllerWidget: _buildAudioPlayerControl(),
              waveformData: audioRecording.waveformData ?? [],
              // TODO: Improve handling for null.
              playerController: state.controller,
            )
          : _buildRowWithEditAndDeleteButton(
              startWidget: _buildAudioPlayerControl(),
              audioRecording: audioRecording,
            ),
      AudioPlayerScreenError() => _buildRowWithEditAndDeleteButton(
          startWidget: WhisprIconButton(
            icon: Icons.play_arrow_rounded,
            buttonSize: ButtonSize.medium,
            onClick: () {
              _audioPlayerCubit.prepareAudio(
                audioRecording.filePath,
                playImmediately: false,
              );
            },
            buttonStyle: WhisprIconButtonStyle.gradient,
          ),
          middleWidget: Text(
            state.error.error,
            style: WhisprTextStyles.bodyS.copyWith(
              color: WhisprColors.crayola,
            ),
          ),
          audioRecording: audioRecording,
        ),
    };
  }

  Widget _buildRowWithEditAndDeleteButton({
    required Widget startWidget,
    required AudioRecording audioRecording,
    Widget? middleWidget,
  }) {
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
              onPressed: () => widget.onEditPressed(audioRecording),
              icon: const Icon(Icons.edit_rounded),
              color: WhisprColors.lavenderBlue,
            ),
            IconButton(
              onPressed: () => widget.onDeletePressed(audioRecording),
              icon: const Icon(Icons.delete_rounded),
              color: WhisprColors.crayola,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAudioPlayerControl() {
    return BlocSelector<AudioPlayerCubit, AudioPlayerScreenState,
        AudioPlayerState>(
      selector: (state) => state.state,
      builder: (context, state) {
        return switch (state) {
          AudioPlayerState.idle => JournalItemAudioPlayerControl(
              isPlaying: false,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
          AudioPlayerState.playing => JournalItemAudioPlayerControl(
              isPlaying: true,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
          AudioPlayerState.paused => JournalItemAudioPlayerControl(
              isPlaying: false,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
          AudioPlayerState.stopped => JournalItemAudioPlayerControl(
              isPlaying: false,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
        };
      },
    );
  }
}
