import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/local/local_auth/local_authentication_exception.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/local_auth/authenticate_local_auth_use_case.dart';
import 'package:whispr/domain/use_case/local_auth/open_lock_screen_settings_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'app_lock_state.dart';

class AppLockCubit extends Cubit<AppLockState> {
  AppLockCubit() : super(IdleState());

  void authenticate() async {
    final response = await di.get<AuthenticateLocalAuthUseCase>().call();

    return response.fold(
      (success) {
        if (success) {
          safeEmit(AuthenticatedState());
        }
      },
      (error) {
        if (error.exception is LocalAuthenticationException) {
          return switch (error.exception!) {
            BiometricsNotEnrolledException() => openLockScreenSettings(),
            // Don't treat this as an error.
            UserCancelledException() => resetState(),
            Exception() => safeEmit(ErrorState(error: error)),
          };
        }
        safeEmit(ErrorState(error: error));
      },
    );
  }

  void openLockScreenSettings() {
    di.get<OpenLockScreenSettingsUseCase>().call();
  }

  void resetState() {
    safeEmit(IdleState());
  }
}
