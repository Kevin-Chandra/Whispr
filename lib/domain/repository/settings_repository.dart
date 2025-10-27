abstract class SettingsRepository {
  Future<void> completeOnboarding();

  Future<bool?> getHasCompletedOnboarding();

  Future<bool> isAppLockEnabled();

  Stream<Map<String, String>> settingsValue();

  Future<void> setAppLock({required bool enableAppLock});
}
