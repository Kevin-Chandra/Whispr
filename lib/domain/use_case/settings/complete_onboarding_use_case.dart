import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/settings_repository.dart';

@injectable
class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  Future<void> call() async {
    return await _settingsRepository.completeOnboarding();
  }
}
