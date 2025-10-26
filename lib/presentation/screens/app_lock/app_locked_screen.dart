import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart' hide AppLockState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/local/local_auth/local_authentication_exception.dart';
import 'package:whispr/presentation/bloc/app_lock/app_lock_cubit.dart';
import 'package:whispr/presentation/widgets/whispr_snackbar.dart';
import 'package:whispr/util/extensions.dart';

class AppLockedScreen extends StatefulWidget {
  const AppLockedScreen({super.key});

  @override
  State<AppLockedScreen> createState() => _AppLockedScreenState();
}

class _AppLockedScreenState extends State<AppLockedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppLockCubit>(
      create: (BuildContext context) => AppLockCubit(),
      child: BlocConsumer<AppLockCubit, AppLockState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            AppLock.of(context)?.didUnlock();
            return;
          }

          if (state is ErrorState) {
            if (state.error.exception != null &&
                state.error.exception is LocalAuthenticationException) {
              final errorMessage = switch (
                  state.error.exception as LocalAuthenticationException) {
                BiometricsNotEnrolledException() =>
                  context.strings.lockScreenNotSetUpMessage,
                NoBiometricHardwareException() =>
                  context.strings.biometricHardwareNotAvailableMessage,
                TemporaryLockoutException() =>
                  context.strings.temporaryLockoutMessage,
                UnknownException() => context.strings.unknownErrorMessage,
                UserCancelledException() => context.strings.unknownErrorMessage,
              };
              WhisprSnackBar(
                title: context.strings.error,
                subtitle: errorMessage,
                isError: true,
              ).show(context);

              context.read<AppLockCubit>().resetState();
              return;
            } else {
              WhisprSnackBar(
                      title: context.strings.unknownErrorMessage, isError: true)
                  .show(context);

              context.read<AppLockCubit>().resetState();
              return;
            }
          }
        },
        builder: (context, state) => Scaffold(
          body: Container(
            color: Colors.green,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AppLockCubit>().authenticate();
                },
                child: Text("Locked"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
