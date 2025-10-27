import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/settings_repository.dart';

@injectable
class GetIsAppLockEnabledUseCase {
  ///
  /// A use case to check if app lock is enabled.
  ///
  const GetIsAppLockEnabledUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  Future<bool> call() {
    return _settingsRepository.isAppLockEnabled();
  }
}
