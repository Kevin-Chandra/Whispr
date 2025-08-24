import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/local/record_audio_exception.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_cubit.dart';
import 'package:whispr/presentation/bloc/record_audio/record_audio_state.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_body.dart';
import 'package:whispr/presentation/screens/record_audio/record_audio_skeleton_loading.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';
import 'package:whispr/util/record_audio_exception_util.dart';

@RoutePage()
class RecordAudioScreen extends StatefulWidget implements AutoRouteWrapper {
  const RecordAudioScreen({super.key});

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<RecordAudioCubit>(
      create: (context) => RecordAudioCubit(),
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
      body: BlocConsumer<RecordAudioCubit, RecordAudioState>(
        listener: (BuildContext context, RecordAudioState state) {
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
        },
        buildWhen: (previousState, state) {
          return state is RecordAudioInitialState ||
              state is RecordAudioLoadingState;
        },
        builder: (BuildContext context, RecordAudioState state) {
          return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [WhisprAppBar(title: context.strings.voice_record)];
              },
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
                  (RecordAudioState state)
                      when state is RecordAudioInitialState =>
                    RecordAudioBody(
                      onRecordClick: () {
                        _recordAudioCubit.recordAudio();
                      },
                      onOpenMicrophoneAppSettingsClick: () {
                        _recordAudioCubit.openMicrophoneAppSettings();
                      },
                    ),
                  (RecordAudioState state)
                      when state is RecordAudioLoadingState =>
                    RecordAudioSkeletonLoading(),
                  _ => throw "Invalid state $state invoked."
                },
              ));
        },
      ),
    );
  }
}
