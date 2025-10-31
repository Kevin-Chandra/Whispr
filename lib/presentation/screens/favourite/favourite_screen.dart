import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/favourite/favourite_cubit.dart';
import 'package:whispr/presentation/bloc/home/home_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/favourite/favourite_body.dart';
import 'package:whispr/presentation/screens/favourite/favourite_skeleton_loading.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late final FavouriteCubit _favouriteCubit;
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _favouriteCubit = context.read<FavouriteCubit>();
    _homeCubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteErrorState) {
          WhisprSnackBar(
            title: state.error.error,
            subtitle: state.error.errorDescription,
            isError: true,
          ).show(context);
          return;
        }

        if (state is FavouriteAddedSuccessState) {
          _favouriteCubit.refresh();
          _homeCubit.refreshAudioRecordings();
        }

        if (state is FavouriteDeleteSuccessState) {
          WhisprSnackBar(
            title: context.strings.audioRecordingSuccessfullyDeleted,
          ).show(context);
          _favouriteCubit.refresh();
          return;
        }
      },
      buildWhen: (old, current) =>
          current is FavouriteLoadingState || current is FavouriteLoadedState,
      builder: (context, state) {
        return switch (state) {
          FavouriteLoadingState() => const FavouriteSkeletonLoading(),
          FavouriteLoadedState() => FavouriteBody(
              audioRecordings: state.audioRecordings,
              onEditPressed: (_) {},
              onDeletePressed: (audioRecording) {
                WhisprDialog(
                  icon: Icons.delete_rounded,
                  title: context.strings.deleteFile,
                  message: context.strings
                      .areYouSureYouWantToDeleteFile(audioRecording.name),
                  confirmText: context.strings.delete,
                  onConfirmPressed: () {
                    _favouriteCubit.deleteAudioRecording(audioRecording);
                    context.router.maybePop();
                  },
                  dismissText: context.strings.cancel,
                  onDismissPressed: () {
                    context.router.maybePop();
                  },
                  isNegativeAction: true,
                ).show(context: context);
              },
              onRefreshPressed: _favouriteCubit.refresh,
              onFavouritePressed: (audioRecording) {
                _favouriteCubit.addToFavourite(audioRecording.id);
              },
              onAddFavouritePressed: () {
                NavigationCoordinator.navigateToJournalTab(context: context);
              },
            ),
          _ => throw UnimplementedError(),
        };
      },
    );
  }
}
