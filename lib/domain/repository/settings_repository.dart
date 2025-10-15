abstract class SettingsRepository {
  Future<void> completeOnboarding();

  Future<bool?> getHasCompletedOnboarding();
}
