import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/bloc/journal/journal_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/journal/journal_body.dart';
import 'package:whispr/presentation/screens/journal/journal_skeleton_loading.dart';
import 'package:whispr/presentation/widgets/whispr_date_timeline_picker.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class JournalScreen extends StatefulWidget implements AutoRouteWrapper {
  const JournalScreen({
    super.key,
  });

  @override
  State<JournalScreen> createState() => _JournalScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioPlayerCubit>(create: (context) => AudioPlayerCubit()),
      ],
      child: this,
    );
  }
}

class _JournalScreenState extends State<JournalScreen> {
  late JournalCubit _journalCubit;

  @override
  void initState() {
    super.initState();
    _journalCubit = context.read<JournalCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: WhisprDateTimelinePicker(
            selectedDate: _journalCubit.selectedDate,
            onDateChange: (date) {
              _journalCubit.getRecordingsByDate(date);
              setState(() {});
            },
          ),
        ),
        Expanded(flex: 1, child: _buildJournalList()),
      ],
    );
  }

  Widget _buildJournalList() {
    return BlocConsumer<JournalCubit, JournalState>(
      listener: (context, state) {
        if (state is JournalErrorState) {
          WhisprSnackBar(
            title: state.error.error,
            subtitle: state.error.errorDescription,
            isError: true,
          ).show(context);
          return;
        }

        if (state is JournalDeleteSuccessState) {
          WhisprSnackBar(
            title: context.strings.audioRecordingSuccessfullyDeleted,
          ).show(context);
          _journalCubit.refresh();
          return;
        }
      },
      buildWhen: (previous, current) =>
          current is JournalLoadingState || current is JournalLoadedState,
      builder: (context, state) {
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
            JournalLoadingState() => const JournalSkeletonLoading(),
            JournalLoadedState() => JournalBody(
                audioRecordings: state.audioRecordings,
                onRefresh: _journalCubit.refresh,
                onFavouritePressed: (audioRecording) {
                  _journalCubit.addToFavourite(audioRecording.id);
                },
                onAddNewRecording: () {
                  NavigationCoordinator.navigateToHomeTab(context: context);
                },
                onEditPressed: (_) {},
                onDeletePressed: (audioRecording) {
                  WhisprDialog(
                    icon: Icons.delete_rounded,
                    title: context.strings.deleteFile,
                    message: context.strings
                        .areYouSureYouWantToDeleteFile(audioRecording.name),
                    confirmText: context.strings.delete,
                    onConfirmPressed: () {
                      _journalCubit.deleteAudioRecording(audioRecording);
                      context.router.maybePop();
                    },
                    dismissText: context.strings.cancel,
                    onDismissPressed: () {
                      context.router.maybePop();
                    },
                    isNegativeAction: true,
                  ).show(context: context);
                },
              ),
            _ => SizedBox(),
          },
        );
      },
    );
  }
}
