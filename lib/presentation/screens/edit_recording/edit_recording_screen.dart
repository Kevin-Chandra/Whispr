import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/bloc/edit_recording/edit_audio_recording_cubit.dart';
import 'package:whispr/presentation/bloc/recording_tag/recording_tag_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/edit_recording/edit_recording_body.dart';
import 'package:whispr/presentation/screens/save_audio_recording/save_audio_recording_skeleton_loading.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_sliver_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class EditRecordingScreen extends StatefulWidget implements AutoRouteWrapper {
  const EditRecordingScreen({
    super.key,
    @PathParam() required this.audioRecordingId,
  });

  final String audioRecordingId;

  @override
  State<EditRecordingScreen> createState() => _EditRecordingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordingTagCubit>(
            create: (context) => RecordingTagCubit()),
        BlocProvider<EditAudioRecordingCubit>(
          create: (context) => EditAudioRecordingCubit(audioRecordingId),
        ),
        BlocProvider<AudioPlayerCubit>(
          create: (context) => AudioPlayerCubit(),
        ),
      ],
      child: this,
    );
  }
}

class _EditRecordingScreenState extends State<EditRecordingScreen> {
  late final EditAudioRecordingCubit _editAudioRecordingCubit;
  bool _isUpdatedSuccess = false;

  @override
  void initState() {
    super.initState();
    _editAudioRecordingCubit = context.read<EditAudioRecordingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }

        if (_isUpdatedSuccess && context.mounted) {
          NavigationCoordinator.navigatorPopWithRefreshResult(context: context);
          return;
        }

        final shouldPop = await WhisprDialog(
          title: context.strings.discardChanges,
          message: context.strings.changesWillBeLost,
          confirmText: context.strings.discard,
          icon: Icons.delete_rounded,
          onConfirmPressed: () {
            context.router.maybePop(true);
          },
          dismissText: context.strings.cancel,
          onDismissPressed: () {
            context.router.maybePop();
          },
          isNegativeAction: true,
        ).show<bool>(context: context);

        if (shouldPop == true && context.mounted) {
          NavigationCoordinator.navigatorPop(context: context);
        }
      },
      child: WhisprGradientScaffold(
        gradient: WhisprGradient.whiteBlueWhiteGradient,
        body: SafeArea(
          bottom: false,
          child: NestedScrollView(
              physics: NeverScrollableScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  WhisprSliverAppBar(
                    title: context.strings.voice_record,
                    isDarkBackground: false,
                    enableBackButton: false,
                  )
                ];
              },
              body: BlocConsumer<EditAudioRecordingCubit,
                  EditAudioRecordingState>(
                listener: (ctx, state) {
                  if (state is EditAudioRecordingErrorState) {
                    WhisprSnackBar(
                      title: context.strings.error,
                      subtitle: state.error.error,
                      isError: true,
                    ).show(context);
                    return;
                  }

                  if (state is UpdateAudioRecordingSuccessState) {
                    _isUpdatedSuccess = true;
                    WhisprSnackBar(
                      title: context.strings.recordingSavedSuccessfully,
                    ).show(context);
                    context.router.maybePop();
                    return;
                  }
                },
                buildWhen: (previous, current) =>
                    current is EditAudioRecordingLoadedState ||
                    current is EditAudioRecordingLoadingState ||
                    current is EditAudioRecordingInitialState,
                builder: (ctx, state) {
                  return AnimatedSwitcher(
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
                      EditAudioRecordingInitialState() => SizedBox(),
                      EditAudioRecordingLoadingState() =>
                        SaveAudioRecordingSkeletonLoading(),
                      EditAudioRecordingLoadedState() =>
                        EditRecordingBodyWrapper(
                          audioRecording: state.audioRecording,
                          onSaveClicked:
                              _editAudioRecordingCubit.updateAudioRecording,
                          onMoodSelected: _editAudioRecordingCubit.moodSelected,
                          onRecordingTagsChanged:
                              _editAudioRecordingCubit.tagChanged,
                          onCancelClick: () {
                            context.router.maybePop();
                          },
                        ),
                      _ => throw UnimplementedError(),
                    },
                  );
                },
              )),
        ),
      ),
    );
  }
}
