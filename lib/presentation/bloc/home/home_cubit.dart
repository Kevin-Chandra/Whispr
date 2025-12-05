import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/use_case/settings/get_is_app_lock_enabled_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(IdleState()) {
    _checkAppLockEnabled();
  }

  late bool _appLockedEnabled;

  bool get appLockedEnabled => _appLockedEnabled;

  void refreshAudioRecordings() {
    safeEmit(RefreshAudioRecordings());

    // Reset the state.
    safeEmit(IdleState());
  }

  void stopPlayingAudio() {
    safeEmit(ResetAudioPlayer());

    // Reset the state.
    safeEmit(IdleState());
  }

  Future<void> refreshAppLockEnabled() async {
    _appLockedEnabled = await di.get<GetIsAppLockEnabledUseCase>().call();
  }

  void _checkAppLockEnabled() async {
    await refreshAppLockEnabled();
    safeEmit(AppLockConfigLoadedState());

    // Reset state.
    safeEmit(IdleState());
  }
}
