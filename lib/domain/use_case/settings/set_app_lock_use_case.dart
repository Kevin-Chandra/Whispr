import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/settings_repository.dart';
import 'package:whispr/domain/use_case/local_auth/authenticate_local_auth_use_case.dart';

@injectable
class SetAppLockUseCase {
  ///
  /// A use case to set app lock in settings. To enable app lock, user must
  /// authenticate locally.
  ///
  const SetAppLockUseCase(
      this._settingsRepository, this._authenticateLocalAuthUseCase);

  final SettingsRepository _settingsRepository;
  final AuthenticateLocalAuthUseCase _authenticateLocalAuthUseCase;

  Future<Either<bool, FailureEntity>> call({
    required bool enableAppLock,
  }) async {
    if (!enableAppLock) {
      // Disabling app lock.
      _settingsRepository.setAppLock(enableAppLock: enableAppLock);
      return left(true);
    } else {
      // Enabling app lock.
      final response = await _authenticateLocalAuthUseCase();
      return response.fold((success) {
        if (success) {
          _settingsRepository.setAppLock(enableAppLock: enableAppLock);
          return left(true);
        } else {
          return right(FailureEntity(error: 'Authentication failed'));
        }
      }, (error) {
        return right(error);
      });
    }
  }
}
