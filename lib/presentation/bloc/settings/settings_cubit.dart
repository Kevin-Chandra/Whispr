import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/use_case/settings/get_settings_value_use_case.dart';
import 'package:whispr/domain/use_case/settings/set_app_lock_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(IdleState()) {
    _getSettingsValue();
  }

  late StreamSubscription<Map<String, String>> _settingsSubscription;
  final _appLockSettingsController = StreamController<bool>.broadcast();

  Stream<bool> get appLockStream => _appLockSettingsController.stream;

  void setAppLock(bool enableAppLock) async {
    final response =
        await di.get<SetAppLockUseCase>().call(enableAppLock: enableAppLock);
    response.fold((success) {
      safeEmit(SettingsChangedState());
    }, (error) {
      safeEmit(SettingsErrorState(error: error));
    });
  }

  void _getSettingsValue() {
    _settingsSubscription =
        di.get<GetSettingsValueUseCase>().call().listen((data) {
      final enabled = data[WhisprHiveDbKeys.appLockEnabled]
          .safeParseBool(defaultValue: false);
      _appLockSettingsController.add(enabled);
    });
  }

  void resetState() {
    safeEmit(IdleState());
  }

  @override
  Future<void> close() {
    _settingsSubscription.cancel();
    _appLockSettingsController.close();
    return super.close();
  }
}
