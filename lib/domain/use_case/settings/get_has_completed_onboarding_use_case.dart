import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/settings_repository.dart';

@injectable
class GetHasCompletedOnboardingUseCase {
  const GetHasCompletedOnboardingUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  Future<bool> call() async {
    return await _settingsRepository.getHasCompletedOnboarding() ?? false;
  }
}
