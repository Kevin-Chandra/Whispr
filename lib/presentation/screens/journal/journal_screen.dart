import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/home/home_cubit.dart';
import 'package:whispr/presentation/bloc/journal/journal_cubit.dart';
import 'package:whispr/presentation/bloc/journal_header/journal_header_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/journal/journal_body.dart';
import 'package:whispr/presentation/screens/journal/journal_header.dart';
import 'package:whispr/presentation/screens/journal/journal_header_skeleton_loading.dart';
import 'package:whispr/presentation/screens/journal/journal_skeleton_loading.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class JournalScreen extends StatefulWidget {
  const JournalScreen({
    super.key,
  });

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late final JournalCubit _journalCubit;
  late final JournalHeaderCubit _journalHeaderCubit;

  @override
  void initState() {
    super.initState();
    _journalCubit = context.read<JournalCubit>();
    _journalHeaderCubit = context.read<JournalHeaderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: BlocConsumer<JournalHeaderCubit, JournalHeaderState>(
            listener: (context, state) {
              if (state is JournalHeaderErrorState) {
                WhisprSnackBar(
                  title: state.error.error,
                  subtitle: state.error.errorDescription,
                  isError: true,
                ).show(context);
                return;
              }
            },
            buildWhen: (old, current) =>
                current is JournalHeaderLoadedState ||
                current is JournalHeaderLoadingState,
            builder: (context, state) {
              return switch (state) {
                JournalHeaderLoadingState() => JournalHeaderSkeletonLoading(),
                JournalHeaderLoadedState() => JournalHeader(
                    minDate: state.firstAudioRecordingDate,
                    markedDates: state.audioRecordingDates.toSet(),
                    onDateChange: (date) {
                      _journalCubit.getRecordingsByDate(date);
                    },
                  ),
                _ => throw UnimplementedError(),
              };
            },
          ),
        ),
        Expanded(flex: 1, child: _JournalList()),
      ],
    );
  }
}

class _JournalList extends StatefulWidget {
  const _JournalList();

  @override
  State<_JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<_JournalList> {
  late final JournalCubit _journalCubit;
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _journalCubit = context.read<JournalCubit>();
    _homeCubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
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

        if (state is JournalAddToFavouriteSuccessState) {
          _homeCubit.refreshAudioRecordings();
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
                onEditPressed: (audioRecording) async {
                  final shouldRefresh =
                      await NavigationCoordinator.navigateToEditScreen(
                    context: context,
                    audioRecordingId: audioRecording.id,
                  );
                  if (shouldRefresh == true) {
                    _homeCubit.refreshAudioRecordings();
                  }
                },
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
