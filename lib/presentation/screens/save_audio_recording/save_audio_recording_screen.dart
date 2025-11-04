import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/bloc/recording_tag/recording_tag_cubit.dart';
import 'package:whispr/presentation/bloc/save_audio_recording/save_audio_recording_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_body.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_skeleton_loading.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_basic_audio_player_with_waveform.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_sliver_app_bar.dart';
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
        BlocProvider<RecordingTagCubit>(
            create: (context) => RecordingTagCubit()),
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
  double _waveformWidth = 400;
  bool _isSaveSuccess = false;
  bool _isSaveCancelled = false;
  int? _samples;

  final _playerWaveStyle = PlayerWaveStyle(
    fixedWaveColor: WhisprColors.lavenderWeb,
    liveWaveColor: WhisprColors.maximumBluePurple,
    seekLineThickness: 0,
    waveCap: StrokeCap.round,
    showTop: true,
    showBottom: true,
    spacing: 4,
    scaleFactor: 200,
    waveThickness: 2,
  );

  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
    _saveAudioRecordingCubit = context.read<SaveAudioRecordingCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _waveformWidth = MediaQuery.of(context).size.width * 0.8;
      final samples = _playerWaveStyle.getSamplesForWidth(_waveformWidth);
      _samples = samples;
      _audioPlayerCubit.prepareAudio(
        widget.audioRecordingPath,
        playImmediately: false,
        extractWaveForm: true,
        noOfSamples: _samples,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }

        if (_isSaveSuccess && context.mounted) {
          NavigationCoordinator.navigatorPopWithRefreshResult(context: context);
        } else if (_isSaveCancelled && context.mounted) {
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
              WhisprSliverAppBar(
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

                NavigationCoordinator.navigatorPopWithRefreshResult(
                    context: context);
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
                SaveAudioRecordingInitialState() =>
                  _buildSaveAudioRecordingBody(),
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

  @override
  void dispose() {
    _audioPlayerCubit.close();
    super.dispose();
  }

  Widget _buildSaveAudioRecordingBody() {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerScreenState>(
      builder: (context, audioPlayerScreenState) {
        return SaveAudioRecordingBody(
          waveformWidget: WhisprBasicAudioPlayerWithWaveform(
            audioPlayerScreenState: audioPlayerScreenState,
            waveformWidth: _waveformWidth,
            onPlayClick: () {
              _audioPlayerCubit.play();
            },
            onPauseClick: () {
              _audioPlayerCubit.pause();
            },
            onErrorRetryClick: () {
              _audioPlayerCubit.prepareAudio(
                widget.audioRecordingPath,
                playImmediately: true,
                extractWaveForm: true,
                noOfSamples: _samples,
              );
            },
            playerWaveStyle: _playerWaveStyle,
          ),
          titleController: _titleController,
          titleFormKey: _formKey,
          onCancelClick: () {
            context.router.maybePop();
          },
          onSaveClick: audioPlayerScreenState is AudioPlayerLoadedState
              ? () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  final durationInt =
                      audioPlayerScreenState.controller.maxDuration;
                  final waveformData = audioPlayerScreenState.waveform;

                  _saveAudioRecordingCubit.saveAudioRecording(
                    name: _titleController.text,
                    tags: [],
                    duration: Duration(milliseconds: durationInt),
                    waveformData: waveformData,
                  );
                }
              : null,
          onMoodSelected: _saveAudioRecordingCubit.moodSelected,
          onRecordingTagChanged: _saveAudioRecordingCubit.tagChanged,
        );
      },
    );
  }
}
