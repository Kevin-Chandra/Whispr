import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/presentation/bloc/clear_all_data/clear_all_data_cubit.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_app_bar.dart';
import 'package:whispr/presentation/widgets/whispr_dialog.dart';
import 'package:whispr/presentation/widgets/whispr_gradient_scaffold.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

import 'clear_all_data_body.dart';
import 'clear_all_data_loading_skeleton.dart';

@RoutePage()
class ClearAllDataScreen extends StatefulWidget implements AutoRouteWrapper {
  const ClearAllDataScreen({super.key});

  @override
  State<ClearAllDataScreen> createState() => _ClearAllDataScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ClearAllDataCubit>(
      create: (context) => ClearAllDataCubit(),
      child: this,
    );
  }
}

class _ClearAllDataScreenState extends State<ClearAllDataScreen> {
  late final ClearAllDataCubit _clearAllDataCubit;

  @override
  void initState() {
    super.initState();
    _clearAllDataCubit = context.read<ClearAllDataCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return WhisprGradientScaffold(
      resizeToAvoidBottomInset: true,
      gradient: WhisprGradient.whiteBlueWhiteGradient,
      appBar: WhisprAppBar(
        title: context.strings.clearAllData,
        isDarkBackground: false,
      ),
      body: BlocConsumer<ClearAllDataCubit, ClearAllDataState>(
        listener: (context, state) async {
          if (state is ClearAllDataErrorState) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            WhisprSnackBar(
              title: context.strings.somethingWentWrong,
              subtitle: state.error.error,
              isError: true,
            ).show(context);

            _clearAllDataCubit.resetState();
            return;
          }

          if (state is ClearAllDataSuccessState) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            _clearAllDataCubit.resetState();

            await WhisprDialog(
              icon: Icons.delete_sweep_rounded,
              title: context.strings.clearAllDataSuccess,
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
        buildWhen: (previous, current) =>
            current is ClearAllDataLoadingState || current is IdleState,
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(
              milliseconds: WhisprDuration.stateFadeTransitionMillis,
            ),
            child: PopScope(
              canPop: state is! ClearAllDataLoadingState,
              child: switch (state) {
                IdleState() => ClearAllDataBody(
                    onDeletePressed: handleDeletePressed,
                  ),
                ClearAllDataLoadingState() =>
                  const ClearAllDataLoadingSkeleton(),
                _ => throw UnimplementedError()
              },
            ),
          );
        },
      ),
    );
  }

  void handleDeletePressed() async {
    final response = await WhisprDialog(
      icon: Icons.delete_forever_rounded,
      title: context.strings.deleteForever,
      message: context.strings.clearAllDataWarning,
      confirmText: context.strings.delete,
      onConfirmPressed: () => context.router.maybePop(true),
      dismissText: context.strings.cancel,
      onDismissPressed: () => context.router.maybePop(),
      isNegativeAction: true,
    ).show(context: context);

    if (response == true) {
      _clearAllDataCubit.deleteAllData();
    }
  }
}
