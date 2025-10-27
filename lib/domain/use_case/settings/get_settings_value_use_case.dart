import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/settings_repository.dart';

@injectable
class GetSettingsValueUseCase {
  ///
  /// A use case to get stream of settings value. Any change of
  /// settings value will trigger the stream.
  ///
  const GetSettingsValueUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  Stream<Map<String, String>> call() {
    return _settingsRepository.settingsValue();
  }
}
