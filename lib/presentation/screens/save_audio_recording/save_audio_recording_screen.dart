import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/bloc/save_audio_recording/save_audio_recording_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/save_audio_recording/audio_player_body.dart';
import 'package:whispr/presentation/screens/save_audio_recording/audio_player_control.dart';
import 'package:whispr/presentation/screens/save_audio_recording/audio_player_error_body.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_body.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_skeleton_loading.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class SaveAudioRecordingScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const SaveAudioRecordingScreen({
    super.key,
    @PathParam() required this.audioRecordingPath,
  });

  final String audioRecordingPath;

  @override
  State<SaveAudioRecordingScreen> createState() =>
      _SaveAudioRecordingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioPlayerCubit>(create: (context) => AudioPlayerCubit()),
        BlocProvider<SaveAudioRecordingCubit>(
            create: (context) => SaveAudioRecordingCubit(audioRecordingPath)),
      ],
      child: this,
    );
  }
}

class _SaveAudioRecordingScreenState extends State<SaveAudioRecordingScreen> {
  late AudioPlayerCubit _audioPlayerCubit;
  late SaveAudioRecordingCubit _saveAudioRecordingCubit;
  final TextEditingController _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSaveSuccess = false;
  bool _isSaveCancelled = false;

  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
    _saveAudioRecordingCubit = context.read<SaveAudioRecordingCubit>();
    _audioPlayerCubit.prepareAudio(
      widget.audioRecordingPath,
      playImmediately: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }

        if ((_isSaveSuccess || _isSaveCancelled) && context.mounted) {
          NavigationCoordinator.navigatorPop(context: context);
        } else {
          await WhisprDialog(
            title: context.strings.discardRecording,
            message: context.strings.recordingWillNotBeSaved,
            confirmText: context.strings.discard,
            icon: Icons.delete_rounded,
            onConfirmPressed: () {
              _saveAudioRecordingCubit.cancelSaveRecording();
              context.router.maybePop(true);
            },
            dismissText: context.strings.cancel,
            onDismissPressed: () {
              context.router.maybePop();
            },
            isNegativeAction: true,
          ).show(context: context);
        }
      },
      child: WhisprGradientScaffold(
        gradient: WhisprGradient.whiteBlueWhiteGradient,
        body: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              WhisprAppBar(
                title: context.strings.voice_record,
                isDarkBackground: false,
                enableBackButton: false,
              )
            ];
          },
          body: BlocConsumer<SaveAudioRecordingCubit, SaveAudioRecordingState>(
            listener: (ctx, state) {
              if (state is SaveAudioRecordingSuccessState) {
                _isSaveSuccess = true;

                WhisprSnackBar(
                  title: context.strings.recordingSavedSuccessfully,
                ).show(context);

                NavigationCoordinator.navigateToJournalTab(context: context);
                return;
              }

              if (state is SaveAudioRecordingCancelledState) {
                _isSaveCancelled = true;
                context.router.maybePop();
                return;
              }

              if (state is SaveAudioRecordingErrorState) {
                WhisprSnackBar(
                  title: context.strings.failedToSaveAudioRecording,
                  subtitle: state.error.error,
                  isError: true,
                ).show(context);
                _saveAudioRecordingCubit.resetState();
                return;
              }
            },
            buildWhen: (old, current) {
              return current is! SaveAudioRecordingErrorState &&
                  current is! SaveAudioRecordingCancelledState &&
                  current is! SaveAudioRecordingSuccessState;
            },
            builder: (ctx, state) => AnimatedSwitcher(
              duration: const Duration(
                milliseconds: WhisprDuration.stateFadeTransitionMillis,
              ),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: switch (state) {
                SaveAudioRecordingInitialState() => SaveAudioRecordingBody(
                    waveformWidget: _buildAudioWaveform(),
                    titleController: _titleController,
                    titleFormKey: _formKey,
                    onCancelClick: () {
                      context.router.maybePop();
                    },
                    onSaveClick: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      _saveAudioRecordingCubit.saveAudioRecording(
                        name: _titleController.text,
                        tags: [],
                      );
                    },
                    onMoodSelected: _saveAudioRecordingCubit.moodSelected,
                  ),
                SaveAudioRecordingLoadingState() =>
                  SaveAudioRecordingSkeletonLoading(),
                _ => throw Exception("Invalid state $state"),
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAudioWaveform() {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerScreenState>(
      buildWhen: (old, current) {
        return old != current;
      },
      builder: (context, state) {
        return switch (state) {
          AudioPlayerInitialState() => SizedBox(),
          AudioPlayerLoadingState() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          AudioPlayerLoadedState() => AudioPlayerBody(
              playerControllerWidget: _buildAudioPlayerControl(),
              waveformData: state.waveform,
              playerController: state.controller,
            ),
          AudioPlayerScreenError() => AudioPlayerErrorBody(
              icon: Icons.warning_amber_rounded,
              errorTitle: context.strings.loadingAudioPlaybackError,
              errorMessage: state.error.error,
              onRetryClicked: () {
                _audioPlayerCubit.prepareAudio(widget.audioRecordingPath);
              },
            ),
        };
      },
    );
  }

  Widget _buildAudioPlayerControl() {
    return BlocSelector<AudioPlayerCubit, AudioPlayerScreenState,
        AudioPlayerState>(
      selector: (state) => state.state,
      builder: (context, state) {
        return switch (state) {
          AudioPlayerState.idle => AudioPlayerControl(
              isPlaying: false,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
          AudioPlayerState.playing => AudioPlayerControl(
              isPlaying: true,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
          AudioPlayerState.paused => AudioPlayerControl(
              isPlaying: false,
              onPlayClick: () {
                _audioPlayerCubit.play();
              },
              onPauseClick: () {
                _audioPlayerCubit.pause();
              },
            ),
          AudioPlayerState.stopped => AudioPlayerControl(
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
