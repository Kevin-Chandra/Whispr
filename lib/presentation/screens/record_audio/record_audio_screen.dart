import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/local/audio_recorder/record_audio_exception.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_cubit.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_state.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_body.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_skeleton_loading.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_record_button.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';
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

  @override
  void initState() {
    super.initState();
    _recordAudioCubit = context.read<RecordAudioCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return WhisprGradientScaffold(
      gradient: WhisprGradient.purpleGradient,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 1,
                  child: StreamBuilder(
                      stream: _recordAudioCubit.recordingTimer,
                      builder: (ctx, snapshot) {
                        return snapshot.data == null
                            ? SizedBox()
                            : Text(
                                snapshot.data!.durationDisplay,
                                style: WhisprTextStyles.heading1.copyWith(
                                  color: Colors.white,
                                  fontSize: 48,
                                ),
                              );
                      }),
                ),
              ],
            ),
          ),
          BlocConsumer<RecordAudioCubit, RecordAudioState>(
            listener: (BuildContext context, RecordAudioState state) {
              print(state);
              if (state is RecordAudioErrorState) {
                if (state.error.exception is RecordAudioException) {
                  final permissionException =
                      state.error.exception as RecordAudioException;
                  final requireShortcutToAppSettings =
                      permissionException.requiresShortcutToAppSettings();
                  final requirePermissionRetry =
                      permissionException.requiresPermissionRetry();

                  WhisprSnackBar(
                          title: permissionException
                              .toLocalisedRecordAudioTitle(context),
                          subtitle: permissionException
                              .toLocalisedRecordAudioDescription(context))
                      .show(context);
                }

                _recordAudioCubit.resetState();
                return;
              }

              if (state is RecordAudioSaveSuccessState) {
                NavigationCoordinator.navigateToSaveRecording(
                  context: context,
                  audioRecordingPath: state.audioPath,
                );
              }
            },
            buildWhen: (previousState, state) {
              return (state is! RecordAudioErrorState &&
                  state is! RecordAudioSaveSuccessState);
            },
            builder: (BuildContext context, RecordAudioState state) {
              return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      WhisprAppBar(
                        title: context.strings.voice_record,
                        enableBackButton: false,
                      )
                    ];
                  },
                  physics: NeverScrollableScrollPhysics(),
                  body: AnimatedSwitcher(
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
                      RecordAudioInitialState() =>
                        const RecordAudioSkeletonLoading(),
                      RecordAudioLoadingState() =>
                        const RecordAudioSkeletonLoading(),
                      RecordAudioPausedState() => RecordAudioBody(
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
                            _recordAudioCubit.cancelRecording();
                            context.router.maybePop();
                          },
                          isRecording: false,
                        ),
                      RecordAudioRecordingState() => RecordAudioBody(
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
                            _recordAudioCubit.cancelRecording();
                            context.router.maybePop();
                          },
                          isRecording: true,
                        ),
                      _ => throw UnimplementedError(),
                    },
                  ));
            },
          ),
          Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.6,
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
            ),
          ),
        ],
      ),
    );
  }
}
