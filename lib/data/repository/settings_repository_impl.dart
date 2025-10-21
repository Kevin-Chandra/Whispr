import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/domain/repository/settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(
    @Named(WhisprHiveDbKeys.settingsBoxKey) this._settingsBox,
  );

  final Box<bool> _settingsBox;

  @override
  Future<void> completeOnboarding() async {
    _settingsBox.put(WhisprHiveDbKeys.hasCompletedOnboarding, true);
  }

  @override
  Future<bool?> getHasCompletedOnboarding() async {
    return _settingsBox.get(WhisprHiveDbKeys.hasCompletedOnboarding,
        defaultValue: false);
  }
}
