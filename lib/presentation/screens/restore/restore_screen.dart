import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/restore/restore_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/restore/restore_body.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_loading_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class RestoreScreen extends StatefulWidget implements AutoRouteWrapper {
  const RestoreScreen({super.key});

  @override
  State<RestoreScreen> createState() => _RestoreScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<RestoreCubit>(
      create: (context) => RestoreCubit(),
      child: this,
    );
  }
}

class _RestoreScreenState extends State<RestoreScreen> {
  late final RestoreCubit _restoreCubit;
  bool _isShowingLoadingDialog = false;

  @override
  void initState() {
    super.initState();
    _restoreCubit = context.read<RestoreCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RestoreCubit, RestoreState, bool>(
      selector: (state) => state is RestoreLoadingState,
      builder: (context, isLoading) => PopScope(
        canPop: !isLoading,
        child: WhisprGradientScaffold(
          gradient: WhisprGradient.whiteBlueWhiteGradient,
          appBar: WhisprAppBar(
            title: context.strings.restore,
            isDarkBackground: false,
          ),
          body: BlocConsumer<RestoreCubit, RestoreState>(
            listener: (context, state) async {
              if (state is RestoreLoadingState) {
                WhisprLoadingDialog(
                  title: context.strings.exporting,
                ).show(context: context, onDismissOutside: false);
                _isShowingLoadingDialog = true;
                return;
              } else {
                if (_isShowingLoadingDialog) {
                  NavigationCoordinator.navigatorPop(context: context);
                  _isShowingLoadingDialog = false;
                }
              }

              if (state is RestoreErrorState) {
                WhisprSnackBar(
                  title: context.strings.restoreFailed,
                  subtitle: state.error.error,
                  isError: true,
                ).show(context);
                return;
              }

              if (state is RestoreSuccessState) {
                await WhisprDialog(
                  icon: Icons.check_rounded,
                  title: context.strings.restoreSuccess,
                  confirmText: context.strings.ok,
                  onConfirmPressed: () =>
                      NavigationCoordinator.navigatorPop(context: context),
                ).show(
                  context: context,
                  onDismissOutside: false,
                );

                if (context.mounted) {
                  NavigationCoordinator.navigatorPopWithRefreshResult(
                      context: context);
                }
              }
            },
            buildWhen: (previous, current) => current is IdleState,
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: WhisprDuration.stateFadeTransitionMillis,
                ),
                child: switch (state) {
                  IdleState() => RestoreBody(
                      file: state.file,
                      onSelectFilePressed: pickFile,
                      onRestorePressed:
                          state.file == null ? null : handleRestorePressed,
                      onRemoveFilePressed: _restoreCubit.removeFile,
                    ),
                  _ => throw UnimplementedError()
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void handleRestorePressed() async {
    final response = await WhisprDialog(
      icon: Icons.warning_rounded,
      title: context.strings.restore,
      message: context.strings.restoreWarning,
      confirmText: context.strings.proceed,
      onConfirmPressed: () => context.router.maybePop(true),
      dismissText: context.strings.notNow,
      onDismissPressed: () => context.router.maybePop(),
    ).show(context: context);

    if (response == true) {
      _restoreCubit.restore();
    }
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [FileConstants.archiveFileExtensionWithoutDot],
    );

    if (result != null) {
      final path = result.files.single.path!;
      _restoreCubit.setFile(File(path));
    }
  }
}
