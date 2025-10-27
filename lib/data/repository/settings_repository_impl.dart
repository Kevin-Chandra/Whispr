import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/domain/repository/settings_repository.dart';
import 'package:whispr/util/extensions.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(
    @Named(WhisprHiveDbKeys.settingsBoxKey) this._settingsBox,
  );

  final Box<String> _settingsBox;

  @override
  Future<void> completeOnboarding() async {
    _settingsBox.put(WhisprHiveDbKeys.hasCompletedOnboarding, true.toString());
  }

  @override
  Future<bool?> getHasCompletedOnboarding() async {
    final valueString =
        _settingsBox.get(WhisprHiveDbKeys.hasCompletedOnboarding);
    return valueString.safeParseBool(defaultValue: false);
  }

  @override
  Future<void> setAppLock({required bool enableAppLock}) async {
    await _settingsBox.put(
        WhisprHiveDbKeys.appLockEnabled, enableAppLock.toString());
  }

  @override
  Stream<Map<String, String>> settingsValue() {
    return _settingsBox
        .listenable()
        .toValueStream(replayValue: true)
        .map((box) => box.toMap().entries)
        .map((e) => Map.fromEntries(e.map((e) => MapEntry(e.key, e.value))));
  }

  @override
  Future<bool> isAppLockEnabled() async {
    final valueString = _settingsBox.get(WhisprHiveDbKeys.appLockEnabled);
    return valueString.safeParseBool(defaultValue: false);
  }
}
