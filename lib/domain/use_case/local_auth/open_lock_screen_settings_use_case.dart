import 'package:injectable/injectable.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';

@injectable
class OpenLockScreenSettingsUseCase {
  void call() {
    switch (OpenSettingsPlus.shared) {
      case OpenSettingsPlusAndroid():
        {
          OpenSettingsPlusAndroid().biometricEnroll();
          break;
        }
      case OpenSettingsPlusIOS():
        {
          OpenSettingsPlusIOS().faceIDAndPasscode();
          break;
        }
    }
  }
}
