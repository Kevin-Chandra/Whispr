import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/local/audio_recorder/record_audio_exception.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_cubit.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_state.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_controls.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_controls_skeleton_loading.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_state_text.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_state_text_skeleton_loading.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_timer_text.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_timer_text_skeleton_loading.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_record_button.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/extensions.dart';
import 'package:whispr/util/record_audio_exception_util.dart';

@RoutePage()
class RecordAudioScreen extends StatefulWidget implements AutoRouteWrapper {
  const RecordAudioScreen({
    super.key,
    @PathParam() required this.startImmediately,
  });

  final bool startImmediately;

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<RecordAudioCubit>(
      create: (context) => RecordAudioCubit(startImmediately),
      child: this,
    );
  }
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  late RecordAudioCubit _recordAudioCubit;
  bool _isRecordingCancelled = false;

  @override
  void initState() {
    super.initState();
    _recordAudioCubit = context.read<RecordAudioCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }

        if (_isRecordingCancelled && context.mounted) {
          NavigationCoordinator.navigatorPop(context: context);
        } else {
          await WhisprDialog(
            title: context.strings.discardRecording,
            message: context.strings.recordingWillNotBeSaved,
            confirmText: context.strings.discard,
            icon: Icons.delete_rounded,
            onConfirmPressed: () {
              _recordAudioCubit.cancelRecording();
              context.router.maybePop();
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
        gradient: WhisprGradient.purpleGradient,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              WhisprAppBar(
                title: context.strings.voice_record,
                enableBackButton: false,
              )
            ];
          },
          physics: NeverScrollableScrollPhysics(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                _resolveStateText(),
                _resolveRecordButton(),
                _resolveRecordingTimer(),
                BlocConsumer<RecordAudioCubit, RecordAudioState>(
                  listener:
                      (BuildContext context, RecordAudioState state) async {
                    if (state is RecordAudioErrorState) {
                      // Permission exception.
                      if (state.error.exception is RecordAudioException) {
                        final permissionException =
                            state.error.exception as RecordAudioException;
                        final requireShortcutToAppSettings =
                            permissionException.requiresShortcutToAppSettings();

                        final shouldPop = await WhisprDialog(
                          icon: Icons.mic_off_rounded,
                          title: permissionException
                              .toLocalisedRecordAudioTitle(context),
                          message: permissionException
                              .toLocalisedRecordAudioDescription(context),
                          confirmText:
                              permissionException.primaryButtonLabel(context),
                          onConfirmPressed: () {
                            context.router.pop(true);
                            if (requireShortcutToAppSettings) {
                              _recordAudioCubit.openMicrophoneAppSettings();
                            }
                          },
                          dismissText: context.strings.notNow,
                          onDismissPressed: () {
                            context.router.pop(true);
                          },
                        ).show<bool>(
                          context: context,
                          onDismissOutside: false,
                        );

                        if (shouldPop == true && context.mounted) {
                          NavigationCoordinator.navigatorPop(context: context);
                        }
                      } else {
                        // Other exception.
                        WhisprSnackBar(
                          title: context.strings.recorderError,
                          subtitle: state.error.error,
                          isError: true,
                        ).show(context);
                      }

                      _recordAudioCubit.resetState();
                      return;
                    }

                    if (state is RecordAudioCancelledState) {
                      _isRecordingCancelled = true;
                      context.router.maybePop();
                      return;
                    }

                    if (state is RecordAudioSaveSuccessState) {
                      NavigationCoordinator.navigateToSaveRecording(
                        context: context,
                        audioRecordingPath: state.audioPath,
                      );
                      return;
                    }
                  },
                  buildWhen: (previousState, state) {
                    return (state is! RecordAudioErrorState &&
                        state is! RecordAudioCancelledState &&
                        state is! RecordAudioSaveSuccessState);
                  },
                  builder: (BuildContext context, RecordAudioState state) {
                    return switch (state) {
                      RecordAudioInitialState() =>
                        const RecordAudioControlsSkeletonLoading(),
                      RecordAudioLoadingState() =>
                        const RecordAudioControlsSkeletonLoading(),
                      RecordAudioPausedState() => RecordAudioControls(
                          onSaveClick: () {
                            _recordAudioCubit.stopRecording();
                          },
                          onPauseClick: () {
                            _recordAudioCubit.pauseRecording();
                          },
                          onResumeClick: () {
                            _recordAudioCubit.resumeRecording();
                          },
                          onCancelClick: () {
                            context.router.maybePop();
                          },
                          isRecording: false,
                        ),
                      RecordAudioRecordingState() => RecordAudioControls(
                          onSaveClick: () {
                            _recordAudioCubit.stopRecording();
                          },
                          onPauseClick: () {
                            _recordAudioCubit.pauseRecording();
                          },
                          onResumeClick: () {
                            _recordAudioCubit.resumeRecording();
                          },
                          onCancelClick: () {
                            context.router.maybePop();
                          },
                          isRecording: true,
                        ),
                      _ => throw UnimplementedError(),
                    };
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resolveStateText() {
    return BlocBuilder<RecordAudioCubit, RecordAudioState>(
      buildWhen: (previousState, state) {
        return (state is! RecordAudioErrorState &&
            state is! RecordAudioSaveSuccessState &&
            state is! RecordAudioCancelledState);
      },
      builder: (BuildContext context, RecordAudioState state) {
        return switch (state) {
          RecordAudioInitialState() => RecordAudioStateTextSkeletonLoading(),
          RecordAudioLoadingState() => RecordAudioStateTextSkeletonLoading(),
          RecordAudioPausedState() => RecordAudioStateText(
              isRecording: false,
            ),
          RecordAudioRecordingState() => RecordAudioStateText(
              isRecording: true,
            ),
          _ => throw UnimplementedError(),
        };
      },
    );
  }

  Widget _resolveRecordButton() {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SizedBox.square(
          dimension: constraints.maxWidth * 0.6,
          child: StreamBuilder(
            stream: _recordAudioCubit.levels,
            builder: (context, snapshot) {
              return WhisprRecordButton(
                amplitudeLevel: snapshot.data,
                onClick: () {
                  _recordAudioCubit.pauseResumeRecording();
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _resolveRecordingTimer() {
    return BlocBuilder<RecordAudioCubit, RecordAudioState>(
      buildWhen: (previousState, state) {
        return (state is! RecordAudioErrorState &&
            state is! RecordAudioCancelledState &&
            state is! RecordAudioSaveSuccessState);
      },
      builder: (BuildContext context, RecordAudioState state) {
        return switch (state) {
          RecordAudioInitialState() => RecordAudioTimerTextSkeletonLoading(),
          RecordAudioLoadingState() => RecordAudioTimerTextSkeletonLoading(),
          _ => StreamBuilder(
              stream: _recordAudioCubit.recordingTimer,
              builder: (ctx, snapshot) =>
                  RecordAudioTimerText(duration: snapshot.data),
            )
        };
      },
    );
  }
}
