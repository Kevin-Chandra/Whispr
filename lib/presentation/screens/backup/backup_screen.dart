import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/backup/backup_cubit.dart';
import 'package:whispr/presentation/bloc/recording_count/recording_count_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/screens/backup/backup_body.dart';
import 'package:whispr/presentation/screens/backup/recording_count_text.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_loading_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

import 'backup_skeleton_loading.dart';

@RoutePage()
class BackupScreen extends StatefulWidget implements AutoRouteWrapper {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BackupCubit>(create: (context) => BackupCubit()),
        BlocProvider<RecordingCountCubit>(
            create: (context) => RecordingCountCubit()),
      ],
      child: this,
    );
  }
}

class _BackupScreenState extends State<BackupScreen> {
  late final BackupCubit _backupCubit;
  late final RecordingCountCubit _recordingCountCubit;

  final _fileNameController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isShowingLoadingDialog = false;

  @override
  void initState() {
    super.initState();
    _backupCubit = context.read<BackupCubit>();
    _recordingCountCubit = context.read<RecordingCountCubit>();
    _fileNameController.addListener(_fileNameListener);
  }

  void _fileNameListener() {
    setState(() {
      _isButtonEnabled = _fileNameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WhisprGradientScaffold(
      resizeToAvoidBottomInset: true,
      gradient: WhisprGradient.whiteBlueWhiteGradient,
      appBar: WhisprAppBar(
        title: context.strings.backup,
        isDarkBackground: false,
      ),
      body: BlocConsumer<BackupCubit, BackupState>(
        listener: (context, state) async {
          if (state is IdleState) {
            _recordingCountCubit.calculateCount(state.startDate, state.endDate);
            return;
          }

          if (state is BackupLoadingState) {
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

          if (state is BackupErrorState) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            WhisprSnackBar(
              title: context.strings.backupFailed,
              subtitle: state.error.error,
              isError: true,
            ).show(context);
            return;
          }

          if (state is BackupSuccessState) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            WhisprSnackBar(title: context.strings.backupSuccess, isError: false)
                .show(context);
            state.file.share(context: context);
            return;
          }
        },
        buildWhen: (old, current) =>
            current is IdleState || current is InitialLoadingState,
        builder: (context, state) {
          return PopScope(
            canPop: state is! BackupLoadingState,
            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: WhisprDuration.stateFadeTransitionMillis,
              ),
              child: switch (state) {
                IdleState() => BackupBody(
                    fileNameController: _fileNameController,
                    firstDate: state.recordingFirstDate,
                    startDateValue: state.startDate,
                    endDateValue: state.endDate,
                    onStartDateChanged: _backupCubit.setStartDate,
                    onEndDateChanged: _backupCubit.setEndDate,
                    onBackupPressed: _isButtonEnabled
                        ? () {
                            _backupCubit.startBackup(
                                fileName: _fileNameController.text);
                          }
                        : null,
                    recordCountWidget: RecordingCountText(),
                  ),
                InitialLoadingState() => BackupSkeletonLoading(),
                _ => SizedBox()
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _fileNameController.removeListener(_fileNameListener);
    _fileNameController.dispose();
    super.dispose();
  }
}
